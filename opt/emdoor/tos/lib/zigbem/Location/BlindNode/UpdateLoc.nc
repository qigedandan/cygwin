#include "Location.h"

interface UpdateLoc
{
	command void Init();
	command void SetCalcPara(uint8_t param_a,uint8_t param_n);

	event void Fired(LocBlindNode_t *blind,LocDevPara_t *locpara,uint8_t *RefNum);
}
