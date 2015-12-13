state("Borderlands2")
{
	bool isLoading11 : "Borderlands2.exe", 0x15EEE40;
	byte isOnTitle11: "Borderlands2.exe", 0x14F10E0;
	bool isLocked11: "Borderlands2.exe", 0x15F85E8;
	
	byte versionCheck : "Borderlands2.exe", 0x15EEE48;
	
	bool isLoading183 : "Borderlands2.exe", 0x1ED51D0;
	bool isOnTitle183: "Borderlands2.exe", 0x1DD5137;
	bool isLocked183: "Borderlands2.exe", 0x1EDEA64;
}

start
{
	return (current.versionCheck != 0x18 ? (old.isLocked183 && !current.isLocked183) : (old.isLocked11 && !current.isLocked11));
}

split
{
}

isLoading
{
	return (current.versionCheck != 0x18 ? current.isLoading183 || current.isOnTitle183 : current.isLoading11 || (current.isOnTitle11 != 0));
}

gameTime
{
}