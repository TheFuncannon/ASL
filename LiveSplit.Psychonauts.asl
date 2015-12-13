state("Psychonauts")
{
	bool startedLoading : "Psychonauts.exe", 0x00338D88, 0x9900;
	byte finishedLoading : "Psychonauts.exe", 0x00338D88, 0x9A30;
}

start
{
	bool isLoading = false;
}

split
{
}

isLoading
{
	if (current.finishedLoading == 0x03)
		current.isLoading = false;
	if (current.startedLoading)
		current.isLoading = true;
	return current.isLoading;
}

gameTime
{
}