Scriptname DLC1ReflexesManagerScript extends ReferenceAlias

Spell Property DLC1SupernaturalReflexes Auto

Message Property DLC1ReflexesWaitMessage Auto
Message Property DLC1ReflexesReadyMessage Auto

GlobalVariable Property DLC1ReflexesCount Auto
GlobalVariable Property DLC1ReflexesCooldown Auto

FLoat Property ReflexesCooldown Auto

Int Property ReflexesMaxUses Auto

Event OnSpellCast(Form akSpellCast)

  Actor PlayerRef = GetReference() as Actor

  If akSpellCast == DLC1SupernaturalReflexes
    If DLC1ReflexesCount.Value == 0
      RegisterForSingleUpdateGameTime(ReflexesCoolDown)
    EndIf

    DLC1ReflexesCount.Value += 1

    If DLC1ReflexesCount.Value >= ReflexesMaxUses
      DLC1ReflexesWaitMessage.Show()
      DLC1ReflexesCooldown.Value = 1
      PlayerRef.RemoveSpell(DLC1SupernaturalReflexes)
    EndIf
  EndIf

EndEvent

Event OnUpdateGameTime()

  Actor PlayerRef = GetReference() as Actor

  UnregisterForUpdateGameTime()

  If  DLC1ReflexesCount.Value >= ReflexesMaxUses
    DLC1ReflexesReadyMessage.Show()
    DLC1ReflexesCooldown.Value = 0
    PlayerRef.AddSpell(DLC1SupernaturalReflexes, abVerbose = False)

    If PlayerRef.GetEquippedSpell(2) == None
      PlayerRef.EquipSpell(DLC1SupernaturalReflexes, 2)
    EndIf
  EndIf

  DLC1ReflexesCount.Value = 0

EndEvent
