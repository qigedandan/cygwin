/**************************************************************************************************
 *                                        - ioCC2431.h -
 *
 * Special header for the Chipcon CC2431 System on Chip.
 *
 **************************************************************************************************
 */

#ifndef IOCC2431_H
#define IOCC2431_H

#include "ioCC2430.h"

/* ------------------------------------------------------------------------------------------------
 *                                       Xdata Radio Registers
 * ------------------------------------------------------------------------------------------------
 */

#define REFCOORD    _XIO8( 0xDF55 )  /*  Location Engine, Reference Coordinates Input        */
#define MEASPARM    _XIO8( 0xDF56 )  /*  Location Engine, Measured Parameters Input          */
#define LOCENG      _XIO8( 0xDF57 )  /*  Location Engine, Location Engine Control and Status */
#define LOCX        _XIO8( 0xDF58 )  /*  Location Engine, Location Estimate X Coordinate     */
#define LOCY        _XIO8( 0xDF59 )  /*  Location Engine, Location Estimate Y Coordinate     */
#define LOCMIN      _XIO8( 0xDF5A )  /*  Location Engine, Minimum Function Estimate          */
#define CHVER       _XIO8( 0xDF60 )  /*  Location Engine, Chip Version           */
#define CHIPID      _XIO8( 0xDF61 )  /*  Location Engine, Chip Identification           */
/**************************************************************************************************
 */
#endif
