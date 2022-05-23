configuration SHTxxDataC
{
    provides interface SHTxxData;
}
implementation
{
    components SHTxxDataP;
    SHTxxData = SHTxxDataP;

    components MainC;
    MainC.SoftwareInit -> SHTxxDataP;

	components new TimerMilliC() as WaitTimer;
    SHTxxDataP.WaitTimer -> WaitTimer;
}
