/*
 * "Copyright (c) 2007 Washington University in St. Louis.
 * All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose, without fee, and without written agreement is
 * hereby granted, provided that the above copyright notice, the following
 * two paragraphs and the author appear in all copies of this software.
 *
 * IN NO EVENT SHALL WASHINGTON UNIVERSITY IN ST. LOUIS BE LIABLE TO ANY PARTY
 * FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING
 * OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF WASHINGTON
 * UNIVERSITY IN ST. LOUIS HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * WASHINGTON UNIVERSITY IN ST. LOUIS SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
 * ON AN "AS IS" BASIS, AND WASHINGTON UNIVERSITY IN ST. LOUIS HAS NO
 * OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR
 * MODIFICATIONS."
 */
 
#include "AlarmConstants.h"

/**
 * Provides an array of 32-bit 32 KHz <tt>Alarm</tt>s, by virtualizing
 * a single <tt>Alarm32khz32C</tt>.
 *
 * @author Greg Hackmann
 */
configuration Alarm32khz32VirtualizerP
{
	provides interface Alarm<T32khz, uint32_t>[uint8_t id];
}
implementation
{
	enum
	{
		COUNT = uniqueCount(UQ_VIRTUALIZED_ALARM_32KHZ_32),
	};
	components new Alarm32khz32C();
	
	components new VirtualizeAlarmC(T32khz, uint32_t, COUNT) as Alarms;
	Alarm = Alarms.Alarm;
	Alarms.AlarmFrom -> Alarm32khz32C;
}
