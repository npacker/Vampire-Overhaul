Scriptname DLC1MagicMistformFXScript extends ActiveMagicEffect
{ This script holds additional effects for the Mistform Power. }

GlobalVariable Property DLC1VampireLevitateStateGlobal Auto

Spell Property DLC1VampireMistform Auto

EffectShader Property DLC1VampireMistform02FXS Auto
EffectShader Property DLC1VampireMistformEnd03FXS Auto

Sound Property MAGPowersMistformInMarker Auto
Sound Property MAGPowersMistformOutMarker Auto

Float fLevStateStartValue

Event OnEffectStart(Actor akTarget, Actor akCaster)

  ; Play intro sound.
  MAGPowersMistformInMarker.Play(akTarget as ObjectReference)

  ; Apply visual FX.
  DLC1VampireMistform02FXS.Stop(akTarget)
  DLC1VampireMistform02FXS.Play(akTarget, -1)

  ; Make us immune to damage.
  akTarget.SetGhost(True)

  ; Make us transparent.
  akTarget.SetAlpha(0.25, True)

  ; Disable controls if we are the player.
  If akTarget == Game.GetPlayer()
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

  ; Dispel this spell.
  akCaster.DispelSpell(DLC1VampireMistform)

  ; Play the outro sound.
  MAGPowersMistformOutMarker.Play(akTarget as ObjectReference)

  ; Restore levitation state start value.
  If DLC1VampireLevitateStateGlobal.GetValue() == 4.0
    DLC1VampireLevitateStateGlobal.SetValue(fLevStateStartValue)
  EndIf

  ; Speeds up fade rate (max 1, min 0.1)
  akCaster.SetSubGraphFloatVariable("fdampRate", 0.02)

  ; Blends between two animations default 0 (0 = there, 1 = gone)
  akCaster.SetSubGraphFloatVariable("ftoggleBlend", -0.05)

  If akTarget == Game.GetPlayer()
    Game.EnablePlayerControls(abCamSwitch = False)
  EndIf

  ; Play outro vusual FX.
  DLC1VampireMistform02FXS.Stop(akTarget)
  DLC1VampireMistformEnd03FXS.Play(akTarget, 0.1)

  ; Remove transparency.
  akTarget.SetAlpha(1.0, True)

  ; We can take damage again.
  akTarget.SetGhost(False)

EndEvent
