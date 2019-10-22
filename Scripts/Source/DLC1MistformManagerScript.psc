Scriptname DLC1MistformManagerScript extends ReferenceAlias

Race Property VampireLordRace Auto

Spell Property DLC1VampireMistform Auto

Message Property DLC1MistformWaitMessage Auto
Message Property DLC1MistformReadyMessage Auto

GlobalVariable Property DLC1MistformCount Auto

Float Property MistformCooldown Auto

Int Property MistformMaxUses Auto

Event OnSpellCast(Form akSpellCast)

  Actor PlayerRef = GetReference() as Actor

  If akSpellCast == DLC1VampireMistform
    If DLC1MistformCount.Value == 0
      RegisterForSingleUpdateGameTime(MistformCoolDown)
    endIf

    DLC1MistformCount.Value += 1

    If DLC1MistformCount.Value >= MistformMaxUses
      DLC1MistformWaitMessage.Show()
      PlayerRef.RemoveSpell(DLC1VampireMistform)
    EndIf
  EndIf

EndEvent

Event OnUpdateGameTime()

  Actor PlayerRef = GetReference() as Actor

  If DLC1MistformCount.Value >= MistformMaxUses
    DLC1MistformReadyMessage.Show()
    PlayerRef.AddSpell(DLC1VampireMistform, abVerbose = False)

    If PlayerRef.GetEquippedSpell(2) == None
      PlayerRef.EquipSpell(DLC1VampireMistform, 2)
    EndIf
  EndIf

  DLC1MistformCount.Value = 0

EndEvent
