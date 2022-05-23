

/* FILL IN THE BLANKS!!! */


   /**
    * Sets the UxBR0 and UxBR1 Baud Rate Control Registers
    */
   async command void setUbr(uint16_t ubr);

   /**
    * Reads the UxBR0 and UxBR1 Baud Rate Control Registers
    */
   async command uint16_t getUbr();

   async command void resetUsart(bool reset);

  /**
   * Returns an enum value corresponding to the current mode of the
   * USART module.
   */
  async command cc2430_usartmode_t getMode();

  /**
   * Returns TRUE if the USART has Uart TX mode enabled
   */
  async command bool isUartTx();

  /**
   * Returns TRUE if the USART has Uart RX mode enabled
   */
  async command bool isUartRx();

  /**
   * Returns TRUE if the USART is set to Uart mode (both RX and TX)
   */
  async command bool isUart();

 /**
   * Enables both the Rx and the Tx Uart modules.
   */
  async command void enableUart();

 /**
   * Disables both the Rx and the Tx Uart modules.
   */
  async command void disableUart();

 /**
   * Enables the Uart TX functionality of the USART module.
   */
  async command void enableUartTx();

 /**
   * Disables the Uart TX module.
   */
  async command void disableUartTx();

 /**
   * Enables the Uart RX functionality of the USART module.
   */
  async command void enableUartRx();

 /**
   * Disables the Uart RX module.
   */
  async command void disableUartRx();



 /**
   * Switches USART to Uart TX mode (RX pins disabled).
   * Interrupts disabled by default.
   */
  async command void setModeUartTx(cc2430_uart_config_t* config);

 /**
   * Switches USART to Uart RX mode (TX pins disabled)..
   * Interrupts disabled by default.
   */
  async command void setModeUartRx(cc2430_uart_config_t* config);

 /**
   * Switches USART to Uart mode (RX and TX enabled)
   * Interrupts disabled by default.
   */
  async command void setModeUart(cc2430_uart_config_t* config);

  /**
   * Returns TRUE if the module is set to I2C mode for CC2430 parts
   * that support hardware I2C.
   */
  async command bool isI2C();

  /**
   * Switches USART to I2C mode for CC2430 parts that support hardware
   * I2C. Interrupts disabled by default.
   */
  async command void setModeI2C(cc2430_i2c_config_t* config);

  /* Dis/enabling of UTXIFG / URXIFG */
  async command void disableRxIntr();
  async command void disableTxIntr();
  async command void disableIntr();
  async command void enableRxIntr();
  async command void enableTxIntr();
  async command void enableIntr();

  /**
   * TRUE if TX interrupt pending, flag must be cleared explicitly
   */
  async command bool isTxIntrPending();

  /**
   * TRUE if RX interrupt pending, flag must be cleared explicitly
   */
  async command bool isRxIntrPending();

  /**
   * Clears RX interrupt pending flag
  */
  async command void clrRxIntr();

  /**
   * Clears TX interrupt pending flag
   */
  async command void clrTxIntr();

  /**
   * Clears both TX and RX interrupt pending flags
   */
  async command void clrIntr();

  /**
   * SUCCESS if the TX buffer is empty and all of the bits have been
   * shifted out
   */
  async command bool isTxEmpty();

 /**
   * Transmit a byte of data. When the transmission is completed,
   * <code>txDone</done> is generated. Only then a new byte may be
   * transmitted, otherwise the previous byte will be overwritten.
   * The mode of transmission (Uart or Spi) depends on the current
   * state of the USART, which must be managed by a higher layer.
   *
   * @return SUCCESS always.
   */
  async command void tx(uint8_t data);

  /**
   * Get current value from RX-buffer.
   *
   * @return SUCCESS always.
   */
  async command uint8_t rx();












   /*
   async command void setI2Cpsc(uint8_t control);
   async command uint8_t getI2Cpsc();

   async command void setI2Csclh(uint8_t control);
   async command uint8_t getI2Csclh();

   async command void setI2Cscll(uint8_t control);
   async command uint8_t getI2Cscll();

   async command void setI2Coa(cc2430_i2c_oa_t address);
   async command cc2430_i2c_oa_t getI2Coa();

   async command void setI2Ctctl(cc2430_i2ctctl_t control);
   async command cc2430_usart_i2ctctl_t getI2Ctctl();
   */

   /**
    * Sets the UxCTL Control Register
    */
   async command void setUctl(cc2430_uctl_t control);

   /**
    * Reads the UxCTL Control Register
    */
   async command cc2430_uctl_t getUctl();

   /**
    * Sets the UxTCTL Transmit Control Register
    */
   async command void setUtctl(cc2430_utctl_t control);

   /**
    * Reads the UxTCTL Transmit Control Register
    */
   async command cc2430_utctl_t getUtctl();

   /**
    * Sets the UxRCTL Receive Control Register
    */
   async command void setUrctl(cc2430_urctl_t control);

   /**
    * Reads the UxRCTL Receive Control Register
    */
   async command cc2430_urctl_t getUrctl();



   /**
    * Sets the UxMCTL Modulation Control Register
    */
   async command void setUmctl(uint8_t umctl);

   /**
    * Reads the UxMCTL Modulation Control Register
    */
   async command uint8_t getUmctl();

 /**
   * Enables the USART when in Spi mode.
   */
  async command void enableSpi();

 /**
   * Disables the USART when in Spi mode.
   */
  async command void disableSpi();

  /**
   * Enables the I2C module (register flags)
   */
  async command void enableI2C();

  /**
   * Disables the I2C module
   */
  async command void disableI2C();

  /**
   * Returns TRUE if the USART is set to Spi mode
   */
  async command bool isSpi();

 /**
   * Switches USART to Spi mode.
   */
  async command void setModeSpi(cc2430_spi_config_t* config);
