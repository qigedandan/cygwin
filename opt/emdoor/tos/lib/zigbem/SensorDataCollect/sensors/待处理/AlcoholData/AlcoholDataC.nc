configuration AlcoholDataC
{
	provides interface SensorData;
}
implementation
{
	components AlcoholDataP;
	components new AdcC() as Alcohol;

	SensorData = AlcoholDataP;
	AlcoholDataP.AlcoholControl -> Alcohol;
    	AlcoholDataP.AlcoholRead -> Alcohol;
}

