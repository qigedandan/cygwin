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
 * @author Octav Chipara
 * @version $Revision: 1.2 $
 * @date $Date: 2008/06/27 20:27:22 $
 */

configuration GenericSlotterC {
	provides {
		interface Slotter;
		interface SlotterControl;
		interface FrameConfiguration;
		interface AsyncStdControl;
	}
}
implementation {
	components OSA_MainC as MainC, LedsC;
	components GenericSlotterP;
	components new Alarm32khz32C();
	
	
	GenericSlotterP.Boot -> MainC;
	Slotter = GenericSlotterP;
	FrameConfiguration = GenericSlotterP;
	AsyncStdControl = GenericSlotterP;
	
	MainC.SoftwareInit -> GenericSlotterP;
	GenericSlotterP.Alarm -> Alarm32khz32C;
	//GenericSlotterP.LocalTime -> LocalTime32khz16C;
	//GenericSlotterP.Alarm -> Alarm32Khz16VirtualizerC;
	GenericSlotterP.SlotterControl = SlotterControl;
	GenericSlotterP.Leds -> LedsC;
}
