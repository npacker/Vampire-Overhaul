Scriptname DLC1ReflexesManagerScript extends ReferenceAlias

Spell Property DLC1SupernaturalReflexes Auto

Message Property DLC1ReflexesWaitMessage Auto
Message Property DLC1ReflexesReadyMessage Auto

GlobalVariable Property DLC1ReflexesCount Auto

FLoat Property ReflexesCooldown Auto

Int Property ReflexesMaxUses Auto

Event OnSpellCast(Form akSpellCast)

  Actor PlayerRef = GetReference() as Actor

  If akSpellCast == DLC1SupernaturalReflexes
    If DLC1ReflexesCount.GetValue() == 0
      RegisterForSingleUpdateGameTime(ReflexesCoolDown)
    EndIf

    DLC1ReflexesCount.SetValue(DLC1ReflexesCount.GetValue() + 1)

    If DLC1ReflexesCount.GetValue() >= ReflexesMaxUses
      UnregisterForUpdateGameTime()
      DLC1ReflexesWaitMessage.Show()
      PlayerRef.RemoveSpell(DLC1SupernaturalReflexes)
      RegisterForSingleUpdateGameTime(ReflexesCoolDown)
    EndIf
  EndIf

EndEvent

Event OnUpdateGameTime()

  Actor PlayerRef = GetReference() as Actor

  If  DLC1ReflexesCount.GetValue() >= ReflexesMaxUses
    DLC1ReflexesReadyMessage.Show()
    PlayerRef.AddSpell(DLC1SupernaturalReflexes, abVerbose = False)

    If PlayerRef.GetEquippedSpell(2) == None
      PlayerRef.EquipSpell(DLC1SupernaturalReflexes, 2)
    EndIf
  EndIf

  DLC1ReflexesCount.SetValue(0)

EndEvent
