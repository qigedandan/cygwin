//=============================================================================
//	Document:		SensorCollectionC.nc
//	Description:	配置源文件，用于配置各个传感器的驱动程序
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

#include "Sensor.h"

configuration SensorCollectionC 
{
	provides interface SensorCollection;
}
implementation {
	
	components SensorCollectionP;
	SensorCollection = SensorCollectionP;	
	
	components GL4548C;
	SensorCollectionP.SensorData[SENSOR_ID_ILLUMINATION] -> GL4548C;

	components SHTxxC;	
	SensorCollectionP.SensorData[SENSOR_ID_TEMP_AND_HUMI] -> SHTxxC;

	components MPS150aC;	
	SensorCollectionP.SensorData[SENSOR_ID_AIR_PRESSURE] -> MPS150aC;

	components MPS500gC;	
	SensorCollectionP.SensorData[SENSOR_ID_MEDICAL_PRESSURE] -> MPS500gC;
	
	components UVA1210C;	
	SensorCollectionP.SensorData[SENSOR_ID_UV] -> UVA1210C;
	
	components ECM6030C;	
	SensorCollectionP.SensorData[SENSOR_ID_DECIBEL] -> ECM6030C;
	
	components OTP538uC;	
	SensorCollectionP.SensorData[SENSOR_ID_THERMOPILE] -> OTP538uC;
	
	components D203sC;	
	SensorCollectionP.SensorData[SENSOR_ID_INFRARED] -> D203sC;
	
	components JNHB1004C;
	SensorCollectionP.SensorData[SENSOR_ID_FIRE] -> JNHB1004C;
		
	components SS411aC;
	SensorCollectionP.SensorData[SENSOR_ID_HALL] -> SS411aC;
	
	components SSM002C;
	SensorCollectionP.SensorData[SENSOR_ID_RAIN] -> SSM002C;
	
	components HDSZC;
	SensorCollectionP.SensorData[SENSOR_ID_VIBRATION] -> HDSZC;
/*	
	components FluxDataC;
	SensorCollectionP.SensorData[SENSOR_ID_FLUX] -> FluxDataC;
*/	
		
	components MQ2C;
	SensorCollectionP.SensorData[SENSOR_ID_SMOKE] -> MQ2C;
	
	components DS18B20C;
	SensorCollectionP.SensorData[SENSOR_ID_TEMPERATURE] -> DS18B20C;	

}

