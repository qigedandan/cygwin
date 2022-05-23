

generic module CC2430TimerSleepAlarmP( typedef frequency ) {
  provides interface Alarm<frequency, uint16_t> as Alarm0;
  provides interface Init;

  uses interface Init as SubInit;
  uses interface HplCC2430Timer16 as Timer1;
  //uses interface HplCC2430SleepTimer as Timer1;


} implementation {

  /*
   * Argh.. Do we know if Timer1.init() has finished by this point?
   */
  command error_t Init.init() {
    call SubInit.init();
    call Timer1.enableEvents();

    return SUCCESS;
  }
 
  async command void Alarm0.stop(){ call Timer1.disableEvents(); }
  async command bool Alarm0.isRunning(){ return TRUE; }
  async command uint16_t Alarm0.getAlarm(){ return (call Timer1.getCompare()); }
  async command uint16_t Alarm0.getNow(){ return call Timer1.get(); }

  async command void Alarm0.start(uint16_t dt){
    call Alarm0.startAt(call Timer1.get(), dt);
  }

  async command void Alarm0.startAt(uint16_t t0, uint16_t dt){
    /* Stolen fra mica128 code by David Gay*/

    now = call Timer1.get();
    dbg("Atm128AlarmC", "   starting timer at %llu with dt %llu\n", (uint64_t)t0, (uint64_t) dt);
    /* We require dt >= mindt to avoid setting an interrupt which is in
       the past by the time we actually set it. mindt should always be
       at least 2, because you cannot set an interrupt one cycle in the
       future. It should be more than 2 if the timer's clock rate is
       very high (e.g., equal to the processor clock). */
    if (dt < mindt)
      dt = mindt;

    expires = t0 + dt;

    guardedExpires = expires - mindt;

    /* t0 is assumed to be in the past. If it's numerically greater than
       now, that just represents a time one wrap-around ago. This requires
       handling the t0 <= now and t0 > now cases separately. 

       Note also that casting compared quantities to timer_size produces
       predictable comparisons (the C integer promotion rules would make it
       hard to write correct code for the possible timer_size size's) */
    if (t0 <= now)
      {
	/* if it's in the past or the near future, fire now (i.e., test
	   guardedExpires <= now in wrap-around arithmetic). */
	if (guardedExpires >= t0 && // if it wraps, it's > now
	    guardedExpires <= now) 
	  call Timer1.setCompare(call Timer1.get() + mindt);
	else
	  call Timer1.setCompare(expires);
      }
    else
      {
	/* again, guardedExpires <= now in wrap-around arithmetic */
	if (guardedExpires >= t0 || // didn't wrap so < now
	    guardedExpires <= now)
	  call Timer1.setCompare(call Timer1.get() + mindt);
	else
	  call Timer1.setCompare(expires);
      }
    call Timer1.enableCompare();
  }


  async event void Timer1.fired() {
    signal Alarm0.fired();
  }

 default async event void Alarm0.fired() { }
}
