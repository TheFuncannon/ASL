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

state("Borderlands2", "1.3.1")
{
	bool onLoadScreen: 0x1E5BE00;
	byte isOnTitle: 0x1D5C0B7;
	bool isLocked: 0x1E65724;
}

state("Borderlands2", "1.8.4")
{
	bool onLoadScreen: 0x1EEF1C0;
	bool isOnTitle: 0x1F055A0;
	bool isLocked: 0x1EF8B00;
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
		case "1.0.28.697606":
			version = "1.3.1";
			break;
		case "1.0.38.7335":
			version = "1.8.4";
			break;
		case "1.0.38.1055911":
			version = "1.8.4";
			break;
	}
}

update
{
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
