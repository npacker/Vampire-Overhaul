Scriptname DLC1PlayerVampireScript extends ReferenceAlias

Race Property VampireLordRace Auto

Spell Property DLC1VampireBats Auto

Message Property DLC1BatsWaitMessage Auto
Message Property DLC1BatsReadyMessage Auto

GlobalVariable Property DLC1BatsCount Auto

Float Property BatsCooldown Auto

Int Property BatsMaxUses Auto

Spell Property CurrentEquippedPower Auto

Event OnPlayerLoadGame()

  (GetOwningQuest() as DLC1PlayerVampireChangeScript).HandlePlayerLoadGame()

EndEvent

Event OnRaceSwitchComplete()

  Actor PlayerRef = GetReference() as Actor

  PlayerRef.SetGhost(False)
  PlayerRef.GetActorBase().SetInvulnerable(False)

  If PlayerRef.GetRace() == VampireLordRace
    (GetOwningQuest() as DLC1PlayerVampireChangeScript).StartTracking()
  Else
    (GetOwningQuest() as DLC1PlayerVampireChangeScript).Shutdown()
  EndIf

EndEvent

Event OnObjectEquipped(Form BaseObject, ObjectReference Reference)

  Actor PlayerRef = GetReference() as Actor

  CurrentEquippedPower = PlayerRef.GetEquippedSpell(2)

  If CurrentEquippedPower && (BaseObject == CurrentEquippedPower)
    (GetOwningQuest() as DLC1PlayerVampireChangeScript).HandleEquippedPower(CurrentEquippedPower)
  EndIf

EndEvent

Event OnObjectUnequipped(Form BaseObject, ObjectReference Reference)

  Actor PlayerRef = GetReference() as Actor

  If BaseObject == CurrentEquippedPower
    CurrentEquippedPower = None
    (GetOwningQuest() as DLC1PlayerVampireChangeScript).HandleEquippedPower(None)
  EndIf

EndEvent

Event OnSpellCast(Form SpellCast)

  Actor PlayerRef = GetReference() as Actor

  If SpellCast == DLC1VampireBats
    If DLC1BatsCount.Value == 0
      RegisterForSingleUpdateGameTime(BatsCoolDown)
    EndIf

    DLC1BatsCount.Value += 1

    If DLC1BatsCount.Value >= BatsMaxUses
      DLC1BatsWaitMessage.Show()
      GetActorRef().RemoveSpell(DLC1VampireBats)
    EndIf
  EndIf

EndEvent

Event OnUpdateGameTime()

  Actor PlayerRef = GetReference() as Actor

  If DLC1BatsCount.Value >= BatsMaxUses
    DLC1BatsReadyMessage.Show()
    GetActorRef().AddSpell(DLC1VampireBats, False)

    If GetActorRef().GetEquippedSpell(2) == None
      GetActorRef().EquipSpell(DLC1VampireBats, 2)
    EndIf
  EndIf

  DLC1BatsCount.Value = 0

EndEvent
