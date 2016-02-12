state("sonic2app")
{
	byte centiseconds : "sonic2app.exe", 0x134AFDD;
	bool isLoading : "sonic2app.exe", 0x16557E4;
	bool levelEnd : "sonic2app.exe", 0x134AFFA;
}

start
{
}

reset
{
}

split
{
	return !current.levelEnd && old.levelEnd;
}

isLoading
{
	return current.isLoading;
}

gameTime
{
}
