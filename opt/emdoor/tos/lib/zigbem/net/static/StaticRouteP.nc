
module StaticRouteP
{
	provides interface StaticRoute;
}
implementation
{
	command uint16_t StaticRoute.getUplinkNode(uint16_t src, staticroute_t *route_table, uint16_t size)
	{
		uint16_t i;
		for (i=0; i < size; ++i)
		{
			if (route_table[i].src == src)
			{
				return route_table[i].dst;
			}
		}

		return 0xFFFF; /* invalid */
	}
	
	command uint16_t StaticRoute.getDownlinkNode(uint16_t src, staticroute_t *route_table, uint16_t size)
	{
		uint16_t i;
		for (i=0; i < size; ++i)
		{
			if (route_table[i].dst == src)
			{
				return route_table[i].src;
			}
		}

		return 0xFFFF; /* invalid */
	}
}

