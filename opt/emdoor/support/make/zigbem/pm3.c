/*
 * File: pm3.c
 * @autor: xlq, 2007-11
 * */
/* CC2430 PM3 XDATA
*
* When CC2430 run into the PowerMode3(Ultra low power), only the data in XDATA(0xF000-0xFFFF) can be retained
* so we should specify the data that should be retain in the XDATA address 0xF000-0xFFFF(we call XDATA_PM3).
* In KEIL, we can use the directive USERCLASS and LX51 options to specify the variable in the XDATA_PM3.
* But there's still a problem: the KEIL doesn't support different variable USERCLASS in the same file,
* So we sperate the app.c into two file, app.c and pm3.c.
* The pm3.c will have all the variable in the XDATA_PM3
*
* Usage: to specify the variable in the XDATA_PM3, use the xdata_pm3 attribute.
*
* Example: uint8_t_xdata_pm3 foo = 3;
*
*/

/* use this to enable the LX51 user class */
#pragma userclass (xdata = pm3)

