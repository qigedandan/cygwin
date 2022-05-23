#include "Wsn.h"
configuration QueuedTransmitC
{
    provides interface Init;
    provides interface Send[uint8_t id];
    provides interface Receive[uint8_t id];
    
    uses interface AMSend[uint8_t id];
    uses interface AMPacket;
    uses interface Packet;
    uses interface Receive as SubReceive[uint8_t id];
}
implementation
{
    components QueuedTransmitP;

    Send = QueuedTransmitP;
    Receive = QueuedTransmitP;
    AMSend = QueuedTransmitP;
    AMPacket = QueuedTransmitP;
    Packet = QueuedTransmitP;
    SubReceive = QueuedTransmitP;
    Init = QueuedTransmitP;

    components new SmartQueueC(EM_RADIO_SEND_QUEUE_SIZE) as SendSmartQueueC;
    QueuedTransmitP.SendMsgQueue -> SendSmartQueueC;

    components new SmartQueueC(EM_RADIO_RECEIVE_QUEUE_SIZE) as ReceiveSmartQueueC;
    QueuedTransmitP.ReceiveMsgQueue -> ReceiveSmartQueueC;

    components new TimerMilliC() as Timer;
    QueuedTransmitP.RetryTimer -> Timer;

    
}
