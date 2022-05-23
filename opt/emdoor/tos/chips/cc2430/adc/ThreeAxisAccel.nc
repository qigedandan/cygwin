

	enum conversion_status {
		ACCEL_STATUS_SUCCESS = 0x00,
        ACCEL_STATUS_CONVERSION_FAILED = 0x01,
        ACCEL_STATUS_BLOCKMODE_FAILED = 0x02,
        ACCEL_STATUS_OUT_OF_BOUNCE = 0x04,
	};
	
	enum accelerometer_range {
		ACCEL_RANGE_2x5G = 0x00,
		ACCEL_RANGE_6x7G = 0x01,
		ACCEL_RANGE_3x3G = 0x02,
		ACCEL_RANGE_10x0G = 0x03,
	};

interface ThreeAxisAccel {

  command error_t setRange(uint8_t range);
	
  command error_t getData();
  event error_t dataReady(uint16_t xaxis, uint16_t yaxis, uint16_t zaxis, uint8_t status);
}
