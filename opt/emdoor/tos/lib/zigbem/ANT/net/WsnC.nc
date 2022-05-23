
configuration WsnC
{
    provides 
    {    
        interface StdControl;
        interface Send[uint8_t id];
        interface Receive[uint8_t id];
        interface Intercept as Intercept[uint8_t id];
        interface Intercept as Snoop[uint8_t id];
        interface AMPacket;
        interface Packet;
        interface Init;
    }
}
implementation
{    
    components CC2430ActiveMessageC as AM, NullCC2430ActiveMessageC as NAM;
    AMPacket = AM;
    Packet = AM;
    
    components AtomMeshC;
    Init = AtomMeshC;
    StdControl = AtomMeshC;
    Send = AtomMeshC.Send;
    Receive = AtomMeshC.Receive;
    Intercept = AtomMeshC.Intercept;
    Snoop = AtomMeshC.Snoop;

	//20091125
	//components new ActiveMessageResourceC();
	//AtomMeshC.AMSend -> ActiveMessageResourceC;

    AtomMeshC.AMSend -> AM;
    AtomMeshC.AMPacket -> AM;
    AtomMeshC.Packet -> AM;
    AtomMeshC.ReceiveMsg -> AM.Receive;
    AtomMeshC.ReceiveDownstreamMsg -> NAM.Receive;
    AtomMeshC.AMControl -> AM;
    AtomMeshC.CC2420Packet -> AM;

    components MainC;
    components HalCC2430RadioC;
    AtomMeshC.HALCC2420 -> HalCC2430RadioC;
    AtomMeshC.HALCC2420Control -> HalCC2430RadioC.HALCC2420Control;

    components new TimerMilliC() as RouterTimer;
    AtomMeshC.RouterTimer -> RouterTimer;
}
