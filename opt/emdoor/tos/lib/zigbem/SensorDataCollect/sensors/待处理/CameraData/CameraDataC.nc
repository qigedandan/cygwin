configuration CameraDataC
{
	provides interface SensorData;
}
implementation
{
	components CameraDataP;
	components new AdcC() as Camera;

	SensorData = CameraDataP;
	CameraDataP.CameraControl -> Camera;
    	CameraDataP.CameraRead -> Camera;
}

