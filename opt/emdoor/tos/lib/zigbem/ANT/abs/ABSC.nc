
configuration ABSC
{
    provides interface ABS;
}
implementation
{
    components MainC;
    components ABSP;

    MainC.SoftwareInit -> ABSP.Init;
    ABS = ABSP;

    components new HalCC2430SimpleUartC(9600);

    ABSP.UartStdControl -> HalCC2430SimpleUartC;
    ABSP.Comm -> HalCC2430SimpleUartC.uart0;
}

