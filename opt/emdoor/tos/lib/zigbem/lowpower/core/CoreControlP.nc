
generic module CoreControlP()
{
	provides interface CoreControl;
	provides interface CoreControlOwner;
}
implementation
{
	norace uint16_t m_flag_bitmap = 0x0000;


	command error_t CoreControlOwner.setBusy(uint8_t flag)
	{
		atomic m_flag_bitmap |= _BV(flag);

		//ADBG(DBG_LEV, "CoreControlOwner.setBusy flag=%d\n", (int)flag);

		signal CoreControl.busy();

		return TRUE;
	}

	command void CoreControlOwner.setFree(uint8_t flag)
	{
		atomic m_flag_bitmap &= ~ _BV(flag);

		//ADBG(DBG_LEV, "CoreControlOwner.setFree flag=%d\n", (int)flag);

		if (!call CoreControl.isBusy())
		{
			signal CoreControl.free();
		}
	}
	
	command bool CoreControl.isBusy()
	{
		atomic return (m_flag_bitmap != 0x0000);
	}
	
	default event void CoreControl.busy()
	{
	}
	default event void CoreControl.free()
	{
	}
}

