#include "Location.h"

interface CfgBNPara
{
	command void SetPara(uint8_t param_a,uint8_t param_n);

	command void GetPara(uint8_t *param_a,uint8_t *param_n);

	command void CalcParaAuto(uint16_t loc_x,uint16_t loc_y);
	//event void CalcParaAutoFinish(uint8_t param_a,uint8_t param_n);
	event void CalcParaAutoFinish(LocBlindNodeAutoResult_t *result, uint8_t result_count);
	event void CalcParamAutoPercent(int percent);
}
