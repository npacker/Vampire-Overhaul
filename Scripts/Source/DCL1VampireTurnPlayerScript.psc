Scriptname DCL1VampireTurnPlayerScript extends ReferenceAlias
{ Script on Player alias in DLC1VampireTurn quest. }

Event OnLocationChange(Location akOldLoc, Location akNewLoc)

  (GetOwningQuest() as DLC1VampireTurnScript).PlayerChangedLocationCompleteChange()

EndEvent

Event OnPlayerLoadGame()

  (GetOwningQuest() as DLC1VampireTurnScript).MakeAliasesEyesRed()

EndEvent
