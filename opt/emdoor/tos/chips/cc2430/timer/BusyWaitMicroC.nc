configuration BusyWaitMicroC
{
  provides interface BusyWait<TMicro, uint16_t>;
}

implementation
{
  components new BusyWaitMicroP();
  
  BusyWait = BusyWaitMicroP;
}
