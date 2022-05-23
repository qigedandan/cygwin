#ifndef SHTxx_H
#define SHTxx_H

#define SHTxx_DATA		P0_1
#define SHTxx_DATA_OUT	MAKE_IO_PIN_OUTPUT(P0_DIR, 1)
#define SHTxx_DATA_IN	MAKE_IO_PIN_INPUT(P0_DIR, 1)

#define SHTxx_SCK		P1_7
#define SHTxx_SCK_OUT	MAKE_IO_PIN_OUTPUT(P1_DIR, 7)
#define SHTxx_SCK_IN	MAKE_IO_PIN_INPUT(P1_DIR, 7)

#define SHTxx_TIMEOUT	300

#endif
