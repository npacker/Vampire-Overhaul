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
Float Property TranslationDelay = 0.1 Auto
Float Property ReformDelay = 0.2 Auto

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

Bool ContinueEffectLoop = True

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor akTarget, Actor akCaster)

  Caster = akCaster
  LevitationStateStartValue = DLC1VampireLevitateStateGlobal.GetValue()
  DLC1PlayerVampireQuest.CurrentEquippedLeftSpell = Caster.GetEquippedSpell(0)

  RegisterForAnimationEvent(Caster, BatSprintOff)

  BatsIdleSuccess = Caster.PlayIdle(BatSprintStart)

  If BatsIdleSuccess
    DLC1VampireBatsImod.Apply()

    If DLC1nVampireNecklaceBats.GetValue() == 1
      DLC1nVampireBatsAmuletSpell.Cast(Caster, Caster)
    EndIf

    If LevitationStateStartValue == 2.0
      DLC1VampireLevitateStateGlobal.SetValue(LevitationStateFlag)
    EndIf

    Caster.ClearExtraArrows()
    Caster.SetSubGraphFloatVariable("fdampRate", 0.2)
    Caster.SetSubGraphFloatVariable("ftoggleBlend", 1.3)

    BatsFX = Caster.PlaceAtMe(DLC1VampLordBatsFXActivator)

    BatsFX.EnableNoWait(False)
    RegisterForSingleUpdate(TranslationDelay)
  Else
    Caster.DispelSpell(DLC1VampireBats)
  EndIf

EndEvent

Event OnUpdate()

  BatsFX.TranslateToRef(Caster, Caster.GetDistance(BatsFX) * TranslationMult)

  If ContinueEffectLoop
    RegisterForSingleUpdate(TranslationDelay)
  EndIf

EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)

  If asEventName == BatSprintOff
    Caster.DispelSpell(DLC1VampireBats)
  EndIf

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

  UnregisterForAnimationEvent(Caster, BatSprintOff)

  If BatsIdleSuccess
    If DLC1VampireLevitateStateGlobal.GetValue() == LevitationStateFlag
      DLC1VampireLevitateStateGlobal.SetValue(LevitationStateStartValue)
    EndIf

    Caster.SetSubGraphFloatVariable("fdampRate", 0.02)
    Caster.SetSubGraphFloatVariable("ftoggleBlend", 0.0)

    Utility.Wait(ReformDelay)

    DLC1VampireBatsReformFXS.Play(Caster, 0.2)
    DLC1VampireBatsReformBATSFXS.Play(Caster, 0.2)

    If DLC1nVampireNecklaceBats.GetValue() == 1
      Caster.DispelSpell(DLC1nVampireBatsAmuletSpell)
    EndIf

    ContinueEffectLoop = False

    Utility.Wait(TranslationDelay)

    BatsFX.Disable()
    BatsFX.Delete()
  EndIf

EndEvent
