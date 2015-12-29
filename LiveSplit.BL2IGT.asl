state("Borderlands2")
{
	bool onLoadScreen: 0x1ED51D0;
	bool isOnTitle:	0x1DD5137;
	bool isLocked: 0x1EDEA64;
}

state("Borderlands2", "1.1")
{
	bool onLoadScreen: 0x15EEE40;
	byte isOnTitle: 0x14F10E0;
	bool isLocked: 0x15F85E8;
}

init
{
	vars.doStart = false;
	vars.isLoading = false;
	switch (modules.First().FileVersionInfo.FileVersion)	
	{
		case "1.0.9.15588":
			version = "1.1";
			break;
		case "1.0.9.670948":
			version = "1.1";
			break;
	}
}

update
{
	print(modules.First().FileVersionInfo.FileVersion);
	vars.doStart = false;
	vars.isLoading = false;
	if (old.isLocked && !current.isLocked)
	{
		vars.doStart = true;
	}
	if (current.onLoadScreen || Convert.ToBoolean(current.isOnTitle))
	{
		vars.isLoading = true;
	}
}

start
{
	return vars.doStart;
}

isLoading
{
	return vars.isLoading;
}
