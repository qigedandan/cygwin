
interface OSAMainControl
{
	event void beforeUsrAppRun(error_t error);
	event void afterUsrAppRun(error_t error);
	
	event void beforeUsrAppEnd(error_t error);
	event void afterUsrAppEnd(error_t error);
}

