
configuration StaticRouteC
{
	provides interface StaticRoute;
}
implementation
{
	components StaticRouteP;
	StaticRoute = StaticRouteP;
}

