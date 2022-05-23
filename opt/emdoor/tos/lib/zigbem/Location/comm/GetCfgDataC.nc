
configuration GetCfgDataC
{
    provides interface GetCfgData;
}
implementation
{
	components GetCfgDataP;
    GetCfgData = GetCfgDataP;
    components HalFlashC;
	GetCfgDataP.HalFlash -> HalFlashC;
}
