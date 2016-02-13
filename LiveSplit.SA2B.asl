state("sonic2app")
{
	bool isLoading : "sonic2app.exe", 0x16557E4;
	bool runStart : "sonic2app.exe", 0x134AFFA;
	bool levelEnd : "sonic2app.exe", 0x134B002;
}

start
{
	return current.runStart && !old.runStart;
}

reset
{
}

split
{
	return current.levelEnd && !old.levelEnd;
}

isLoading
{
	return current.isLoading;
}

gameTime
{
}
