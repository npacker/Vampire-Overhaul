Scriptname DLC1VampirePowerManagerScript extends ReferenceAlias

Actor Property PlayerRef Auto

Spell Property VampirePower Auto

Message Property WaitMessage Auto
Message Property ReadyMessage Auto

GlobalVariable Property UseCount Auto

Float Property Cooldown Auto

Int Property MaxUses Auto

Event OnSpellCast(Form akSpell)

  If akSpell == VampirePower
    If UseCount.GetValue() == 0
      RegisterForSingleUpdateGameTime(CoolDown)
    EndIf

    UseCount.SetValue(UseCount.GetValue() + 1)

    If UseCount.GetValue() >= MaxUses
      UnregisterForUpdateGameTime()
      WaitMessage.Show()
      PlayerRef.RemoveSpell(VampirePower)
      RegisterForSingleUpdateGameTime(Cooldown)
    EndIf
  EndIf

EndEvent

Event OnUpdateGameTime()

  If UseCount.GetValue() >= MaxUses
    ReadyMessage.Show()
    PlayerRef.AddSpell(VampirePower, abVerbose = False)

    If PlayerRef.GetEquippedSpell(2) == None
      PlayerRef.EquipSpell(VampirePower, 2)
    EndIf
  EndIf

  UseCount.SetValue(0)

EndEvent
