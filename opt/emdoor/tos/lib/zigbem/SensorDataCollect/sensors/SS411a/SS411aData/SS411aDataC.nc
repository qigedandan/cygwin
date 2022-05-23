configuration SS411aDataC
{
    provides interface SS411aData;
}
implementation
{
    components SS411aDataP;
    SS411aData = SS411aDataP;
}
