configuration UltraSonixDataC
{
	provides interface SensorData;
}
implementation
{
	components UltraSonixDataP;
	components new AdcC() as UltraSonix;

	SensorData = UltraSonixDataP;
	UltraSonixDataP.UltraSonixControl -> UltraSonix;
    	UltraSonixDataP.UltraSonixRead -> UltraSonix;
}

