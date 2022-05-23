
generic module CoreControlLockC()
{
	uses interface CoreControl;
	uses interface StateLock;
}
implementation
{
	event void CoreControl.busy()
	{
		//ADBG(DBG_LEV, "CoreControl.busy\n");
		call StateLock.lock();
	}

	event void CoreControl.free()
	{
		//ADBG(DBG_LEV, "CoreControl.free\n");
		call StateLock.unlock();
	}
}

