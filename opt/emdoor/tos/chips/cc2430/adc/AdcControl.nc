

interface AdcControl {

  /**
   * Enables the ADC for the chosen channel with the specified settings.
   * Also, enables interrupts and disables any current sampling.
   * 
   * @param reference - Reference voltage. Possible choices:
   *    ADC_REF_1_25_V      0x00 // Internal 1.25V reference
   *    ADC_REF_P0_7        0x40 // External reference on AIN7 pin
   *    ADC_REF_AVDD        0x80 // AVDD_SOC pin
   *    ADC_REF_P0_6_P0_7   0xC0 // External reference on AIN6-AIN7 differential input
   *
   * @param resolution - ADC conversion resoltion. Possible values:
   *    ADC_8_BIT           0x00     //  64 decimation rate
   *    ADC_10_BIT          0x10     // 128 decimation rate
   *    ADC_12_BIT          0x20     // 256 decimation rate
   *    ADC_14_BIT          0x30     // 512 decimation rate
   * @param input - ADC input channel. Possible values:
   *    ADC_AIN0            0x00     // single ended P0_0
   *    ...
   *    ADC_AIN7            0x07     // single ended P0_7
   *    ADC_GND             0x0C     // Ground
   *    ADC_TEMP_SENS       0x0E     // on-chip temperature sensor
   *    ADC_VDD_3           0x0F     // (vdd/3)
   */
  command void enable(uint8_t reference, uint8_t resolution, uint8_t input);
  command void disable();
}
