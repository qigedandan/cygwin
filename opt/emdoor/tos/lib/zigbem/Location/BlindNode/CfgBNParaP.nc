
module CfgBNParaP
{
	provides interface CfgBNPara;

	uses interface UpdateLocInfo;
	uses interface CalcLocation;	
	uses interface GetCfgData;
}
implementation
{
#define MIN_PARAM_A 30
#define MAX_PARAM_A 50
#define MIN_PARAM_N 0
#define MAX_PARAM_N 31
#define CALC_TIMES (MAX_PARAM_N - MIN_PARAM_N + 1)*(MAX_PARAM_A - MIN_PARAM_A + 1)

#define FIRST_CFG_AUTO 1
#define NORMAL_CFG_AUTO 0

	LocDevPara_t m_loc_para;
	LocDevPara_t loc_para;
	LocBlindNode_t loc_blind_org;
	LocBlindNode_t loc_blind;
	LocRefNode_t refNodeInfo[16];
	uint8_t refNodeNum;

#define AUTO_RESULT_SIZE	5
	
	LocBlindNodeAutoResult_t m_auto_result[AUTO_RESULT_SIZE] = {{0, 0, 0, 0}};
	
	uint8_t buf[2];
	uint16_t min_x;
	uint16_t min_y;
	uint8_t m_a;
	uint8_t m_n;

	command void CfgBNPara.SetPara(uint8_t param_a,uint8_t param_n)
	{
		buf[0] = param_a;
		buf[1] = param_n;
		call GetCfgData.Write(buf,2);
		ADBG(DBG_LEV, "\r\n [CfgBNPara]--a = %d ,n = %d\r\n",(int)(buf[0]),(int)(buf[1]));
	}

	command void CfgBNPara.GetPara(uint8_t *param_a,uint8_t *param_n)
	{
		call GetCfgData.Read(buf,2);
		*param_a = buf[0];
		*param_n = buf[1];
	}

	command void CfgBNPara.CalcParaAuto(uint16_t loc_x,uint16_t loc_y)
	{
		loc_blind_org.x = loc_x;
		loc_blind_org.y = loc_y;
		min_x = 0xff;
		min_y = 0xff;
		m_a = MIN_PARAM_A;
		m_n = MIN_PARAM_N;
		m_loc_para.param_a = m_a;
		m_loc_para.param_n = m_n;

		call UpdateLocInfo.Update(&refNodeInfo,&refNodeNum);
		
		call CalcLocation.Calc(&loc_blind,&m_loc_para,&refNodeInfo);
	}
	event void CalcLocation.CalcFinish() 
	{
		uint16_t i,j;
		i = (uint16_t)loc_blind.x;
		j = (uint16_t)loc_blind.y;

		ADBG(8, "\r\n loc_blind_org.x =%d  loc_blind_org.y = %d ",(int)(loc_blind_org.x),(int)(loc_blind_org.y));

		if (i>(loc_blind_org.x)) {
			i = i - (loc_blind_org.x);
		}
		else {
			i = (loc_blind_org.x) - i;
		}

		if (j>(loc_blind_org.y)) {
			j = j - (loc_blind_org.y);
		}
		else {
			j = (loc_blind_org.y) - j;
		}

		ADBG(8, "\r\n i =%d  j = %d ",(int)(i),(int)(j));


		addAutoResult(i, j, m_a, m_n);

/*
		if ((i+j)<(min_x+min_y))
		{
			min_x = i;
			min_y = j;
			loc_para = locpara;
			ADBG(DBG_LEV, "\r\n min_x =%d  min_y = %d ",(int)(min_x),(int)(min_y));
			ADBG(DBG_LEV, " para.a =%d  para.n = %d \r\n",(int)(m_loc_para.param_a),(int)(m_loc_para.param_n));
		}
		ADBG(8, "\r\n loc_blind.x =%d  loc_blind.y = %d ",(int)(loc_blind.x),(int)(loc_blind.y));
*/
		ADBG(20, "*");

		if (m_a < MAX_PARAM_A)
		{
			if (m_n < MAX_PARAM_N) {
				m_n ++;
			}
			else {
				m_n = 0;
				m_a ++;

				ADBG(20, "\n");
				//signal CfgBNPara.CalcParamAutoPercent((int)(m_a - MIN_PARAM_A) * 100 / (MAX_PARAM_A - MIN_PARAM_A));
			}

			m_loc_para.param_a = m_a;
			m_loc_para.param_n = m_n;
			//call GetLoc.GetWithPara(&loc_blind, m_loc_para, NORMAL_CFG_AUTO);

			post taskCalcWithPara();
			
			ADBG(8, "\r\nCfgBNPara.GetWithPara=%d__n=%d\r\n",(int)(m_loc_para.param_a),(int)(m_loc_para.param_n));

			return FALSE;
		}
		else
		{
			signal CfgBNPara.CalcParaAutoFinish( m_auto_result, AUTO_RESULT_SIZE);
			ADBG(20, "\r\nCfgBNPara.CalcParaAutoFinish__a=%d__n=%d\r\n",(int)(loc_para.param_a),(int)(loc_para.param_n));

			return TRUE;
		}
	}

	task void taskCalcWithPara()
	{
		call CalcLocation.Calc(&loc_blind,&m_loc_para,&refNodeInfo);
	}

	bool addAutoResult(uint16_t diff_x, uint16_t diff_y, uint8_t a, uint8_t n)
	{
		uint8_t i;
		uint8_t biggest = -1;
		
		for (i=0; i < AUTO_RESULT_SIZE; ++i)
		{
			if (m_auto_result[i].used != 1)
			{
				ADBG(8, "insert result to %d, diff=0x%04x\n", (int)i, diff_x + diff_y);
				break;
			}
			else if ((diff_x + diff_y) <= (m_auto_result[i].diff_x + m_auto_result[i].diff_y))
			{
				biggest = i;
			}
		}

		if (i >= AUTO_RESULT_SIZE)
		{
			ADBG(8, "update result to %d\n", (int)biggest);
			i = biggest;
		}

		if (i >=0  &&  i < AUTO_RESULT_SIZE)
		{
			m_auto_result[i].diff_x = diff_x;
			m_auto_result[i].diff_y = diff_y;
			m_auto_result[i].a = a;
			m_auto_result[i].n = n;
			m_auto_result[i].used = 1;
			ADBG(8, "diff_x=0x%x, diff_y=0x%x, a = %d, n= %d\n", m_auto_result[i].diff_x, m_auto_result[i].diff_y, (int)a, (int)n);

			return TRUE;
		}

		return FALSE;
	}

default event void CfgBNPara.CalcParaAutoFinish(LocBlindNodeAutoResult_t *result, uint8_t result_count) {}
default event void CfgBNPara.CalcParamAutoPercent(int percent) {}
}
