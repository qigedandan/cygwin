
generic module QuickRouteSmartQueueC(uint16_t QUEUE_LENGTH)
{
    provides interface SmartQueue;

}

implementation
{
    UINT8_PM0_T  mQueue[QUEUE_LENGTH];
    uint16_t mHead        = 0;
    uint16_t mTail        = 0;
    uint16_t mNbElts      = 0;
    uint16_t mNbFreeBytes = QUEUE_LENGTH;

    command uint16_t SmartQueue.nbElements()
    {
        return mNbElts;
    }

    command void* SmartQueue.enqueue(uint8_t len)
    {
        uint8_t *newElmt;


       atomic {
        // We require one more free byte because we need to store the length of the new entry
        ++len;
        if(len > mNbFreeBytes)
            return NULL;

        // The bytes must be contiguous!
        if(len > (QUEUE_LENGTH - mTail))
        {
            if(len > mHead)
                return NULL;

            // There's not enough space after the tail, but we can use the free bytes at the beginning of the array
            mQueue[mTail]  = 0;
            mNbFreeBytes  -= (QUEUE_LENGTH - mTail);
            mTail          = 0;
        }

        newElmt = &(mQueue[mTail+1]);

        ++mNbElts;
        mQueue[mTail]  = len;
        mTail         += len;
        mNbFreeBytes  -= len;

        if(mTail == QUEUE_LENGTH)
            mTail = 0;
/*
		call StdOut.print("\r\nLast: mHead=");
		call StdOut.printHex(mHead);
		call StdOut.print(", mTail=");
		call StdOut.printHex(m);
*/  
        return newElmt;
		}
    }

    command void SmartQueue.dequeue()
    {
	   atomic {
        if(mNbFreeBytes != QUEUE_LENGTH)
        {
            --mNbElts;
            mNbFreeBytes += mQueue[mHead];
            mHead        += mQueue[mHead];

            if(mNbFreeBytes == QUEUE_LENGTH)
            {
                mHead = 0;
                mTail = 0;
            }
            else if(mHead == QUEUE_LENGTH)
                mHead = 0;
            else if(mQueue[mHead] == 0)
            {
                mNbFreeBytes += (QUEUE_LENGTH - mHead);
                mHead         = 0;
            }
        }
		}
    }

    command uint8_t SmartQueue.headLength()
    {
        return mQueue[mHead]-1;
    }

    command void* SmartQueue.head()
    {
        return &(mQueue[mHead+1]);
    }

    command bool SmartQueue.isEmpty()
    {
        return (mNbFreeBytes == QUEUE_LENGTH) ? TRUE : FALSE;
    }

    command bool SmartQueue.canStore(uint8_t len)
    {
        return ((len+1) <= mNbFreeBytes && ((len+1) <= (QUEUE_LENGTH - mTail) || (len+1) <= mHead)) ? TRUE : FALSE;
    }
}
