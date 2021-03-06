Scriptname DLC1MagicMistformFXScript extends ActiveMagicEffect
{ This script holds additional effects for the Mistform Power. }

GlobalVariable Property DLC1VampireLevitateStateGlobal Auto

Spell Property DLC1VampireMistform Auto

Float fLevStateStartValue

Event OnEffectStart(Actor akTarget, Actor akCaster)

  akTarget.SetGhost(True)

  If akCaster == Game.GetPlayer()
    Game.DisablePlayerControls(abMovement = False, abCamSwitch = True)
  EndIf

  ; Store levitation start value.
  fLevStateStartValue = DLC1VampireLevitateStateGlobal.GetValue()

  ; We set this to 4.0 only here, so we can tell later if the state is changed.
  DLC1VampireLevitateStateGlobal.SetValue(4.0)

  ; Remove arrows stuck in us.
  akCaster.ClearExtraArrows()

  ; Make player turn invisible.
  ; Speeds up fade rate (max 1, min .1).
  akCaster.SetSubGraphFloatVariable("fdampRate", 0.015)

  ; Blends between two anims default 0 (0 = there, 1 = gone).
  akCaster.SetSubGraphFloatVariable("ftoggleBlend", 1.45)

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

  akCaster.DispelSpell(DLC1VampireMistform)

  If DLC1VampireLevitateStateGlobal.GetValue() == 4.0
    ; Restore levitation state start value.
    DLC1VampireLevitateStateGlobal.SetValue(fLevStateStartValue)
  EndIf

  ; Speeds up fade rate (max 1, min 0.1)
  akCaster.SetSubGraphFloatVariable("fdampRate", 0.02)

  ; Blends between two animations default 0 (0 = there, 1 = gone)
  akCaster.SetSubGraphFloatVariable("ftoggleBlend", -0.05)

  If akCaster == Game.GetPlayer()
    Game.EnablePlayerControls(abCamSwitch = False)
  EndIf

  akTarget.SetGhost(False)

EndEvent
