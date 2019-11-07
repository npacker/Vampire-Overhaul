Scriptname DLC1BatsManagerScript extends ReferenceAlias

Spell Property DLC1VampireBats Auto

Message Property DLC1BatsWaitMessage Auto
Message Property DLC1BatsReadyMessage Auto

GlobalVariable Property DLC1BatsCount Auto

Float Property BatsCooldown Auto

Int Property BatsMaxUses Auto

Event OnSpellCast(Form akSpell)

  Actor PlayerRef = GetReference() as Actor

  If akSpell == DLC1VampireBats
    If DLC1BatsCount.GetValue() == 0
      RegisterForSingleUpdateGameTime(BatsCoolDown)
    EndIf

    DLC1BatsCount.SetValue(DLC1BatsCount.GetValue() + 1)

    If DLC1BatsCount.GetValue() >= BatsMaxUses
      UnregisterForUpdateGameTime()
      DLC1BatsWaitMessage.Show()
      PlayerRef.RemoveSpell(DLC1VampireBats)
      RegisterForSingleUpdateGameTime(BatsCoolDown)
    EndIf
  EndIf

EndEvent

Event OnUpdateGameTime()

  Actor PlayerRef = GetReference() as Actor

  If DLC1BatsCount.GetValue() >= BatsMaxUses
    DLC1BatsReadyMessage.Show()
    PlayerRef.AddSpell(DLC1VampireBats, abVerbose = False)

    If PlayerRef.GetEquippedSpell(2) == None
      PlayerRef.EquipSpell(DLC1VampireBats, 2)
    EndIf
  EndIf

  DLC1BatsCount.SetValue(0)

EndEvent
