
#include "OSALoggerRF.h"

module OSALoggerRFP
{
	provides interface OSALoggerRF;
	uses interface OSALogger;
	uses interface RealTimer<TMilli, uint32_t>;
}
implementation
{
	command error_t OSALoggerRF.addLog(uint8_t type, uint16_t src, uint16_t dest, uint16_t packet_size)
	{
		osalog_rf_t this_log;
		this_log.time = call RealTimer.getTime();
		this_log.type = type;
		this_log.src = src;
		this_log.dest = dest;
		this_log.packet_size = packet_size;

		return call OSALogger.write((uint8_t *)&this_log, sizeof(this_log));
	}

	
	command error_t OSALoggerRF.addSmallLog(uint8_t type, uint8_t src, uint8_t dest, uint8_t packet_size)
	{
		osalog_rf_small_t this_log;
		this_log.time = call RealTimer.getTime();
		this_log.type = type;
		this_log.src = src;
		this_log.dest = dest;
		this_log.packet_size = packet_size;

		return call OSALogger.write((uint8_t *)&this_log, sizeof(this_log));
	}
}

