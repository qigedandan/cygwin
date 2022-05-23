
configuration WatchDogC
{
	provides interface WatchDog;
}
implementation
{
	components WatchDogP;
	WatchDog = WatchDogP;
}

