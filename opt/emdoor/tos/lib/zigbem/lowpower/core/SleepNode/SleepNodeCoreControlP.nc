
module SleepNodeCoreControlP
{
	provides interface SleepNodeCoreControl;
	uses interface StateLockMan;
}
implementation
{
	command bool SleepNodeCoreControl.isBusy()
	{
		atomic return call StateLockMan.isLocked();
	}

	event void StateLockMan.lockFired()
	{
		//ADBG(DBG_LEV, "StateLockMan.lockFired()\n");
		signal SleepNodeCoreControl.busy();
	}

	event void StateLockMan.unlockFired()
	{
		//ADBG(DBG_LEV, "StateLockMan.unlockFired()\n");
		if (!call StateLockMan.isLocked())
		{
			signal SleepNodeCoreControl.free();
		}
	}

	default event void SleepNodeCoreControl.busy()
	{
	}
	
	default event void SleepNodeCoreControl.free()
	{
	}
}

