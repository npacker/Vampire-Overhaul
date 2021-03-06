Scriptname DLC1PlayerVampireScript extends ReferenceAlias

Race Property DLC1VampireBeastRace Auto

Spell Property DLC1VampireBats Auto
Spell Property DLC1SupernaturalReflexes Auto
Spell Property DLC1VampireMistform Auto

GlobalVariable Property DLC1BatsCount Auto
GlobalVariable Property DLC1MistformCount Auto
GlobalVariable Property DLC1ReflexesCount Auto

Spell Property CurrentEquippedSpell Auto
Spell Property CurrentEquippedPower Auto

Event OnPlayerLoadGame()

  (GetOwningQuest() as DLC1PlayerVampireChangeScript).HandlePlayerLoadGame()

EndEvent

Event OnRaceSwitchComplete()

  Actor PlayerRef = GetReference() as Actor

  DLC1BatsCount.SetValue(0)
  DLC1MistformCount.SetValue(0)
  DLC1ReflexesCount.SetValue(0)

  If PlayerRef.GetRace() == DLC1VampireBeastRace
    (GetOwningQuest() as DLC1PlayerVampireChangeScript).PostChange()
  Else
    (GetOwningQuest() as DLC1PlayerVampireChangeScript).PostRevert()
  EndIf

EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)

  Actor PlayerRef = GetReference() as Actor

  CurrentEquippedSpell = PlayerRef.GetEquippedSpell(0)
  CurrentEquippedPower = PlayerRef.GetEquippedSpell(2)

  If CurrentEquippedSpell && (akBaseObject == CurrentEquippedSpell)
    (GetOwningQuest() as DLC1PlayerVampireChangeScript).HandleEquippedSpell(CurrentEquippedSpell)
  EndIf

  If CurrentEquippedPower && (akBaseObject == CurrentEquippedPower)
    (GetOwningQuest() as DLC1PlayerVampireChangeScript).HandleEquippedPower(CurrentEquippedPower)
  EndIf

EndEvent
