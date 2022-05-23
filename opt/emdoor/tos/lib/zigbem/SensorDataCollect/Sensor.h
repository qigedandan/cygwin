//=============================================================================
//	Document:		Sensor.h
//	Description:		头文件，用于配置传感器的相关参数
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

#define SENSOR_ID_ILLUMINATION		1					/*光照传感器设备*/ //OK
#define SENSOR_ID_TEMP_AND_HUMI		2					/*温湿度传感器设备*/ //OK
#define SENSOR_ID_INFRARED			3					/*远红外传感器设备*/ //OK
#define SENSOR_ID_AIR_PRESSURE		4					/*气压传感器设备*/ //OK
#define SENSOR_ID_MEDICAL_PRESSURE	5					/*医用气压传感器设备*/ //OK
#define SENSOR_ID_HALL				6					/*霍尔传感器设备*/ //OK
#define SENSOR_ID_RAIN				7					/*雨滴传感器设备*/ //OK
#define SENSOR_ID_FLUX				8					/*流量传感器设备*/
#define SENSOR_ID_FIRE				9					/*火焰传感器设备*/ //OK
#define SENSOR_ID_TEMPERATURE		10					/*温度传感器设备*/ //OK
#define SENSOR_ID_DECIBEL			11					/*分贝传感器设备*/ //需要改驱动
#define SENSOR_ID_SMOKE				12					/*烟雾传感器设备*/ //OK
#define	SENSOR_ID_ULTRASONIC		13					/*超声波传感器设备*/
#define SENSOR_ID_UV				14					/*紫外线传感器设备*/ //OK
#define	SENSOR_ID_VIBRATION			15					/*震动传感器设备*/ //需要改驱动
#define	SENSOR_ID_GPS				16					/*GPS设备*/
#define	SENSOR_ID_THREE_AXIS		17					/*3轴加速度传感器设备*/
#define	SENSOR_ID_ALCOHOL			18					/*酒精传感器设备*/
#define	SENSOR_ID_PLUSE				19					/*脉搏传感器设备*/ //需要改驱动
#define	SENSOR_ID_CAMERA			20					/*摄像头设备*/
#define	SENSOR_ID_THERMOPILE		21					/*红外热电堆传感器设备*/ //OK
#define	SENSOR_ID_SOLAR_ENERGY		22					/*太阳能传感器设备*/
#define	SENSOR_ID_RELAY				23					/*继电器传感器设备*/

#define FLUX_IDLE_TIME				500
#define FLUX_TIMEOUT				(CONFIG_SENSOR_RATE)

#endif /* SENSOR_H_ */
