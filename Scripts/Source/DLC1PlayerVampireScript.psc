Scriptname DLC1PlayerVampireScript extends ReferenceAlias

Race Property VampireLordRace Auto

Message Property DLC1BatsWaitMessage Auto
Message Property DLC1BatsReadyMessage Auto

Spell Property CurrentEquippedPower Auto

GlobalVariable Property DLC1BatsCount Auto

Float Property BatsCooldown Auto

Int Property BatsOutdoorMaxUses Auto
Int Property BatsIndoorMaxUses Auto

Spell Property DLC1Mistform  Auto
Spell Property DLC1VampireBats Auto

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

Event OnPlayerLoadGame()

  (GetOwningQuest() as DLC1PlayerVampireChangeScript).HandlePlayerLoadGame()

EndEvent

Event OnSpellCast(Form SpellCast)

  Actor PlayerRef = GetReference() as Actor

  If SpellCast == DLC1VampireBats
    If DLC1BatsCount.Value == 0
      RegisterForSingleUpdateGameTime(BatsCoolDown)
    EndIf

    DLC1BatsCount.Value += 1

    If (!PlayerRef.IsInInterior() && DLC1BatsCount.Value >= BatsOutdoorMaxUses) \
        || (PlayerRef.IsInInterior() && DLC1BatsCount.Value >= BatsIndoorMaxUses)
      DLC1BatsWaitMessage.Show()
      GetActorRef().RemoveSpell(DLC1VampireBats)
    EndIf
  EndIf

EndEvent

Event OnUpdateGameTime()

  Actor PlayerRef = GetReference() as Actor

  If (!PlayerRef.IsInInterior() && DLC1BatsCount.Value >= BatsOutdoorMaxUses) \
      || (PlayerRef.IsInInterior() && DLC1BatsCount.Value >= BatsIndoorMaxUses)
    DLC1BatsReadyMessage.Show()
    GetActorRef().AddSpell(DLC1VampireBats, False)

    If GetActorRef().GetEquippedSpell(2) == None
      GetActorRef().EquipSpell(DLC1VampireBats, 2)
    EndIf
  EndIf

  DLC1BatsCount.Value = 0

EndEvent
