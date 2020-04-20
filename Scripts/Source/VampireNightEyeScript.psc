Scriptname VampireNightEyeScript extends ActiveMagicEffect
{ Scripted effect for the Night Eye Spell. }

GlobalVariable Property NightEyeTransitionGlobal Auto
{ Night Eye state global. }

ImageSpaceModifier Property VampireNightEyeImodIntro Auto
{ IsMod applied at the start of the spell effect. }

ImageSpaceModifier Property VampireNightEyeImod Auto
{ Main isMod for spell. }

ImageSpaceModifier Property VampireNightEyeImodOutro Auto
{ IsMod applied at the end of the spell effect. }

ImageSpaceModifier Property NightEyeImodIntro Auto
{ Default Night Eye Imod intro. }

ImageSpaceModifier Property NightEyeImod Auto
{ Default Night Eye Imod. }

ImageSpaceModifier Property NightEyeImodOutro Auto
{ Default Night Eye Imod outro. }

Sound Property IntroSoundFX Auto
{ Create a sound property we'll point to in the editor. }

Sound Property OutroSoundFX Auto
{ Create a sound property we'll point to in the editor. }

Float fDelay = 0.96

Float fImodStrength = 1.0

Function RemoveDefaultImods()

  NightEyeImodIntro.Remove()
  NightEyeImod.Remove()
  NightEyeImodOutro.Remove()

EndFunction

Event OnEffectStart(Actor Target, Actor Caster)

  if NightEyeTransitionGlobal.GetValue() == 0.0
    NightEyeTransitionGlobal.setValue(fImodStrength)

    Int instanceID = IntroSoundFX.play(target as ObjectReference)

    VampireNightEyeImodIntro.Apply(fImodStrength)
    Utility.Wait(fDelay)

    If NightEyeTransitionGlobal.GetValue() == 1.0
      VampireNightEyeImodIntro.PopTo(VampireNightEyeImod, fImodStrength)
      NightEyeTransitionGlobal.SetValue(2.0)
    EndIf
  ElseIf NightEyeTransitionGlobal.GetValue() == 1.0
    VampireNightEyeImodIntro.PopTo(VampireNightEyeImod, fImodStrength)
    NightEyeTransitionGlobal.SetValue(2.0)
    Self.Dispel()
  Else
    Self.Dispel()
  EndIf

EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)

  If NightEyeTransitionGlobal.GetValue() == 2.0
    NightEyeTransitionGlobal.setValue(3.0)

    Int instanceID = OutroSoundFX.play(target as ObjectReference)

    VampireNightEyeImod.PopTo(VampireNightEyeImodOutro, fImodStrength)
    VampireNightEyeImodIntro.Remove()
    NightEyeTransitionGlobal.SetValue(0.0)
  EndIf

  RemoveDefaultImods()

EndEvent
