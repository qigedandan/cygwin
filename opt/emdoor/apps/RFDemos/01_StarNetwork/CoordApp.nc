/*************************************************
*	FUNCTION NAME : CoordApp.nc
*	FUNCTION DESCRIPTION : 接收RF数据，并通过串口显示
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

#include "Wsn.h"
#include "Coord.h"

configuration CoordApp {
}
implementation {
    components CoordM;
    components MainC;
    CoordM -> MainC.Boot;
    
    components WsnC;
    CoordM.WsnControl -> WsnC.StdControl;
    CoordM.Intercept -> WsnC.Intercept[EM_MSG_SENSOR];
    CoordM.AMPacket -> WsnC.AMPacket;
    CoordM.Packet -> WsnC.Packet;

    components ABSC;
    CoordM.ABS -> ABSC;
}

