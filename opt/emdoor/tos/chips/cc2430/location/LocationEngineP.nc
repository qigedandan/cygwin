#include <ioCC2431.h>
#include <LocationEngine.h>

module LocationEngineP {
	provides interface LocEngine;
}
implementation
{
	//Location engine load parameters
	#define LOC_ENABLE()		do { LOCENG |= 0x10; } while (0)
	#define LOC_DISABLE()	do { LOCENG &= ~0x10; } while (0)

	//Location engine load parameters
	#define LOC_PARAMETER_LOAD( on) \
		do {							 \
			if(on) LOCENG |= 0x04;	 \
			else LOCENG &= ~0x04;	 \
		}while(0)

	//Location engine load reference coordinates
	#define LOC_REFERENCE_LOAD(on) \
		do {							\
			if(on) LOCENG |= 0x02;	 \
			else	 LOCENG &= ~0x02;	\
		}while(0)

	//Location engine run
	#define LOC_RUN()  do { LOCENG |= 0x01; } while(0)

	//Location engine done
	#define LOC_DONE()	{LOCENG & 0x08}


	/******************************** LocEngine interface **********************/
	command void LocEngine.Calc(BlindNode_t* blind, Para_t* para, RefNode_t* ref)
	{
		RefNode_t *pRef = ref;

		uint8_t stop = ((CHVER == 0x01) ? LOC_ENGINE_NODE_CAPACITY_REVB:
										LOC_ENGINE_NODE_CAPACITY_REVC); //we use REVC(XXL)
		
									
		uint8_t idx;
		
		LOC_DISABLE();
		LOC_ENABLE();
		
		//Load the reference coordinates.
		LOC_REFERENCE_LOAD(TRUE);

		for(idx = 0; idx <stop; idx++)
		{
			/*the REGISTER value is fixed-point with the  two LSBs representing the fractional part,
			   so the x & y should be left shifted by 2 (XXL)
			*/
			REFCOORD = pRef->x<<2; 
			REFCOORD = pRef->y<<2;			
			pRef++;
		}

		LOC_REFERENCE_LOAD(FALSE);

		//Load the measured parameters.
		LOC_PARAMETER_LOAD(TRUE);

		MEASPARM = para->param_a<<1;
		MEASPARM = para->param_n;

		MEASPARM = LOC_ENGINE_X_MIN;     //this boundaries have little effect on 
		MEASPARM =LOC_ENGINE_X_DELTA;

		MEASPARM =LOC_ENGINE_Y_MIN;
		MEASPARM =LOC_ENGINE_Y_DELTA;		
		
		//Load the measured RSSI values 
		for(idx = 0; idx < stop; idx++)
		{
			MEASPARM = ref->rssi<<1;			
			ref ++;
		}

		LOC_PARAMETER_LOAD(FALSE);

		LOC_RUN();

		while(!(LOCENG & 0x08));	

		ADBG(1, "LOCENGINE finished, LOCX=0x%x,", LOCX);
		ADBG(1, "LOCY=0x%x\n",LOCY); 

		blind->x = (LOCX- LOC_ENGINE_X_MIN +1)%(LOC_ENGINE_X_DELTA +1)+LOC_ENGINE_X_MIN;
		blind->y = LOCY;	

		blind->x= blind->x*0.25;  //return real value in meters
		blind->y = blind->y*0.25;

		LOC_DISABLE();
		signal LocEngine.CalcFinish();
	}
}
			

