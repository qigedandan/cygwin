configuration SphygmuxDataC
{
	provides interface SensorData;
}
implementation
{
	components SphygmuxDataP;
	components new AdcC() as Sphygmux;

	SensorData = SphygmuxDataP;
	SphygmuxDataP.SphygmuxControl -> Sphygmux;
    	SphygmuxDataP.SphygmuxRead -> Sphygmux;
}

