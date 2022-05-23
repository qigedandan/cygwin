#include "ioCC2430.h"
#include "DS18B20Data.h"

configuration DS18B20DataC
{
    provides interface DS18B20Data;
}
implementation
{
    components DS18B20DataP;
    DS18B20Data = DS18B20DataP;
    
    components MainC;
    MainC.SoftwareInit -> DS18B20DataP;
}
