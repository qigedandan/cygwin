
configuration SystemHeartC
{
	provides interface StdControl;
}
implementation
{
	components SystemHeartP;
	StdControl = SystemHeartP;

	components WatchDogC;
	SystemHeartP.WatchDog -> WatchDogC;

	components new TimerMilliC();
	SystemHeartP.HeartTimer -> TimerMilliC;
}

