Scriptname DLC1BatsManagerScript extends ReferenceAlias

Spell Property DLC1VampireBats Auto

Message Property DLC1BatsWaitMessage Auto
Message Property DLC1BatsReadyMessage Auto

GlobalVariable Property DLC1BatsCount Auto
GlobalVariable Property DLC1BatsCooldown Auto

Float Property BatsCooldown Auto

Int Property BatsMaxUses Auto

Event OnSpellCast(Form akSpell)

  Actor PlayerRef = GetReference() as Actor

  If akSpell == DLC1VampireBats
    If DLC1BatsCount.Value == 0
      RegisterForSingleUpdateGameTime(BatsCoolDown)
    EndIf

    DLC1BatsCount.Value += 1

    If DLC1BatsCount.Value >= BatsMaxUses
      DLC1BatsWaitMessage.Show()
      DLC1BatsCooldown.Value = 1
      PlayerRef.RemoveSpell(DLC1VampireBats)
    EndIf
  EndIf

EndEvent

Event OnUpdateGameTime()

  Actor PlayerRef = GetReference() as Actor

  UnregisterForUpdateGameTime()

  If DLC1BatsCount.Value >= BatsMaxUses
    DLC1BatsReadyMessage.Show()
    DLC1BatsCooldown.Value = 0
    PlayerRef.AddSpell(DLC1VampireBats, abVerbose = False)

    If PlayerRef.GetEquippedSpell(2) == None
      PlayerRef.EquipSpell(DLC1VampireBats, 2)
    EndIf
  EndIf

  DLC1BatsCount.Value = 0

EndEvent
