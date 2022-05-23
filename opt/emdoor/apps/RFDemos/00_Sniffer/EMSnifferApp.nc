/**
 *
 */


configuration EMSnifferApp
{
}
implementation
{
    components EMSnifferM;
    components MainC;
    EMSnifferM -> MainC.Boot;
	
	
    components HalCC2430RadioC;
    EMSnifferM.HALCC2420 -> HalCC2430RadioC.HALCC2420;
    EMSnifferM.HALCC2420Control -> HalCC2430RadioC.HALCC2420Control;
	
    /**
	串口收发组件PlatformSerialC
    */
    components PlatformSerialC;
    EMSnifferM.UartStdControl -> PlatformSerialC.UartStdControl;
    EMSnifferM.UartStream -> PlatformSerialC.UartStream;
	
    components new TimerMilliC() as Timer;
    EMSnifferM.ChannelTimer -> Timer;
	
}
// 
