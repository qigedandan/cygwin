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
 
/**
/**                                             
 *
 * @author Greg Hackmann
 * @version $Revision: 1.1 $
 * @date $Date: 2007/11/06 23:58:58 $
 */

configuration FixedSleepLplListenerC
{
	provides interface AsyncReceive as Receive;
	provides interface FixedSleepLplListener;
	provides interface Interval as RadioTimeout;
	
	uses interface ChannelPoller;
	uses interface StdControl as PollerControl;
	uses interface RadioPowerControl;
	uses interface AsyncReceive as SubReceive;
	uses interface State as SendState;
	uses interface AMPacket;
	
#ifdef MCU_SLEEP
	uses interface Alarm<TMilli, uint16_t> as TimeoutAlarm;
#else
	uses interface Alarm<TMilli, uint32_t> as TimeoutAlarm;
#endif
}
implementation
{
	components FixedSleepLplListenerP as Listener;
	components LedsC;

	Receive = Listener.Receive;
	FixedSleepLplListener = Listener;
	RadioTimeout = Listener;
	
	Listener.ChannelPoller = ChannelPoller;
	Listener.PollerControl = PollerControl;
	Listener.RadioPowerControl = RadioPowerControl;
	Listener.SubReceive = SubReceive;
	Listener.SendState = SendState;
	Listener.AMPacket = AMPacket;
	Listener.TimeoutAlarm = TimeoutAlarm;
	Listener.Leds -> LedsC;
}
