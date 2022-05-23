#include "Location.h"

interface GetPara
{
	command void GetPara(LocBlindNode_t *locBN,LocDevPara_t locpara,uint8_t flag);

	event bool GetParaFinish(LocDevPara_t locpara,uint8_t RefNum);
}
