state("sonic2app")
{
	bool isLoading : "sonic2app.exe", 0x16557E4;
	bool runStart : "sonic2app.exe", 0x134AFFA;
	bool levelEnd : "sonic2app.exe", 0x134B002;
	bool timerEnd : "sonic2app.exe", 0x134AFDA;
	byte map : "sonic2app.exe", 0x1534B70;
	byte minutes : "sonic2app.exe", 0x134AFDB;
	byte seconds : "sonic2app.exe", 0x134AFDC;
	byte centiseconds : "sonic2app.exe", 0x134AFDD;
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
	if (current.map == 42 && (current.seconds >= 15))
	{
		return current.timerEnd && !old.timerEnd;
	}
	if (current.map == 70 && (current.minutes >= 2))
	{
		return current.timerEnd && !old.timerEnd;
	}
	return current.levelEnd && !old.levelEnd;
}

isLoading
{
	return current.isLoading;
}

gameTime
{
}
