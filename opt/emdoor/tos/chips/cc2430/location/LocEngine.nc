#include "LocationEngine.h"

interface LocEngine{
	command void Calc(BlindNode_t *blind, Para_t *para, RefNode_t*ref);
	event void CalcFinish();
}
