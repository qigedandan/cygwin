/*************************************************
*	FUNCTION NAME : AesAppC.nc
*	FUNCTION DESCRIPTION :
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

configuration AesAppC
{
}
implementation
{
	components AesM;
	components MainC;
	components AesC;
	
	AesM.Boot -> MainC.Boot;
	AesM.Aes -> AesC.Aes;
	
/*	components new TimerMilliC() as Timer;
	AesM.Timer -> Timer;
*/
}
