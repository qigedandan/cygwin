/*************************************************
*	FUNCTION NAME : BlinkC.nc
*	FUNCTION DESCRIPTION : LED����˸
*	FUCNTION DATE :2010/10/14
*	FUNCTION AUTHOR: EMDOOR
**/


configuration BlinkC
{
}
implementation
{
	components BlinkM;  						//LEDģ���������ʵ��LED����
	components LedsC;
	components MainC;  							//TinyOS2��ģ�飬�������ڹ���ϵͳ���� 
	
	/* LEDģ������п���LED��IO��tinyos�ṩ
	*  �Ľӿ������
	*/
	BlinkM.Leds -> LedsC;
	
	/* LEDģ������Boot�ӿ���ϵͳBoot�ӿ�
	*  ��������ϵͳ����ʱ�����LedM��Boot�ӿ�
	*/
	BlinkM.Boot -> MainC.Boot;
}
