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
 *
 * @author Greg Hackmann
 * @version $Revision: 1.1 $
 * @date $Date: 2007/11/06 23:58:59 $
 */

configuration ScpBootC
{
	provides interface AsyncSend as Send;
	provides interface AsyncStdControl;

	uses interface AsyncSend as SubSend;
	uses interface Resend;
	uses interface AMPacket;
	uses interface LowPowerListening;
}
implementation
{
	components ScpBootP as Boot;
	components new VirtualizedAlarmMilli16C() as BootAlarm;
	components new StateC() as BootState;
	
	Send = Boot;
	AsyncStdControl = Boot;

	Boot.SubSend = SubSend;
	Boot.Resend = Resend;
	Boot.AMPacket = AMPacket;
	Boot.BootAlarm -> BootAlarm;
	Boot.BootState -> BootState;
	Boot.LowPowerListening = LowPowerListening;
}
