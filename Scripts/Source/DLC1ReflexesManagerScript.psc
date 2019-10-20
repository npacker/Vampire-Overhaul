Scriptname DLC1ReflexesManagerScript extends ReferenceAlias

GlobalVariable Property DLC1ReflexesCount Auto

Race Property VampireLordRace Auto

Spell Property DLC1SupernaturalReflexes Auto
Spell Property CurrentEquippedPower Auto

Message Property DLC1ReflexesWaitMessage Auto
Message Property DLC1ReflexesReadyMessage Auto

FLoat Property ReflexesCooldown Auto

Int Property ReflexesMaxUses Auto

Event OnInit()

  DLC1ReflexesCount.Value = 0

EndEvent

Event OnSpellCast(Form akSpellCast)

  If akSpellCast == DLC1SupernaturalReflexes
    If DLC1ReflexesCount.Value == 0
      RegisterForSingleUpdateGameTime(ReflexesCoolDown)
    EndIf

    DLC1ReflexesCount.Value += 1

    If DLC1ReflexesCount.Value >= ReflexesMaxUses
      GetActorRef().RemoveSpell(DLC1SupernaturalReflexes)
    EndIf
  EndIf

EndEvent

Event OnUpdateGameTime()

  UnRegisterforUpdateGameTime()

  If  DLC1ReflexesCount.Value >= ReflexesMaxUses
    DLC1ReflexesReadyMessage.Show()
    GetActorRef().AddSpell(DLC1SupernaturalReflexes, false)

    If GetActorRef().GetEquippedSpell(2) == None
      GetActorRef().EquipSpell(DLC1SupernaturalReflexes, 2)
    EndIf
  EndIf

  DLC1ReflexesCount.Value = 0

EndEvent
