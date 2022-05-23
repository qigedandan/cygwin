
configuration FlashIEEEC
{
    provides interface Init;
    provides interface FlashIEEE;

}
implementation
{
    components FlashIEEEP;
    Init = FlashIEEEP;
    FlashIEEE = FlashIEEEP;

    components ActiveMessageAddressC;
    FlashIEEEP.ActiveMessageAddress -> ActiveMessageAddressC;
}

