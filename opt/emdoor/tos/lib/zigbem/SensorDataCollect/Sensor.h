//=============================================================================
//	Document:		Sensor.h
//	Description:		ͷ�ļ����������ô���������ز���
//	Date:			2011/04/17
//	Author:		Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

#ifndef SENSOR_H_
#define SENSOR_H_

/*******************************INCLUDE******************************************/
#define USE_MODULE_ADC
#include "Adc.h"

/*******************************TYPEDEF******************************************/
typedef uint8_t sensor_id_t;

/********************************MACRO*******************************************/

#define ADC_CHANNEL_INFRARED			ADC_AIN4		/* P0.4 */	

#define ADC_CHANNEL_ILLUMINATION		ADC_AIN4		/* P0.4 */
#define ADC_CHANNEL_AIR_PRESSURE		ADC_AIN4		/* P0.4 */
#define ADC_CHANNEL_MEDICAL_PRESSURE	ADC_AIN4		/* P0.4 */
#define ADC_CHANNEL_FIRE				ADC_AIN4		/* P0.4 */	
#define ADC_CHANNEL_UV					ADC_AIN4		/* P0.4 */	
#define ADC_CHANNEL_DECIBEL				ADC_AIN4		/* P0.4 */	
#define ADC_CHANNEL_THERMOPILE			ADC_AIN4		/* P0.4 */	
#define ADC_CHANNEL_INFRARED			ADC_AIN4		/* P0.4 */	
#define ADC_CHANNEL_RAIN				ADC_AIN4		/* P0.4 */
#define ADC_CHANNEL_VIBRATION			ADC_AIN4		/* P0.4 */
#define ADC_CHANNEL_SMOKE				ADC_AIN4		/* P0.4 */

#define SENSOR_ID_ILLUMINATION		1					/*���մ������豸*/ //OK
#define SENSOR_ID_TEMP_AND_HUMI		2					/*��ʪ�ȴ������豸*/ //OK
#define SENSOR_ID_INFRARED			3					/*Զ���⴫�����豸*/ //OK
#define SENSOR_ID_AIR_PRESSURE		4					/*��ѹ�������豸*/ //OK
#define SENSOR_ID_MEDICAL_PRESSURE	5					/*ҽ����ѹ�������豸*/ //OK
#define SENSOR_ID_HALL				6					/*�����������豸*/ //OK
#define SENSOR_ID_RAIN				7					/*��δ������豸*/ //OK
#define SENSOR_ID_FLUX				8					/*�����������豸*/
#define SENSOR_ID_FIRE				9					/*���洫�����豸*/ //OK
#define SENSOR_ID_TEMPERATURE		10					/*�¶ȴ������豸*/ //OK
#define SENSOR_ID_DECIBEL			11					/*�ֱ��������豸*/ //��Ҫ������
#define SENSOR_ID_SMOKE				12					/*���������豸*/ //OK
#define	SENSOR_ID_ULTRASONIC		13					/*�������������豸*/
#define SENSOR_ID_UV				14					/*�����ߴ������豸*/ //OK
#define	SENSOR_ID_VIBRATION			15					/*�𶯴������豸*/ //��Ҫ������
#define	SENSOR_ID_GPS				16					/*GPS�豸*/
#define	SENSOR_ID_THREE_AXIS		17					/*3����ٶȴ������豸*/
#define	SENSOR_ID_ALCOHOL			18					/*�ƾ��������豸*/
#define	SENSOR_ID_PLUSE				19					/*�����������豸*/ //��Ҫ������
#define	SENSOR_ID_CAMERA			20					/*����ͷ�豸*/
#define	SENSOR_ID_THERMOPILE		21					/*�����ȵ�Ѵ������豸*/ //OK
#define	SENSOR_ID_SOLAR_ENERGY		22					/*̫���ܴ������豸*/
#define	SENSOR_ID_RELAY				23					/*�̵����������豸*/

#define FLUX_IDLE_TIME				500
#define FLUX_TIMEOUT				(CONFIG_SENSOR_RATE)

#endif /* SENSOR_H_ */
