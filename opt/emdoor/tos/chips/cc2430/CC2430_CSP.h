

#define _CC2430_SNOP 0xC0

// Immediate command strobes

#define _CC2430_ISSTOP      0xFF
#define _CC2430_ISSTART     0xFE
#define _CC2430_ISTXCALN    0xE1
#define _CC2430_ISRXON      0xE2
#define _CC2430_ISTXON      0xE3
#define _CC2430_ISTXONCCA   0xE4
#define _CC2430_ISRFOFF     0xE5
#define _CC2430_ISFLUSHRX   0xE6
#define _CC2430_ISFLUSHTX   0xE7
#define _CC2430_ISACK       0xE8
#define _CC2430_ISACKPEND   0xE9




// Conditions _c_ for the RPT and SKIP instructions of the CSP
#define _CCA_TRUE            0x00
#define _RECEIVING           0x01
#define _MCU_BIT_IS_1        0x02
#define _COMMAND_BUF_EMPT    0x03
#define _REGX_IS_0           0x04
#define _REGY_IS_0           0x05
#define _REGZ_IS_0           0x06
#define _NO_OP               0x07
