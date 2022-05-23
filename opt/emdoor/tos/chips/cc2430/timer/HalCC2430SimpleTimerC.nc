

configuration HalCC2430SimpleTimerC {
  provides interface Timer<TMilli> as Timer1;
  provides interface Init;
}
implementation {
  components HalCC2430SimpleTimerP;

  HalCC2430SimpleTimerP.Init = Init;
  HalCC2430SimpleTimerP.Timer1 = Timer1;
}
