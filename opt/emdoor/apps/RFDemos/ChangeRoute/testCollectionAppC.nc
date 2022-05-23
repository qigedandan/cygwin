#include <MultiHopLqi.h>

#define DUTY_CYCLE_BENCHMARK

uint32_t radioDutyCycle = 0;
uint32_t oscDutyCycle = 0;
uint32_t vDutyCycle = 0;
norace uint32_t radioStartCount = 0;
norace uint32_t radioStopCount = 0;

configuration testCollectionAppC{
}
implementation {
	components OSA_MainC as MainC;
	components testCollectionC;
	components CollectionC;
	components new CollectionSenderC(240);
	components ActiveMessageC;
	components new TimerMilliC();
	components RandomC;
	

	testCollectionC.Boot -> MainC;
	testCollectionC.SplitControl -> ActiveMessageC;
	testCollectionC.AMPacket -> ActiveMessageC;
	
	testCollectionC.Send -> CollectionSenderC.Send;
	testCollectionC.Receive -> CollectionC.Receive[240];
	testCollectionC.RootControl -> CollectionC;	
	testCollectionC.StdControl -> CollectionC;
	testCollectionC.Packet -> CollectionC;
	testCollectionC.CollectionPacket -> CollectionC;
#ifdef CC2420_LQI
	testCollectionC.RouteControl -> CollectionC;
#endif

	testCollectionC.Timer -> TimerMilliC;

	testCollectionC.Random -> RandomC;
}
	
	
