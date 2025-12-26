# XS Scripting F.A.Q.
These questions and answers are ONLY specific to XS scripting.
They answer how to do something using XS code, any other required external triggers/rms scripts will be mentioned explictly.




## Q: How to detect if a technology has been researched ? !! Update 153015: Use new function `xsGetTechState` instead.
For some reason XS provides a way to modify techs but no way to actually query what you modified or the current state of a technology.
You can only force a state. I don't know why this is the case, but it is. There is NO Tech Researched method like the editor condition.

### Workaround: Callback from a trigger.
For each tech you want to detect...
- Add a new trigger in the scenario with condition "Tech Researched",
- Then add an effect to that trigger "Script Call" to call some xs function.(must be void)
- (Alternative) You can also set some resource/variable/object attribute then check that value's state in your XS script.

### Method 1 : Check research cost change.
- Set the tech cost to an unused resource.
- Check for a resource change of that resource id on the researching player.

*ref: https://forums.ageofempires.com/t/how-can-i-make-a-technology-that-doesnt-develop-automatically-when-selecting-a-post-era-era-read-details/253763
### Method 2 : Using `xsResearchTechnology`
The official documentation indicated tha `xsResearchTechnology` should return false when researching a technology is not possible.
This way we can check if the player already researched the technology to as a condition. While this works, it has one major issue,
you have to research the tech if its available - making it unavailable to the player:
Function prototype:
	`bool xsResearchTechnology(int techID, bool force, bool techAvailable, int playerNumber)`

```
// Inside a loop or rule...
if(_NOT(xsResearchTechnology(cQTID_EmptyTech0, false, true, 1))){
	xsChatData("<RED>[UnitSpawnerTest] Next Unit ID.");
	xsEffectAmount(cModifyTech, 1180, cAttrSetState, XS_TechnologyState_Enabled);
} else {
	xsChatData("<RED>[UnitSpawnerTest] Upgrade rearched.");
	xsEffectAmount(cModifyTech, 1180, cAttrSetState, XS_TechnologyState_Enabled);
}
```

### Method 3 : Detect the resulting effect of an existing technology.
Most technologies will have some builtin effects such as changing a resource or unit,
you can choose to override and use one of these techs. Then detect that tech's effect and react:
- Choose a tech that has a known effect (You can see every techs effect in the AOE Genie Editor).
- Detect the effect of that technology from your xs script in a rule or loop.