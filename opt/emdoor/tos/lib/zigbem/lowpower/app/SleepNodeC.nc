
configuration SleepNodeC
{
	provides interface SleepNode;
}
implementation
{
	components SleepNodeP;	
	SleepNode = SleepNodeP;

	components SleepNodeCycleControlC;
	SleepNodeP.SleepNodeCycleControl -> SleepNodeCycleControlC;

	components UnsleepClockC;
	SleepNodeP.UnsleepClock -> UnsleepClockC;
}

