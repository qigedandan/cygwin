configuration SmogDataC
{
	provides interface SensorData;
}
implementation
{
	components SmogDataP;
	components new AdcC() as Smog;

	SensorData = SmogDataP;
	SmogDataP.SmogControl -> Smog;
    	SmogDataP.SmogRead -> Smog;
}

