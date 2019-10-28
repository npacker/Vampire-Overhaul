Scriptname DLC1VLCrimeScript extends Actor
{
  When the player is a vampire lord, traditional crime reporting is turned off.
  Since most actors attack the player in this form, that is fine.  However, the
  DLC1VampireCrimeFaction members do not. Unfortunately, this also means they
  don't react to being attacked.

  This script has been modified to make DLC1VampireCrimeFaction members only go
  hostile if they are attacked twice within 10 seconds.
}

Race Property DLC1VampireBeastRace Auto

Faction Property DLC1VampireFaction Auto

Bool Hostile = False

Float CooldownTimer = 30.0

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, \
    bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)

  UnregisterForUpdate()

  If akAggressor == Game.GetPlayer() && Game.GetPlayer().GetRace() == DLC1VampireBeastRace
    If Hostile
      DLC1VampireFaction.SetPlayerEnemy()
      SendAssaultAlarm()
      StartCombat(Game.GetPlayer())
      DLC1VampireFaction.SetPlayerEnemy(False)
    Else
      Hostile = True
      RegisterForSingleUpdate(CooldownTimer)
    EndIf
  EndIf

EndEvent

Event OnUpdate()

  Hostile = False

EndEvent

Event OnCombatStateChanged(Actor akTarget, Int aeCombatState)

  If akTarget == Game.GetPlayer() && aeCombatState == 0
    Hostile = False
  EndIf

EndEvent

Event OnDeath(Actor akKiller)

  If akKiller == Game.GetPlayer() && Game.GetPlayer().GetRace() == DLC1VampireBeastRace \
      && Game.GetPlayer().IsDetectedBy(Self)
    DlC1VampireFaction.SetPlayerEnemy()
    SendAssaultAlarm()
    DLC1VampireFaction.SetPlayerEnemy(False)
  EndIf

EndEvent
