configuration GpsDataC
{
	provides interface SensorData;
}
implementation
{
	components GpsDataP;
	components new AdcC() as Gps;

	SensorData = GpsDataP;
	GpsDataP.GpsControl -> Gps;
    	GpsDataP.GpsRead -> Gps;
}

