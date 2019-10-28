Scriptname DLC1BatsEffectScript extends ActiveMagicEffect

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

DLC1PlayerVampireChangeScript Property DLC1PlayerVampireQuest auto
{ So we can save the currently equipped spell. }

GlobalVariable Property DLC1VampireLevitateStateGlobal Auto
{ Vampire Lord levitation state. }

GlobalVariable Property DLC1nVampireNecklaceBats Auto
{ Amulet of Bats status variable. }

Spell Property DLC1VampireBats Auto
{ Bats. }

Spell Property DLC1nVampireBatsAmuletSpell Auto
{ Amulet of Bats spell is applied by this magic effect. }

Idle Property BatSprintStart Auto
{ Bats sprint idle animation. }

ImageSpaceModifier Property DLC1VampireBatsImod Auto
{ We set the imod here so we can limit it to only play if the spell works. }

Activator Property DLC1VampLordBatsFXActivator Auto
{ Bats cloud FX that follows player. }

EffectShader Property DLC1VampireBatsReformFXS auto
{ Primary Effect Shader for spell. }

EffectShader Property DLC1VampireBatsReformBATSFXS auto
{ Secondary Effect Shader for spell. }

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Actor Caster

ObjectReference BatsFX

Float LevitationStateStartValue

Float TranslationSpeed = 512.0

Float BatsTranslationDelay = 0.2

Float ReformDelay = 0.1

String BatSprintOff = "batSprintOff"

Bool BatsIdleSuccess = False

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor akTarget, Actor akCaster)

  Caster = akCaster

  ; Store the current levitation state for possible restore later.
  LevitationStateStartValue = DLC1VampireLevitateStateGlobal.Value

  ; Register for the anim event so we can tell when we are done moving.
  RegisterForAnimationEvent(Caster, BatSprintOff)

  ; Save out player's currently equipped spell.
  DLC1PlayerVampireQuest.CurrentEquippedLeftSpell = Caster.GetEquippedSpell(0)

  ; Add Bats Amulet spell.
  If DLC1nVampireNecklaceBats.Value == 1
    DLC1nVampireBatsAmuletSpell.Cast(Caster, Caster)
  EndIf

  ; Play the Bats sprint animation.
  If Caster.PlayIdle(BatSprintStart)
    BatsIdleSuccess = True

    ; Apply Bats IMOD.
    DLC1VampireBatsImod.Apply()

    ; Make player turn invisible and throw away attached arrows.
    Caster.SetSubGraphFloatVariable("fdampRate", 0.2)
    Caster.SetSubGraphFloatVariable("ftoggleBlend", 1.3)
    Caster.ClearExtraArrows()

    ; We want to turn off the glow effect on the Vampire Lord if it is running
    ; while he uses Bats. Then we want to put it back.
    If LevitationStateStartValue == 2.0
      ; We set this to 3.0 only here, so we can tell later if the state is
      ; unchanged.
      DLC1VampireLevitateStateGlobal.Value = 3.0
    EndIf

    ; Place Bats FX object.
    BatsFX = Caster.PlaceAtMe(DLC1VampLordBatsFXActivator)

    ; Make sure it is visible.
    BatsFX.EnableNoWait(False)

    ; Perform the first move of the Bats FX to the player.
    ; BatsFX.TranslateToRef(Caster, Caster.GetDistance(BatsFX) + TranslationSpeed)
  Else
    Dispel()
  EndIf

EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)

  If asEventName == BatSprintOff
    Caster.DispelSpell(DLC1VampireBats)
  EndIf

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

  ; Remove Bats Amulet spell.
  If DLC1nVampireNecklaceBats.Value == 1
    Caster.RemoveSpell(DLC1nVampireBatsAmuletSpell)
    Caster.DispelSpell(DLC1nVampireBatsAmuletSpell)
  EndIf

  If BatsIdleSuccess
    ; Unregister for Bats animation end event.
    UnRegisterForAnimationEvent(Caster, BatSprintOff)

    ; Move the Bats FX to the player again.
    BatsFX.TranslateToRef(Caster, Caster.GetDistance(BatsFX) + TranslationSpeed)

    ; Wait for the player invisibility removal delay.
    Utility.Wait(ReformDelay)

    ; Remove player invisibility.
    Caster.SetSubGraphFloatVariable("fdampRate", 0.02)
    Caster.SetSubGraphFloatVariable("ftoggleBlend", 0.0)

    ; Play blood reform FX.
    DLC1VampireBatsReformFXS.Play(Caster, 0.2)
    ; Play Bats reform FX.
    DLC1VampireBatsReformBATSFXS.Play(Caster, 0.2)

    ; We test this again, just in case the player exited floating mode during
    ; the Bats effect. If it is still 3.0, then they did not.
    if DLC1VampireLevitateStateGlobal.Value == 3.0
      DLC1VampireLevitateStateGlobal.Value = LevitationStateStartValue
    EndIf

    ; Perform a final move of the Bats FX.
    BatsFX.TranslateToRef(Caster, Caster.GetDistance(BatsFX) + TranslationSpeed)

    ; Clean up the Bats FX activator.
    Utility.Wait(BatsTranslationDelay)
    BatsFX.Disable()
    BatsFX.Delete()
  EndIf

EndEvent
