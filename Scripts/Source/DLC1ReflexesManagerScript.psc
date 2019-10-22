Scriptname DLC1ReflexesManagerScript extends ReferenceAlias

GlobalVariable Property DLC1ReflexesCount Auto

Race Property VampireLordRace Auto

Spell Property DLC1SupernaturalReflexes Auto
Spell Property CurrentEquippedPower Auto

Message Property DLC1ReflexesWaitMessage Auto
Message Property DLC1ReflexesReadyMessage Auto

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
      PlayerRef.RemoveSpell(DLC1SupernaturalReflexes)
    EndIf
  EndIf

EndEvent

Event OnUpdateGameTime()

  Actor PlayerRef = GetReference() as Actor

  If  DLC1ReflexesCount.Value >= ReflexesMaxUses
    DLC1ReflexesReadyMessage.Show()
    PlayerRef.AddSpell(DLC1SupernaturalReflexes, false)

    If PlayerRef.GetEquippedSpell(2) == None
      PlayerRef.EquipSpell(DLC1SupernaturalReflexes, 2)
    EndIf
  EndIf

  DLC1ReflexesCount.Value = 0

EndEvent
