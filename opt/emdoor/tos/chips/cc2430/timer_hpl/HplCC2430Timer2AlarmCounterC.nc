
configuration HplCC2430Timer2AlarmCounterC{
   provides interface Init;
   provides interface Counter<T32khz, uint16_t> as Counter;
   provides interface Alarm<T32khz, uint16_t> as Alarm[uint8_t id];
   provides interface GpioCapture;
} implementation {

   components new HplCC2430Timer2AlarmCounterP(T32khz);
   components OSA_MainC as MainC;

   MainC.SoftwareInit -> HplCC2430Timer2AlarmCounterP;

   Init = HplCC2430Timer2AlarmCounterP;
   
