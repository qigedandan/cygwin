#include "ioCC2431.h"
#include "Location.h"


#define LOC_ENGINE_NODE_CAPACITY_REVB   8
#define LOC_ENGINE_NODE_CAPACITY_REVC  16

// TBD - how to define/use min/max x/y?
#define LOC_ENGINE_X_MIN  0x00
#define LOC_ENGINE_X_MAX  0xff

#define LOC_ENGINE_Y_MIN  0x00
#define LOC_ENGINE_Y_MAX  0xff

#define LOC_ENGINE_X_DELTA ((LOC_ENGINE_X_MAX)-(LOC_ENGINE_X_MIN))
#define LOC_ENGINE_Y_DELTA ((LOC_ENGINE_Y_MAX)-(LOC_ENGINE_Y_MIN))

#define LOC_ENABLE()  do { LOCENG |= 0x10;  } while(0)
#define LOC_DISABLE() do { LOCENG &= ~0x10; } while(0)

//Location engine load parameters
#define LOC_PARAMETER_LOAD( on )\
   do {                         \
      if(on) LOCENG |= 0x04;    \
      else LOCENG &= ~0x04;     \
   } while(0)

//Location engine load reference coordinates
#define LOC_REFERENCE_LOAD( on )\
   do {                         \
      if(on) LOCENG |= 0x02;    \
      else LOCENG &= ~0x02;     \
} while(0)

//Location engine run
#define LOC_RUN() do { LOCENG |= 0x01; } while(0)

//Location engine done
#define LOC_DONE()  (LOCENG & 0x08)



module CC2431LocationEngineP {
  provides interface CalcLocation ;
}

implementation {
    
    command void  CalcLocation.Calc(LocBlindNode_t *blind ,LocDevPara_t *para ,LocRefNode_t *ref )
    {
        uint8_t idx ;
        LocRefNode_t *pRef = ref;
        const uint8_t stop = ( ( CHVER == 0x01 ) ? LOC_ENGINE_NODE_CAPACITY_REVB :
                                          LOC_ENGINE_NODE_CAPACITY_REVC); 
        
//        ADBG(DBG_LEV, "\r\n\r\n CHVER = %x\r\n",(int)CHVER) ;
//        ADBG(DBG_LEV, "\r\n\r\n stop = %x\r\n",(int)stop) ;

#define DBG_LOC_ENG 200
		uint8_t x;
        ADBG(DBG_LOC_ENG,"\r\npara_a = %d,para_n = %d\r\n",(int)(para->param_a),(int)(para->param_n));
		for(x=0;x<6;x++)
		{
			ADBG(DBG_LOC_ENG,"\nref[%d] x=%d , y=%d , rssi=%d , addr=%d ",(int)(x),(int)(ref[x].x),(int)(ref[x].y),(int)(ref[x].rssi),(int)(ref[x].addr));
		}

        LOC_DISABLE();	
        LOC_ENABLE();	
        
        LOC_REFERENCE_LOAD( TRUE );

        for ( idx = 0; idx < stop; idx++ )
        {
            REFCOORD = (pRef->x)<<2;		
            REFCOORD = (pRef->y)<<2;
            pRef++;
        }			
        LOC_REFERENCE_LOAD( FALSE );

        // Load the measured parameters.
        LOC_PARAMETER_LOAD( TRUE );	

        MEASPARM = (para->param_a)<<1;  	
        MEASPARM = para->param_n;

        // CC2431 rev. C->
        
        if ( CHVER != 0x01 )
        {
            MEASPARM = LOC_ENGINE_X_MIN;
            MEASPARM = LOC_ENGINE_X_DELTA;

            MEASPARM = LOC_ENGINE_Y_MIN;
            MEASPARM = LOC_ENGINE_Y_DELTA;
        }
        
        
        // Load the measured RSSI values shifted for not used fractional bit.
        for ( idx = 0; idx < stop; idx++ )
        {
            MEASPARM = (ref->rssi)<<1;
            ref++;
        }

        LOC_PARAMETER_LOAD( FALSE );	

        LOC_RUN();

        while( !(LOCENG & 0x08) );

        if ( CHVER == 0x01 )
        {
         //    Convert output format (LSB = .5m) to input format (2 LSB's = .25m).
            blind->x = (LOCX << 1);
            blind->y = (LOCY << 1);
            blind->min = LOCMIN;
        }
        else
        {
//          blind->x = LOCX + 2;
//          blind->x = LOCX ;
			blind->x = (LOCX- LOC_ENGINE_X_MIN +1)%(LOC_ENGINE_X_DELTA +1)+LOC_ENGINE_X_MIN;
            blind->y = LOCY;
            blind->min = 0;
        }

        LOC_DISABLE();	
        ADBG(DBG_LOC_ENG,"\r\nDBG_LOC_ENG_end___x=%d,y=%d\r\n",(int)(blind->x),(int)(blind->y));
        signal CalcLocation.CalcFinish();
    }
}
