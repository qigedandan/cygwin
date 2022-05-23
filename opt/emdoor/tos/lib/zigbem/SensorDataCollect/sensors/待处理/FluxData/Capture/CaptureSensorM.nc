generic module CaptureSensorM(uint32_t timeout)
{
	provides interface CaptureSensor;
    
	uses interface GpioCapture;
	uses interface Timer<TMilli>;
}
implementation
{
	uint16_t m_capture_value = 0;

	command error_t CaptureSensor.read()
	{
		ADBG(2000, "\nCaptureSensor.read()\n");
		atomic m_capture_value = 0;
		call Timer.startOneShot(timeout);
		call GpioCapture.captureFallingEdge();
		call GpioCapture.captureRisingEdge();

		return SUCCESS;
	}

	async event void GpioCapture.captured(uint16_t time)
	{
		atomic m_capture_value++;
		ADBG(1000, "*");
	}

	task void readDoneTask()
	{
		signal CaptureSensor.readDone(SUCCESS, m_capture_value);
	}

	event void Timer.fired()
	{
		call GpioCapture.disable();
		post readDoneTask();
		ADBG(1000, "CaptureSensor.readDone()\n");
	}
	
	default event void CaptureSensor.readDone(error_t result, uint16_t capture_value)
	{
	}
}

