/*
Scanning Best Practices:

loading
byte value thats basically a bool, 1 while loading and 0 in game

mainmenu
1 on MM, 38 on transition into game. random numbers on transition back into main menu

Y pos
Floor 1 == 1.813140083E-41
Floor 12 == 3.154322843E-41
*/

state("DudeSimulator5")
{
    bool loading  : "UnityPlayer.dll", 0x010DB628, 0x20;
    byte mainmenu : "UnityPlayer.dll", 0x10D9075;
}

startup
  {
	// Asks user to change to game time if LiveSplit is currently set to Real Time.
		if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {        
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Dude Simulator 5",
            MessageBoxButtons.YesNo,MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
}

onStart
{
    // This makes sure the timer always starts at 0.00
    timer.IsGameTimePaused = true;
}

start
{
    return current.mainmenu == 38 && old.mainmenu != 38;
}

/*
split
{
    return 
    current.mainmenu == 133 && old.mainmenu != 133 ||
    current.mainmenu == 134 && old.mainmenu != 134 || 
    current.mainmenu == 137 && old.mainmenu != 137;
    //find value for quitting from trash bag

}
*/

update
{
	//DEBUG CODE 
	//print(modules.First().ModuleMemorySize.ToString());
	//print(current.loading.ToString());
    //print(current.mainmenu.ToString());
}

isLoading
{
    return current.loading;
}

exit
{
    //pauses timer if the game crashes
	timer.IsGameTimePaused = true;
}
