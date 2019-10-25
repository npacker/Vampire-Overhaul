Scriptname DLC1MagicMistformFXScript extends ActiveMagicEffect
{ This script holds additional effects for the Mistform Power. }

GlobalVariable Property DLC1VampireLevitateStateGlobal Auto

Spell Property DLC1VampireMistform Auto

Float fLevStateStartValue = 0.0

Event OnEffectStart(Actor akTarget, Actor akCaster)

  akTarget.SetGhost(True)

  fLevStateStartValue = DLC1VampireLevitateStateGlobal.GetValue()

  ; We set this to 4.0 only here, so we can tell later if the state is changed.
  DLC1VampireLevitateStateGlobal.SetValue(4.0)

  ; Make player turn invisible and throw away attached arrows.
  ; Speeds up fade rate (max 1, min .1).
  akCaster.SetSubGraphFloatVariable("fdampRate", 0.015)

  ; Blends between two anims default 0 (0 = there, 1 = gone).
  akCaster.SetSubGraphFloatVariable("ftoggleBlend", 1.45)

  ; Remove arrows stuck in us.
  akCaster.ClearExtraArrows()

  If akCaster == Game.GetPlayer()
    ; Disable fighting and activating.
    Game.DisablePlayerControls( \
        abMovement = False, \
        abFighting = True, \
        abCamSwitch = True, \
        abMenu = True, \
        abActivate = True)
  EndIf

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

  akCaster.DispelSpell(DLC1VampireMistform)

  If DLC1VampireLevitateStateGlobal.GetValue() == 4.0
    DLC1VampireLevitateStateGlobal.SetValue(fLevStateStartValue)
  EndIf

  ; Speeds up fade rate (max 1, min 0.1)
  akCaster.SetSubGraphFloatVariable("fdampRate", 0.02)

  ; Blends between two animations default 0 (0 = there, 1 = gone)
  akCaster.SetSubGraphFloatVariable("ftoggleBlend", -0.05)

  If akCaster == Game.GetPlayer()
    ; Duplicate of what the DLC1PlayerVampireQuest script runs in Prepshift.
    Game.EnablePlayerControls( \
        abMovement = True, \
        abFighting = True, \
        abCamSwitch = True, \
        abMenu = True, \
        abActivate = True)
  EndIf

  akTarget.SetGhost(False)

EndEvent
