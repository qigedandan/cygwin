

configuration PowerControlC
{
	provides interface PowerControl;
}
implementation
{
	components PowerControlP;
	PowerControl = PowerControlP;

	components McuSleepP;
	PowerControlP.McuSleepControl -> McuSleepP;
	
}

