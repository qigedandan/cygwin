
generic configuration CoreControlC()
{
	provides interface CoreControl;
	provides interface CoreControlOwner;
}
implementation
{
	components new CoreControlP();
	CoreControl = CoreControlP;
	CoreControlOwner = CoreControlP;
}

