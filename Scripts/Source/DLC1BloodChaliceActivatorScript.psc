Scriptname DLC1BloodChaliceActivatorScript extends ObjectReference
{ Attached to DLC1BloodChaliceActivatorFull activator. }

DLC1BloodChaliceQuestScript Property DLC1BloodChaliceQuest Auto

Event OnActivate(ObjectReference akActivator)

  if akActivator == Game.GetPlayer()
    DLC1BloodChaliceQuest.ChaliceDrink()
  endif

EndEvent
