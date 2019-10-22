Scriptname DLC1PlayerVampireScript extends ReferenceAlias

Race Property DLC1VampireBeastRace Auto

Spell Property DLC1VampireBats Auto
Spell Property DLC1SupernaturalReflexes Auto
Spell Property DLC1VampireMistform Auto

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

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)

  Actor PlayerRef = GetReference() as Actor

  If akBaseObject == DLC1VampireBats && DLC1BatsCooldown
    Return
  EndIf

  If akBaseObject == DLC1VampireMistform && DLC1MistformCooldown
    Return
  EndIf

  If akBaseObject == DLC1SupernaturalReflexes && DLC1ReflexesCooldown
    Return
  EndIf

  If akBaseObject == CurrentEquippedPower
    CurrentEquippedPower = None
    (GetOwningQuest() as DLC1PlayerVampireChangeScript).HandleEquippedPower(None)
  EndIf

EndEvent
