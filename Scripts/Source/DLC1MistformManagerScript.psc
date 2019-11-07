Scriptname DLC1MistformManagerScript extends ReferenceAlias

Spell Property DLC1VampireMistform Auto

Message Property DLC1MistformWaitMessage Auto
Message Property DLC1MistformReadyMessage Auto

GlobalVariable Property DLC1MistformCount Auto

Float Property MistformCooldown Auto

Int Property MistformMaxUses Auto

Event OnSpellCast(Form akSpellCast)

  Actor PlayerRef = GetReference() as Actor

  If akSpellCast == DLC1VampireMistform
    If DLC1MistformCount.GetValue() == 0
      RegisterForSingleUpdateGameTime(MistformCoolDown)
    endIf

    DLC1MistformCount.SetValue(DLC1MistformCount.GetValue() + 1)

    If DLC1MistformCount.GetValue() >= MistformMaxUses
      UnregisterForUpdateGameTime()
      DLC1MistformWaitMessage.Show()
      PlayerRef.RemoveSpell(DLC1VampireMistform)
      RegisterForSingleUpdateGameTime(MistformCoolDown)
    EndIf
  EndIf

EndEvent

Event OnUpdateGameTime()

  Actor PlayerRef = GetReference() as Actor

  If DLC1MistformCount.GetValue() >= MistformMaxUses
    DLC1MistformReadyMessage.Show()
    PlayerRef.AddSpell(DLC1VampireMistform, abVerbose = False)

    If PlayerRef.GetEquippedSpell(2) == None
      PlayerRef.EquipSpell(DLC1VampireMistform, 2)
    EndIf
  EndIf

  DLC1MistformCount.SetValue(0)

EndEvent
