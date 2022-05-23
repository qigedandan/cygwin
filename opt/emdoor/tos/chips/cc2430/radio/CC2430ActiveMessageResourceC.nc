


generic components CC2430ActiveMessageResourceC()
{
	provides interface Resource;
	provides interface ResourceRequested;
	provides interface ArbiterInfo;
}
implementation
{
	components CC2430ActiveMessageC;

	

	Resource = CC2430ActiveMessageC.Resource[];
}

