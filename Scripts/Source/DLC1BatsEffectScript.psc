Scriptname DLC1BatsEffectScript extends ActiveMagicEffect

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

DLC1PlayerVampireChangeScript Property DLC1PlayerVampireQuest auto
{ So we can save the currently equipped spell. }

GlobalVariable Property DLC1VampireLevitateStateGlobal Auto

GlobalVariable Property DLC1nVampireNecklaceBats Auto

Spell Property DLC1VampireBats auto

Spell Property DLC1nVampireBatsAmuletSpell Auto

Idle Property BatSprintStart Auto

Activator Property DLC1VampLordBatsFXActivator Auto

EffectShader Property DLC1VampireBatsReformFXS auto
{ Primary Effect Shader for spell. }

EffectShader Property DLC1VampireBatsReformBATSFXS auto
{ Secondary Effect Shader for spell. }

ImageSpaceModifier Property DLC1VampireBatsImod Auto
{ We set the imod here so we can limit it to only play if the spell works. }

Float Property fReformDelay = 0.0 auto
{ This will delay the reformation animation effect. }

Float Property fSpellEndDelay = 0.0 auto
{ This will delay the reformation animation effect. }

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Actor Caster

ObjectReference BatsFXActivator = None

Float LevitationStateStartValue = 0.0

Float TranslationSpeed = 512.0

Float BatsReformFXDuration = 0.2

Float BatsTransationDelay = 0.2

String BatSprintOff = "BatSprintOff"

Bool BatsTranslationLoopContinue = True

Bool BatsIdleSuccess = False

Bool BatsAnimationComplete = False

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor akTarget, Actor akCaster)

  Caster = akCaster

  ; We need to store the current variable so we can put it back later, if we
  ; have to.
  LevitationStateStartValue = DLC1VampireLevitateStateGlobal.Value

  ; Register for the anim event so we can tell when we are done moving.
  RegisterForAnimationEvent(Caster, BatSprintOff)

  ; Save out player's currently equipped spell.
  DLC1PlayerVampireQuest.CurrentEquippedLeftSpell = Caster.GetEquippedSpell(0)

  If Caster.PlayIdle(BatSprintStart)
    BatsIdleSuccess = True
    DLC1VampireBatsImod.Apply()

    ; Make player turn invisible and throw away attached arrows.
    Caster.SetGhost(True)
    Caster.SetSubGraphFloatVariable("fdampRate", 0.20)
    Caster.SetSubGraphFloatVariable("ftoggleBlend", 1.3)
    Caster.ClearExtraArrows()

    If DLC1nVampireNecklaceBats.Value == 1
      DLC1nVampireBatsAmuletSpell.Cast(Caster, Caster)
    EndIf

    ; We want to turn off the glow effect on the Vampire Lord if it is running
    ; while he uses Bats. Then we want to put it back.
    If LevitationStateStartValue == 2.0
      ; We set this to 3.0 only here, so we can tell later if the state is
      ; unchanged.
      DLC1VampireLevitateStateGlobal.Value = 3.0
    EndIf

    ; Spawn Bats effect objects and make sure it is visible. Then give it it's
    ; first translation update.
    BatsFXActivator = Caster.PlaceAtMe(DLC1VampLordBatsFXActivator)

    BatsFXActivator.EnableNoWait(False)
    BatsFXActivator.TranslateToRef(Caster, TranslationSpeed, 1)
    BatsTranslationLoop()
  EndIf

EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)

  If asEventName == BatSprintOff
    BatsAnimationComplete = True

    UnRegisterForAnimationEvent(Caster, BatSprintOff)
    Utility.Wait(fReformDelay)
    Caster.SetGhost(False)
    Caster.SetSubGraphFloatVariable("fdampRate", 0.02)
    Caster.SetSubGraphFloatVariable("ftoggleBlend", 0.0)

    If DLC1nVampireNecklaceBats.Value == 1
      Caster.RemoveSpell(DLC1nVampireBatsAmuletSpell)
      Caster.DispelSpell(DLC1nVampireBatsAmuletSpell)
    EndIf

    ; We test this again, just in case the player exited floating mode during
    ; the Bats effect. If it is still 3.0, then they did not.
    if DLC1VampireLevitateStateGlobal.Value == 3.0
      DLC1VampireLevitateStateGlobal.Value = LevitationStateStartValue
    EndIf

    DLC1VampireBatsReformFXS.Play(Caster, BatsReformFXDuration)
    DLC1VampireBatsReformBATSFXS.Play(Caster, BatsReformFXDuration)

    Utility.Wait(fSpellEndDelay)
    Caster.DispelSpell(DLC1VampireBats)
    Utility.Wait(2.0)
    BatsTranslationLoopContinue = False
  EndIf

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

  If BatsIdleSuccess && !BatsAnimationComplete
    UnRegisterForAnimationEvent(Caster, BatSprintOff)
    Caster.SetGhost(False)
    Caster.SetSubGraphFloatVariable("fdampRate", 0.02)
    Caster.SetSubGraphFloatVariable("ftoggleBlend", 0.0)

    If DLC1nVampireNecklaceBats.Value == 1
      Caster.RemoveSpell(DLC1nVampireBatsAmuletSpell)
      Caster.DispelSpell(DLC1nVampireBatsAmuletSpell)
    EndIf

    ; We test this again, just in case the player exited floating mode during
    ; the Bats effect. If it is still 3.0, then they did not.
    if DLC1VampireLevitateStateGlobal.Value == 3.0
      DLC1VampireLevitateStateGlobal.Value = LevitationStateStartValue
    EndIf

    DLC1VampireBatsReformFXS.Play(Caster, BatsReformFXDuration)
    DLC1VampireBatsReformBATSFXS.Play(Caster, BatsReformFXDuration)
  EndIf

EndEvent

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function BatsTranslationLoop()
{
  This function is for moving the bats effect to chase after the player. It may
  not be needed anymore.
}

  While BatsTranslationLoopContinue
    BatsFXActivator.TranslateToRef(Caster, Caster.GetDistance(BatsFXActivator) + TranslationSpeed, 1)
    Utility.Wait(BatsTransationDelay)
  EndWhile

  BatsFXActivator.TranslateToRef(Caster, TranslationSpeed, 1)
  Utility.Wait(BatsTransationDelay)
  BatsFXActivator.Disable()
  BatsFXActivator.Delete()

  BatsFXActivator = None

EndFunction
