configuration AtomMeshControlC
{
    provides interface AtomMeshControl;

    provides interface McuSleepLock as AtomMeshSleepLock;

    uses interface StdControl as WsnControl;
    uses interface StdControl as RadioControl;
}
implementation
{
    components AtomMeshControlP;
    AtomMeshControl = AtomMeshControlP;
    WsnControl = AtomMeshControlP.WsnControl;
    RadioControl = AtomMeshControlP.RadioControl;


    components new McuSleepLockC();
    AtomMeshSleepLock = McuSleepLockC;

    components McuSleepC;
    AtomMeshControlP.McuSleepControl -> McuSleepC;

    components new TimerMilliC();
    AtomMeshControlP.ControlTimer -> TimerMilliC;

    components MainC;
    MainC.SoftwareInit -> AtomMeshControlP;
    
}
