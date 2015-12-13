state("BorderlandsPreSequel")
{
	//v1.0.1
	bool isLoading101 : "BorderlandsPreSequel.exe", 0x1C3EF50;
	bool playerIsLocked101 : "BorderlandsPreSequel.exe", 0x1C46E14;
	uint playerxp101 : "BorderlandsPreSequel.exe", 0x1C538B4;
	uint playerxph101 : "BorderlandsPreSequel.exe", 0x1C538B8;
	//int mapId101 : "BorderlandsPreSequel.exe", 0x1C3FB2C;
	
	//v1.0.3
	bool isLoading103 : "BorderlandsPreSequel.exe", 0x1C53040;
	bool playerIsLocked103 : "BorderlandsPreSequel.exe", 0x1C5AFC0;
	uint playerxp103 : "BorderlandsPreSequel.exe", 0x1C67914;
	uint playerxph103 : "BorderlandsPreSequel.exe", 0x1C67918;
	
	//v1.0.4
	bool isLoading104 : "BorderlandsPreSequel.exe", 0x1C6C0D0;
	bool playerIsLocked104 : "BorderlandsPreSequel.exe", 0x1C740C4;
	uint playerxp104 : "BorderlandsPreSequel.exe", 0x1C80A64;
	uint playerxph104 : "BorderlandsPreSequel.exe", 0x1C80A68;
	
	//v1.0.5
	//V1.0.5 timer pauses during the mooshot + Eleseer cutscene.
	bool isLoading105 : "BorderlandsPreSequel.exe", 0x1BEFA1C;
	bool playerIsLocked105 : "BorderlandsPreSequel.exe", 0x1CAC210;
	uint playerxp105 : "BorderlandsPreSequel.exe", 0x1CB8C44;
	uint playerxph105 : "BorderlandsPreSequel.exe", 0x1CB8C48;
	//int mapId105 : "BorderlandsPreSequel.exe", 0x;
}
start
{
	if(!((IDictionary<String, object>)current).ContainsKey("isInit") || current.isInit == false)
	{
		System.Diagnostics.Process [] processes = System.Diagnostics.Process.GetProcessesByName("BorderlandsPreSequel");
		if (processes.Length == 1)
		{
			current.isInit = true;
			
			System.Diagnostics.Process process = processes.FirstOrDefault();
			System.Diagnostics.ProcessModule pm = process.MainModule;
			System.Diagnostics.FileVersionInfo fi = pm.FileVersionInfo;
			
			//System.IO.File.AppendAllText(@"C:\temp\TPS_version.txt", fi.ProductVersion);
			current.ProductVersion = 0;
			if ("1.0.102036.102036" == fi.ProductVersion)
			{
				//v1.0.4
				current.ProductVersion = 104;
			}
			else if ("1.0.99567.99567" == fi.ProductVersion)
			{
				//v1.0.3
				current.ProductVersion = 103;
			}
			else if ("1.0.89250.89250" == fi.ProductVersion)
			{
				//v1.0.1
				current.ProductVersion = 101;
			}
			else if ("1.0.105184.105184" == fi.ProductVersion)
			{
				//v1.0.5
				current.ProductVersion = 105;
			}
		}
		else
		{
			return false;
		}
	}
	if (104 == current.ProductVersion)
	{
		current.isLoading = current.isLoading104;
		current.playerxph = current.playerxph104;
		current.playerxp = current.playerxp104;
		current.playerIsLocked = current.playerIsLocked104;
	}
	else if (103 == current.ProductVersion)
	{
		current.isLoading = current.isLoading103;
		current.playerxph = current.playerxph103;
		current.playerxp = current.playerxp103;
		current.playerIsLocked = current.playerIsLocked103;
	}
	else if (101 == current.ProductVersion)
	{
		current.isLoading = current.isLoading101;
		current.playerxph = current.playerxph101;
		current.playerxp = current.playerxp101;
		current.playerIsLocked = current.playerIsLocked101;
	}
	else if (105 == current.ProductVersion)
	{
		current.isLoading = current.isLoading105;
		current.playerxph = current.playerxph105;
		current.playerxp = current.playerxp105;
		current.playerIsLocked = current.playerIsLocked105;
	}
	else
	{
		return false;
	}
	current.loadsCount = 0;
	current.loadingTime = 0.0;
	current.eleseerStatus = 0;
	current.moonshotCutSceneTime = 0.0;
	return !current.isLoading && current.playerxph==0 && current.playerxp==0 && !current.playerIsLocked && old.playerIsLocked;
}
reset
{
	if (104 == current.ProductVersion)
	{
		current.isLoading = current.isLoading104;
		current.playerxph = current.playerxph104;
		current.playerxp = current.playerxp104;
		current.playerIsLocked = current.playerIsLocked104;
	}
	else if (103 == current.ProductVersion)
	{
		current.isLoading = current.isLoading103;
		current.playerxph = current.playerxph103;
		current.playerxp = current.playerxp103;
		current.playerIsLocked = current.playerIsLocked103;
	}
	else if (101 == current.ProductVersion)
	{
		current.isLoading = current.isLoading101;
		current.playerxph = current.playerxph101;
		current.playerxp = current.playerxp101;
		current.playerIsLocked = current.playerIsLocked101;
	}
	else if (105 == current.ProductVersion)
	{
		current.isLoading = current.isLoading105;
		current.playerxph = current.playerxph105;
		current.playerxp = current.playerxp105;
		current.playerIsLocked = current.playerIsLocked105;
	}
	else
	{
		return false;
	}
	return !current.isLoading && current.playerxph==0 && current.playerxp==0 && current.playerIsLocked && !old.playerIsLocked;
}
isLoading
{
	bool b = current.isLoading && !current.playerIsLocked;
	if (104 < current.ProductVersion)
	{
		return b;
	}
	
	if (b)
	{
		if (!old.isLoading)
		{
			current.loadsCount++;
			current.loadingTime = timer.CurrentTime.RealTime.TotalMilliseconds;
			if (current.loadsCount == 1)
			{
				current.moonshotCutSceneTime = timer.CurrentTime.RealTime.TotalMilliseconds+5000.0;
				return false;
			}
			else if (current.eleseerStatus == 2)
			{
				//ready for the next pt.
				current.eleseerStatus = 0;
			}
		}
		else if (current.eleseerStatus == 0)
		{
			//detects a long loading screen
			if (timer.CurrentTime.RealTime.TotalMilliseconds - current.loadingTime > 40000.0)
			{
				//eleseer cut scene detected
				current.eleseerStatus = 1;
			}
		}
		
		if (current.loadsCount == 1 || current.moonshotCutSceneTime > timer.CurrentTime.RealTime.TotalMilliseconds)
		{
			//don't stop the timer during the moonshot cutscene which is the first cutscene
			// + extra safety, we don't pause the timer for the next 5s.
			return false;
		}
	}
	return b;
}
gameTime
{
	if (current.eleseerStatus == 1)
	{
		current.eleseerStatus = 2;
		//Add 46.4s for the Eleseer cut scene.
		return timer.CurrentTime.GameTime.Add(TimeSpan.FromMilliseconds(46400));
	}
	return null;
}
