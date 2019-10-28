Scriptname DLC1DrainBloodPointScript extends ActiveMagicEffect

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Message Property DLC1BloodPointsMsg Auto
Message Property DLC1VampirePerkEarned Auto

GlobalVariable Property DLC1VampireBloodPoints Auto
GlobalVariable Property DLC1VampireMaxPerks Auto
GlobalVariable Property DLC1VampireNextPerk Auto
GlobalVariable Property DLC1VampirePerkPoints Auto
GlobalVariable Property DLC1VampireTotalPerksEarned Auto

Actor Property PlayerRef Auto

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Actor SpellCaster
Actor Victim

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor akTarget, Actor akCaster)

  Victim = akTarget
  SpellCaster = akCaster

EndEvent

Event OnDying(Actor akKiller)

  If akKiller == PlayerRef
    DLC1VampireBloodPoints.Value += 1

    If DLC1VampireTotalPerksEarned.Value < DLC1VampireMaxPerks.Value
      DLC1BloodPointsMsg.Show()

      If DLC1VampireBloodPoints.Value >= DLC1VampireNextPerk.Value
        DLC1VampireBloodPoints.Value -= DLC1VampireNextPerk.Value
        DLC1VampirePerkPoints.Value += 1
        DLC1VampireTotalPerksEarned.Value += 1
        DLC1VampireNextPerk.Value = DLC1VampireNextPerk.Value + 2
        DLC1VampirePerkEarned.Show()
      EndIf
    EndIf

    PlayerRef.SetActorValue("VampirePerks", DLC1VampireBloodPoints.Value / DLC1VampireNextPerk.Value * 100)
  EndIf

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

  If Victim.IsDead()
    Utility.Wait(0.1)
  EndIf

EndEvent
