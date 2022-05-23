configuration 3AxisDataC
{
	provides interface SensorData;
}
implementation
{
	components 3AxisDataP;
	components new AdcC() as 3Axis;

	SensorData = 3AxisDataP;
	3AxisDataP.3AxisControl -> 3Axis;
    	3AxisDataP.3AxisRead -> 3Axis;
}

