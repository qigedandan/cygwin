module HplCC2430Timer3CaptureP
{
    provides interface GpioCapture;
    provides interface Init;
}
implementation
{
    command error_t Init.init()
    {
        return SUCCESS;
    }

    async command error_t GpioCapture.captureRisingEdge()
    {
        
    }
    async command error_t GpioCapture.captureFallingEdge()
    {
        
    }

    /**
    * Fired when an edge interrupt occurs.
    *
    * @param val The value of the 32kHz timer.
    */
    async event void captured(uint16_t time);

    /**
    * Disable further captures.
    */ 
    async command void disable();
}

