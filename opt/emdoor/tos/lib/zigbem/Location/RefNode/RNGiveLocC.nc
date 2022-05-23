
configuration RNGiveLocC
{
    provides interface Init;
    provides interface SplitControl as RFControl;
}
implementation
{
    components RNGiveLocP; 
    components LocPacketC;
    components GetCfgDataC;

    Init = RNGiveLocP;
    RFControl = LocPacketC.RFControl;
    RNGiveLocP.LocPacket -> LocPacketC.LocPacket;
    RNGiveLocP.GetCfgData -> GetCfgDataC.GetCfgData;

    components new TimerMilliC() as Timer;
    RNGiveLocP.Timer -> Timer ;    
}
