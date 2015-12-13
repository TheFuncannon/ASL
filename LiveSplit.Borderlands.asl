state("Borderlands")
{
	bool isLoading1 : "Borderlands.exe", 0x00480AF0, 0;
	bool isLoading2 : "Borderlands.exe", 0x001E1F1C, 0;
}

start
{
}

split
{
}

isLoading
{
	return (current.isLoading1 || current.isLoading2);
}

gameTime
{
}