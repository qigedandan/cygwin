
configuration CalcBNLocC
{
	provides interface UpdateLoc;
	provides interface SplitControl as RFControl;
}
implementation
{    
	components UpdateLocInfoC, CalcBNLocP;
	components new CC2431LocationEngineC();

	UpdateLoc = CalcBNLocP;
	RFControl = UpdateLocInfoC;
	CalcBNLocP.UpdateLocInfo -> UpdateLocInfoC;
	CalcBNLocP.CalcLocation -> CC2431LocationEngineC ;

    components new TimerMilliC() as Timer;
    CalcBNLocP.Timer -> Timer ;    
}

