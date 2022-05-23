

module SleepAlarmMilli32P{
	provides interface Alarm<TMilli, uint32_t>;
	provides interface Init;
	
	uses interface Alarm<T32khz, uint32_t> as AlarmFrom;
}
implementation
{

	command error_t Init.init() {
	}


	async command void Alarm.start(uint32_t dt){
		call AlarmFrom.start(dt*32);
	}

	async command void Alarm.stop() {
		call AlarmFrom.stop();
	}

	async command bool Alarm.isRunning() {
		return call AlarmFrom.isRunning();
	}

	async command void Alarm.startAt(uint32_t t0, uint32_t dt){
		call AlarmFrom.startAt(t0*32, dt*32);
	}

	async command uint32_t Alarm.getNow() {
		return call AlarmFrom.getNow()/32;
	}

	async command uint32_t Alarm.getAlarm() {
		return call AlarmFrom.getAlarm()/32;
	}

	async event void AlarmFrom.fired() {
		
		signal Alarm.fired();
	}

	default async event void Alarm.fired() {}
}
		
