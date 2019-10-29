Scriptname DLC1BatsEffectScript extends ActiveMagicEffect

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

DLC1PlayerVampireChangeScript Property DLC1PlayerVampireQuest auto

GlobalVariable Property DLC1VampireLevitateStateGlobal Auto
GlobalVariable Property DLC1nVampireNecklaceBats Auto

Spell Property DLC1VampireBats Auto
Spell Property DLC1nVampireBatsAmuletSpell Auto

Idle Property BatSprintStart Auto

ImageSpaceModifier Property DLC1VampireBatsImod Auto

Activator Property DLC1VampLordBatsFXActivator Auto

EffectShader Property DLC1VampireBatsReformFXS auto
EffectShader Property DLC1VampireBatsReformBATSFXS auto

Float Property TranslationMult = 1.0 Auto
Float Property TranslationDelay = 0.2 Auto
Float Property ReformDelay = 0.1 Auto

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Actor Caster

ObjectReference BatsFX

Float LevitationStateStartValue

Float LevitationStateFlag = 3.0

String BatSprintOff = "batSprintOff"

Bool BatsIdleSuccess = False

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor akTarget, Actor akCaster)

  Caster = akCaster
  LevitationStateStartValue = DLC1VampireLevitateStateGlobal.Value
  DLC1PlayerVampireQuest.CurrentEquippedLeftSpell = Caster.GetEquippedSpell(0)

  RegisterForAnimationEvent(Caster, BatSprintOff)

  BatsIdleSuccess = Caster.PlayIdle(BatSprintStart)

  If BatsIdleSuccess
    DLC1VampireBatsImod.Apply()

    If DLC1nVampireNecklaceBats.Value == 1
      DLC1nVampireBatsAmuletSpell.Cast(Caster, Caster)
    EndIf

    If LevitationStateStartValue == 2.0
      DLC1VampireLevitateStateGlobal.Value = LevitationStateFlag
    EndIf

    Caster.SetSubGraphFloatVariable("fdampRate", 0.2)
    Caster.SetSubGraphFloatVariable("ftoggleBlend", 1.3)
    Caster.ClearExtraArrows()

    BatsFX = Caster.PlaceAtMe(DLC1VampLordBatsFXActivator)

    BatsFX.EnableNoWait(False)
  Else
    Caster.DispelSpell(DLC1VampireBats)
  EndIf

EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)

  If asEventName == BatSprintOff
    BatsFX.TranslateToRef(Caster, Caster.GetDistance(BatsFX) * TranslationMult)
    Caster.DispelSpell(DLC1VampireBats)
  EndIf

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

  UnRegisterForAnimationEvent(Caster, BatSprintOff)

  If BatsIdleSuccess
    Utility.Wait(ReformDelay)

    If DLC1nVampireNecklaceBats.Value == 1
      Caster.DispelSpell(DLC1nVampireBatsAmuletSpell)
    EndIf

    If DLC1VampireLevitateStateGlobal.Value == LevitationStateFlag
      DLC1VampireLevitateStateGlobal.Value = LevitationStateStartValue
    EndIf

    Caster.SetSubGraphFloatVariable("fdampRate", 0.02)
    Caster.SetSubGraphFloatVariable("ftoggleBlend", 0.0)

    Utility.Wait(ReformDelay)

    DLC1VampireBatsReformFXS.Play(Caster, 0.2)
    DLC1VampireBatsReformBATSFXS.Play(Caster, 0.2)

    BatsFX.TranslateToRef(Caster, Caster.GetDistance(BatsFX) * TranslationMult)

    Utility.Wait(TranslationDelay)

    BatsFX.Disable()
    BatsFX.Delete()
  EndIf

EndEvent
