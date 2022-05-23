
configuration CfgBNParaC
{
    provides interface CfgBNPara;
}
implementation
{
    components UpdataLocInfoC, CfgBNParaP;
    components new CC2431LocationEngineC();
    
    CfgBNPara = CfgBNParaP;
    CfgBNParaP.CalcLocation -> CC2431LocationEngineC;
    CfgBNParaP.UpdateLocInfo -> UpdataLocInfoC;
    
    components GetCfgDataC;
    CfgBNParaP.GetCfgData -> GetCfgDataC.GetCfgData;
}
