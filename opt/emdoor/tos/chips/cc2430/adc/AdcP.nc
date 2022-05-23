

module AdcP {

  provides interface Init;
  provides interface AdcControl[uint8_t id];
  provides interface Read<int16_t>[uint8_t id];

}

implementation
{

#include "Adc.h"

  uint8_t references[uniqueCount("UNIQUE_ADC_PORT")];
  uint8_t resolutions[uniqueCount("UNIQUE_ADC_PORT")];
  uint8_t inputs[uniqueCount("UNIQUE_ADC_PORT")];
  bool inUse[uniqueCount("UNIQUE_ADC_PORT")];

  uint8_t counter;
  uint8_t lastId = uniqueCount("UNIQUE_ADC_PORT");

  
  command error_t Init.init() {
    uint8_t i; 
 
    for (i = 0; i < uniqueCount("UNIQUE_ADC_PORT"); i++) {
      inUse[i] = FALSE;
    }

    counter = 0;  
    
    return SUCCESS;
  }


  command void AdcControl.enable[uint8_t id](uint8_t reference, uint8_t resolution, uint8_t input) {

    /* enable interrupt when a channel is enabled (and stop any sampling in progress */
    if (counter == 0) {
      ADCIE = 1;
      ADC_STOP();
    }

    /* enable channel if not already enabled */
    if (!inUse[id]) {
        inUse[id] = TRUE;
        counter++;

        ADC_ENABLE_CHANNEL(inputs[id]);  
    }

    /* save parameters */
    references[id] = reference;
    resolutions[id] = resolution;
    inputs[id] = input;

  }

  command void AdcControl.disable[uint8_t id]() {

    /* disable channel if it has been enabled */
    if (inUse[id]) {
      inUse[id] = FALSE;
      ADC_DISABLE_CHANNEL(inputs[id]);
      counter--;

      /* disable interrupts if no more channels are used by ADC */
      if (counter == 0) {
        ADCIE = 0;
      }
    }
  
  }

  /**
   * Initiates a read of the value.
   * 
   * @return SUCCESS if a readDone() event will eventually come back.
   */
  command error_t Read.read[uint8_t id]() {

    /* check if ADC is in use */
    if (lastId < uniqueCount("UNIQUE_ADC_PORT")) {
        return FAIL;
    } else {
        uint8_t temp;

        /* remember caller */
        lastId = id;

        /* read out any old conversion value */
        temp = ADCH;
        temp = ADCL;

        /* start conversion */
        ADC_SINGLE_CONVERSION(references[id] | resolutions[id] | inputs[id]);

        return SUCCESS;
    }
  }

  task void signalReadDone();
  int16_t value;

  /* Interrupt handler */
  MCS51_INTERRUPT(SIG_ADC) {

    /* read value from register */        
    value = (( (uint16_t) ADCH) << 8);
    value |= ADCL;

    post signalReadDone();
  }

  task void signalReadDone() {
    uint8_t tmp;
    
    /* mark ADC as not in use */
    tmp = lastId;
    lastId = uniqueCount("UNIQUE_ADC_PORT");
  
    /* map out value according to resolution */
    //value >>= (8 - (resolutions[tmp] >> 3));
    
    /* sign extend to int16_t */
    //8bit
//    value >>= 2;
//    value |= 0xC000 * ((value & 0x2000) >> 13);
//#define ADC_8_BIT           0x00     //  64 decimation rate
//#define ADC_10_BIT          0x10     // 128 decimation rate
//#define ADC_12_BIT          0x20     // 256 decimation rate
//#define ADC_14_BIT          0x30     // 512 decimation rate
    

    signal Read.readDone[tmp](SUCCESS, value);    
  }

  default event void Read.readDone[uint8_t id](error_t result, int16_t val) {

  }

}
