
configuration LocationEngineC
{
	provides interface LocEngine;
}
implementation
{
	components LocationEngineP;

	LocEngine = LocationEngineP;
}
