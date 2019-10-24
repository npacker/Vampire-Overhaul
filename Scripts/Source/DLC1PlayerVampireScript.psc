Scriptname DLC1PlayerVampireScript extends ReferenceAlias

Race Property DLC1VampireBeastRace Auto

Spell Property DLC1VampireBats Auto
Spell Property DLC1SupernaturalReflexes Auto
Spell Property DLC1VampireMistform Auto

GlobalVariable Property DLC1BatsCount Auto
GlobalVariable Property DLC1MistformCount Auto
GlobalVariable Property DLC1ReflexesCount Auto

GlobalVariable Property DLC1BatsCooldown Auto
GlobalVariable Property DLC1MistformCooldown Auto
GlobalVariable Property DLC1ReflexesCooldown Auto

Spell Property CurrentEquippedPower Auto

Event OnPlayerLoadGame()

  (GetOwningQuest() as DLC1PlayerVampireChangeScript).HandlePlayerLoadGame()

EndEvent

Event OnRaceSwitchComplete()

  Actor PlayerRef = GetReference() as Actor

  PlayerRef.SetGhost(False)
  PlayerRef.GetActorBase().SetInvulnerable(False)

  DLC1BatsCount.Value = 0
  DLC1MistformCount.Value = 0
  DLC1ReflexesCount.Value = 0

  DLC1BatsCooldown.Value = 0
  DLC1MistformCooldown.Value = 0
  DLC1ReflexesCooldown.Value = 0

  If PlayerRef.GetRace() == DLC1VampireBeastRace
    (GetOwningQuest() as DLC1PlayerVampireChangeScript).StartTracking()
  Else
    (GetOwningQuest() as DLC1PlayerVampireChangeScript).Shutdown()
  EndIf

EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)

  Actor PlayerRef = GetReference() as Actor

  CurrentEquippedPower = PlayerRef.GetEquippedSpell(2)

  If CurrentEquippedPower && (akBaseObject == CurrentEquippedPower)
    (GetOwningQuest() as DLC1PlayerVampireChangeScript).HandleEquippedPower(CurrentEquippedPower)
  EndIf

EndEvent
