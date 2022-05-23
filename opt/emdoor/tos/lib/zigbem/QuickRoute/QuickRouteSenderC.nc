generic configuration QuickRouteSenderC(uint8_t am_id)
{
	provides {
		interface Send;
		interface CoreControl;
	}
	uses {
		interface AMSend;
	}
}
implementation
{
	components new QuickRouteSenderP(am_id);

	Send = QuickRouteSenderP;

	components QuickRouteEngineC;
	QuickRouteSenderP.QuickRouteEngine -> QuickRouteEngineC;
	QuickRouteSenderP.QuickRouteEngineEvent -> QuickRouteEngineC;
	
	//components new ActiveMessageResourceC();
	QuickRouteSenderP.AMSend = AMSend;


	components ActiveMessageC;
	QuickRouteSenderP.AMPacket -> ActiveMessageC;

	components QuickRouteRadioC;
	QuickRouteSenderP.Packet -> QuickRouteRadioC;

	components CC2420PacketC;
	QuickRouteSenderP.CC2420Packet -> CC2420PacketC;

	/* CoreControl */
	components new CoreControlC();
	CoreControl = CoreControlC;
	QuickRouteSenderP.CoreControlOwner -> CoreControlC;

	/* add support for sleep control */
	components new CoreControlLockC();
	components new SleepNodeStateLockC();
	CoreControlLockC.StateLock -> SleepNodeStateLockC;
	CoreControlLockC.CoreControl -> CoreControlC;
}

	
