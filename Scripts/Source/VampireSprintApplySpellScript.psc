Scriptname VampireSprintApplySpellScript extends ActiveMagicEffect

Spell Property AbilityToApply Auto

String SprintStartEvent = "tailSprint"

String SprintEndEvent = "EndAnimatedCameraDelta"

Event OnEffectStart(Actor Caster, Actor Target)

  Actor PlayerRef = Game.GetPlayer()

  RegisterForAnimationEvent(PlayerRef, SprintStartEvent)
  RegisterForAnimationEvent(PlayerREf, SprintEndEvent)

EndEvent

Event OnRaceSwitchComplete()

  Actor PlayerRef = Game.GetPlayer()

  RegisterForAnimationEvent(PlayerRef, SprintStartEvent)
  RegisterForAnimationEvent(PlayerREf, SprintEndEvent)

EndEvent

Event OnAnimationEvent(ObjectReference Source, String EventName)

  Actor PlayerRef = Game.GetPlayer()

  If Source == PlayerRef
    If EventName == SprintStartEvent
      UnregisterForAnimationEvent(PlayerRef, SprintStartEvent)
      AbilityToApply.Cast(PlayerRef)
    ElseIf EventName == SprintEndEvent
      PlayerRef.DispelSpell(AbilityToApply)
      RegisterForSingleUpdate(1.0)
    EndIf
  EndIf

EndEvent

Event OnUpdate()

  RegisterForAnimationEvent(Game.GetPlayer(), SprintStartEvent)

EndEvent
