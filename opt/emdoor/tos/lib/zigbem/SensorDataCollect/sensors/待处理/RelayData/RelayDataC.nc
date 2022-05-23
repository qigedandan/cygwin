configuration RelayDataC
{
	provides interface SensorData;
}
implementation
{
	components RelayDataP;
	components new AdcC() as Relay;

	SensorData = RelayDataP;
	RelayDataP.RelayControl -> Relay;
    	RelayDataP.RelayRead -> Relay;
}

