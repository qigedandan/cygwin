

interface DiagnoseQuery
{
	command error_t sendData(const char* string);
	event void requestData();
}
