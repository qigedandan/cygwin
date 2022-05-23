

configuration HalFlashC {
    provides interface HalFlash;
}
implementation {

    components MainC, HalFlashP;
    HalFlash = HalFlashP;
    MainC.SoftwareInit -> HalFlashP.Init;
  
}

