Scriptname DLC1PlayerVampireChangeScript extends Quest

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Race Property DLC1VampireBeastRace Auto
{ The vampire lord race. }

;-------------------------------------------------------------------------------
; VAMPIRE LORD FX
;-------------------------------------------------------------------------------

ImageSpaceModifier Property VampireWarn Auto
{ Image space modifier played before change.  }

ImageSpaceModifier Property VampireChange Auto
{ Image space modifier played upon change. }

Sound Property VampireIMODSound Auto
{ Sound played upon change. }

EffectShader Property DLC1VampireChangeBackFXS Auto
{ Visual effect for revert form. }

EffectShader Property DLC1VampireChangeBack02FXS Auto
{ Second visual effect for revert form. }

Armor Property DLC1ClothesVampireLordArmor Auto
{ The armor worn by the Vampire Lord. }

Spell Property DLC1AbVampireFloatBodyFX Auto
{Spell FX Art holder for Levitation Glow.}

;-------------------------------------------------------------------------------
; VAMPIRE TRACKING
;-------------------------------------------------------------------------------

PlayerVampireQuestScript Property PlayerVampireQuest Auto
{ The main player vampire tracking quest. }

Quest Property VampireTrackingQuest Auto
{ Quest responsible for tracking the player vampire in Dawnguard. }

Quest Property DialogueGenericVampire Auto
{
  Quest that stores additional variables about vampirel lord states such as
  equipped spells.
}

Perk Property DLC1VampireActivationBlocker Auto
{
  Perk that disables activation of various interactable objects while in Vampire
  Lord form.
}

Faction Property DLC1PlayerVampireLordFaction Auto
{ Faction of vampire lords. }

FormList Property DLC1VampireHateFactions Auto
{ Crime factions that will criminalize the vampire lord on sight. }

FormList Property DLC1SendWerewolfLocationExceptions Auto
{ List of locations where SendWerewolfTransformation() should not be called. }

FormList Property VampireDispelList Auto
{ Vampire spells that should be dispelled. }

Spell Property CurrentEquippedSpell Auto
{ The spell the vampire lord currently has equipped. }

Spell Property LastEquippedPower Auto
{ The power the vampire lord currently has equipped. }

Bool Property DLC1HasLightfoot Auto
{ Whether the player character has the Light Foot perk. }

GlobalVariable Property DCL1VampireLevitateStateGlobal Auto
{
  This Global tracks what state the Vampire Lord is in:

    0 = Not a Vampire Lord
    1 = Walking
    2 = Levitating
}

GlobalVariable Property DLC1BatsCount Auto
{ Bats power max uses before cooldown. }

GlobalVariable Property DLC1MistformCount Auto
{ Mistform power max uses before cooldown. }

GlobalVariable Property DLC1ReflexesCount Auto
{ Supernatural Reflexes power max uses before cooldown. }

;-------------------------------------------------------------------------------
; VAMPIRE LORD WEARABLES
;-------------------------------------------------------------------------------

Armor Property DLC1nVampireBloodMagicRingBeast Auto
{ Ring of the Beast. }

Armor Property DLC1nVampireBloodMagicRingErudite Auto
{ Ring of the Erudite. }

Armor Property DLC1nVampireNightPowerNecklaceBats Auto
{ Amulet of Bats. }

Armor Property DLC1nVampireNightPOwerNecklaceGargoyle Auto
{ Amulet of Gargoyles. }

GlobalVariable Property DLC1nVampireRingBeast Auto
{ Tracks if the Ring of the Beast is worn. }

GlobalVariable Property DLC1nVampireRingErudite Auto
{ Tracks if the Ring of the Erudite is worn. }

GlobalVariable Property DLC1nVampireNecklaceBats Auto
{ Tracks if the Amulet of Bats is worn. }

GlobalVariable Property DLC1nVampireNecklaceGargoyle Auto
{ Tracks if the Amulet of Gargoyles is worn. }

;-------------------------------------------------------------------------------
; VAMPIRE LORD SPELLS AND ABILITIES
;-------------------------------------------------------------------------------

Spell Property LeveledAbility Auto
Spell Property DLC1PlayerVampireLvl10AndBelowAbility Auto
Spell Property DLC1PlayerVampireLvl15AndBelowAbility Auto
Spell Property DLC1PlayerVampireLvl20AndBelowAbility Auto
Spell Property DLC1PlayerVampireLvl25AndBelowAbility Auto
Spell Property DLC1PlayerVampireLvl30AndBelowAbility Auto
Spell Property DLC1PlayerVampireLvl35AndBelowAbility Auto
Spell Property DLC1PlayerVampireLvl40AndBelowAbility Auto
Spell Property DLC1PlayerVampireLvl45AndBelowAbility Auto
Spell Property DLC1PlayerVampireLvl50AndOverAbility Auto

Spell Property LeveledDrainSpell Auto
Spell Property DLC1VampireDrain05 Auto
Spell Property DLC1VampireDrain06 Auto
Spell Property DLC1VampireDrain07 Auto
Spell Property DLC1VampireDrain08 Auto
Spell Property DLC1VampireDrain09 Auto

Spell Property LeveledRaiseDeadSpell Auto
Spell Property DLC1VampireRaiseDeadLeftHand01 Auto
Spell Property DLC1VampireRaiseDeadLeftHand02 Auto
Spell Property DLC1VampireRaiseDeadLeftHand03 Auto
Spell Property DLC1VampireRaiseDeadLeftHand04 Auto
Spell Property DLC1VampireRaiseDeadLeftHand05 Auto

Spell Property DLC1VampiresGrip Auto
Spell Property DLC1ConjureGargoyleLeftHand Auto
Spell Property DLC1CorpseCurse Auto

Spell Property DLC1VampireDetectLife Auto
Spell Property DLC1VampireMistform Auto
Spell Property DLC1VampireBats Auto
Spell Property DLC1SupernaturalReflexes Auto
Spell Property DLC1NightCloak Auto
Spell Property VampireHuntersSight Auto

Spell Property DLC1VampireLordSunDamage Auto
{ Weakness to Sunlight, specific to Vampire Lords. }

Perk Property LightFoot Auto
{ Light foot perk is automatically added to Vampire Lord. }

Spell Property DLC1VampireChange Auto
{ The spell that allows the player to transform into a vampire lord. }

Spell Property DLC1Revert Auto
{ The spell that allows the player to revert from vampire lord form. }

;-------------------------------------------------------------------------------
; VAMPIRE LORD BLOOD POINTS
;-------------------------------------------------------------------------------

GlobalVariable Property DLC1VampireMaxPerks Auto
{ The maximum number of perks in the Vampire Lord tree. }

GlobalVariable Property DLC1VampireBloodPoints Auto
{ Current number of earned blood points. }

GlobalVariable Property DLC1VampirePerkPoints Auto
{ Current number of vampire lord perk points. }

GlobalVariable Property DLC1VampireTotalPerksEarned Auto
{ Current Number of vampire lord perk points. }

GlobalVariable Property DLC1VampireNextPerk Auto
{ Number of points needed to unlock next vampire lord perk. }

Message Property DLC1VampirePerkEarned Auto
{ Message displayed when a Vampire Lord perk point is earned. }

Message Property DLC1BloodPointsMsg Auto
{ Message displayed upon gaining a blood point through combat bite feeding .}

Float Property DLC1BiteHealthRecover Auto
{ The amount of health recovered from a combat bite. }

;-------------------------------------------------------------------------------
; VAMPIRE LORD PERKS
;-------------------------------------------------------------------------------

Perk Property DLC1CorpseCursePerk Auto
Perk Property DLC1DetectLifePerk Auto
Perk Property DLC1GargoylePerk Auto
Perk Property DLC1MistFormPerk Auto
Perk Property DLC1NightCloakPerk Auto
Perk Property DLC1SupernaturalReflexesPerk Auto
Perk Property DLC1UnearthlyWill Auto
Perk Property DLC1VampireBite Auto
Perk Property DLC1VampiricGrip Auto

;-------------------------------------------------------------------------------
; VAMPIRE EFFECTS AND ABILITIES TO REMOVE
;-------------------------------------------------------------------------------

Spell Property VampireSunDamage01 Auto
Spell Property VampireSunDamage02 Auto
Spell Property VampireSunDamage03 Auto
Spell Property VampireSunDamage04 Auto

;-------------------------------------------------------------------------------
; ANIMATION EVENT NAMES
;-------------------------------------------------------------------------------

String Property Ground = "GroundStart" Auto
String Property Levitate = "LevitateStart" Auto
String Property BiteStart = "BiteStart" Auto
String Property LiftoffStart = "LiftoffStart" Auto
String Property LandStart = "LandStart" Auto
String Property TransformToHuman = "TransformToHuman" Auto

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Bool Prepped = False
Bool Transformed = False
Bool TrackingStarted = False
Bool TryingToShiftBack = False
Bool ShiftingBack = False
Bool ShuttingDown = False

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnInit()

  DLC1BatsCount.Value = 0
  DLC1MistformCount.Value = 0
  DLC1ReflexesCount.Value = 0

EndEvent

Event OnAnimationEvent(ObjectReference Target, String EventName)

  Actor PlayerRef = Game.GetPlayer()

  If Target != PlayerRef
    Return
  EndIf

  ; TRANSFORM TO HUMAN
  If EventName == TransformToHuman
    ActuallyShiftBackIfNecessary()
  EndIf
  ; END TRANSFORM TO HUMAN

  ; COMBAT BITE
  If EventName == BiteStart
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

      PlayerRef.SetActorValue("VampirePerks", DLC1VampireBloodPoints.Value / DLC1VampireNextPerk.Value * 100)
    EndIf

    If PlayerRef.HasPerk(DLC1VampireBite)
      PlayerRef.RestoreActorValue("Health", DLC1BiteHealthRecover)
    EndIf

    PlayerRef.SetActorValue("VampirePerks", DLC1VampireBloodPoints.Value / DLC1VampireNextPerk.Value * 100)
    Game.IncrementStat("Necks Bitten")
  EndIf
  ; END COMBAT BITE

  ; STARTING TO LAND
  If EventName == LandStart
    DCL1VampireLevitateStateGlobal.SetValue(1)
  EndIf
  ; END STARTING TO LAND

  ; LANDED
  If EventName == Ground
    DCL1VampireLevitateStateGlobal.SetValue(1)

    ; Update the currently equipped left hand spell.
    CurrentEquippedSpell = PlayerRef.GetEquippedSpell(0)

    ; There may not be a currently equipped spell when on the ground. Store it
    ; so that it can be re-equipped next time the player levitates.
    If CurrentEquippedSpell
      PlayerRef.UnequipSpell(CurrentEquippedSpell, 0)
    EndIf

    ; Now unequip and remove whatever spells are in the left & right hands.
    PlayerRef.UnequipSpell(LeveledDrainSpell, 1)
    PlayerRef.RemoveSpell(LeveledRaiseDeadSpell)
    PlayerRef.RemoveSpell(DlC1CorpseCurse)
    PlayerRef.RemoveSpell(DLC1VampiresGrip)
    PlayerRef.RemoveSpell(DLC1ConjureGargoyleLeftHand)
  EndIf
  ; END LANDED

  ; LIFTOFF
  If EventName == LiftoffStart
    ; We actually want the glow to start playing at the begining of the takoff anim.
    DCL1VampireLevitateStateGlobal.SetValue(2)
  EndIf
  ; END LIFTOFF

  ; LEVITATING
  If EventName == Levitate
    DCL1VampireLevitateStateGlobal.SetValue(2)

    ; Always equip a Vampire Drain in the right hand.
    PlayerRef.EquipSpell(LeveledDrainSpell, 1)

    ; Re-equip whatever spell was previously eqiupped in the left hand. If no
    ; spell was equipped, default the the Raise Dead spell.
    If (DialogueGenericVampire as VampireQuestScript).LastLeftHandSpell == None
      (DialogueGenericVampire as VampireQuestScript).LastLeftHandSpell = LeveledRaiseDeadSpell
    EndIf

    CurrentEquippedSpell = (DialogueGenericVampire as VampireQuestScript).LastLeftHandSpell

    ; Check to see if we need to add any perk-related spells.
    ; We need to do this here because the player may have added new perks since
    ; the last time.
    CheckPerkSpells()
    PlayerRef.AddSpell(LeveledRaiseDeadSpell, False)
    PlayerRef.EquipSpell(CurrentEquippedSpell, 0)
    PlayerRef.EquipSpell(LeveledDrainSpell, 1)
  EndIf
  ; END LEVITATING

EndEvent

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function PrepShift()
{
  Called from Stage 0.

  Initiated from DLC1VampireChangeEffectScript in OnEffectStart(), which calls
  Start() on DLC1PlayerVampireQuest.
}

  Actor PlayerRef = Game.GetPlayer()

  ; Set up the UI restrictions.
  PreTransformDisablePlayerControls()
  Game.EnableFastTravel(False)
  Game.ForceThirdPerson()
  Game.ShowFirstPersonGeometry(False)
  Game.SetBeastForm(True)
  PlayerRef.AddPerk(DLC1VampireActivationBlocker)

  ; Screen effect.
  VampireChange.Apply()
  VampireIMODSound.Play(PlayerRef)

  ; Dispel summons.
  DispelSummons()

  ; Set up perks/abilities.
  PlayerRef.SetActorValue("GrabActorOffset", 70)

  ; First, establish our leveled spells. The player cannot level up while
  ; a Vampire Lord so we only need to do this once.
  EstablishLeveledSpells()

  ; Preload the spells the player can equip.
  PreloadSpells()

  ; Indicate that we're finished prepping. This is used
  ; to prevent HandlePlayerLoadGame from calling Preload when we don't need it.
  Prepped = True

EndFunction

Function InitialShift()
{
  Called from Stage 1.

  Initiated from DLC1VampireTransfromVisual in Transform().
}

  If Transformed
    Return
  EndIf

  Transformed = True
  Actor PlayerRef = Game.GetPlayer()

  If PlayerRef.IsDead()
    Return
  EndIf

  ; The player needs to be invulnerable during the transition.
  ; OnRaceSwitchcomplete() will disable the invunlerability.
  PlayerRef.GetActorBase().SetInvulnerable(True)
  PlayerRef.SetGhost(True)

  ; Check if the player is wearing any Night Power/Blood Magic artifacts.
  If PlayerRef.isEquipped(DLC1nVampireBloodMagicRingBeast)
    DLC1nVampireRingBeast.SetValue(1)
  EndIf

  If PlayerRef.isEquipped(DLC1nVampireBloodMagicRingErudite)
    DLC1nVampireRingErudite.SetValue(1)
  EndIf

  If PlayerRef.isEquipped(DLC1nVampireNightPowerNecklaceBats)
    DLC1nVampireNecklaceBats.SetValue(1)
  EndIf

  If PlayerRef.isEquipped(DLC1nVampireNightPOwerNecklaceGargoyle)
    DLC1nVampireNecklaceGargoyle.SetValue(1)
  EndIf

  ; Remove player's inventory prior to race change, causing them to be naked
  ; when they change back.
  PlayerRef.UnequipAll()

  VampireWarn.Apply()

  ; Initialize the full shift by triggering the OnRaceSwitchComplete() event in
  ; DLC1PlayerVampireScript.
  PlayerRef.SetRace(DLC1VampireBeastRace)

  PlayerRef.AddSpell(DLC1AbVampireFloatBodyFX, abVerbose = False)

EndFunction

Function StartTracking()
{
  Called from DLC1PlayerVampireScript in OnRaceSwitchComplete().
}

  If TrackingStarted
    Return
  EndIf

  TrackingStarted = True
  Actor PlayerRef = Game.GetPlayer()

  ; Register for animation events now. This function is called after the race
  ; switch is complete, and the behavior graph changes during that time. If we
  ; register for events while the change is happening, one or more events might
  ; get un-registered when the player's behavior graph changes and we won't get
  ; events for it.
  DCL1VampireLevitateStateGlobal.SetValue(1)
  RegisterForEvents()

  ; Equip the vampire lord armor.
  ; PlayerRef.EquipItem(DLC1ClothesVampireLordArmor, False, True)

  ; Cause the player to be attacked on sight.
  VampireLordSetHate(True)

  ; Alert anyone nearby that they should now know the player is a vampire.
  ; Do not sned the transformation alert if the player is in Castle Volkihar.
  If !DLC1SendWerewolfLocationExceptions.HasForm(PlayerRef.GetCurrentLocation())
    Game.SendWereWolfTransformation()
  EndIf

  ; But they also don't know that it's you.
  Game.SetPlayerReportCrime(False)

  ; Remove vampire versions of sun damage.
  PlayerRef.RemoveSpell(VampireSunDamage01)
  PlayerRef.RemoveSpell(VampireSunDamage02)
  PlayerRef.RemoveSpell(VampireSunDamage03)
  PlayerRef.RemoveSpell(VampireSunDamage04)

  ; Add Vampire Lord Abilities.
  PlayerRef.AddSpell(DLC1VampireBats, False)
  PlayerRef.AddSpell(DLC1VampireLordSunDamage, False)
  PlayerRef.AddSpell(LeveledAbility, False)
  PlayerRef.AddSpell(VampireHuntersSight, False)

  ; Add the Revert power.
  PlayerRef.AddSpell(DLC1Revert, False)

  ; Default power is Bats.
  If (DialogueGenericVampire as VampireQuestScript).LastPower == None
    (DialogueGenericVampire as VampireQuestScript).LastPower = DLC1VampireBats
  EndIf

  ; Equip the last spell the player had equipped as a vampire lord.
  PlayerRef.EquipSpell((DialogueGenericVampire as VampireQuestScript).LastPower, 2)

  ; Verify the player has all perk-enabled spells.
  CheckPerkSpells()

  ; Player won't trigger pressure plates as a Vampire Lord.
  If PlayerRef.HasPerk(Lightfoot)
    DLC1HasLightfoot = True
  else
    DLC1HasLightfoot = False
    PlayerRef.AddPerk(Lightfoot)
  EndIf

  ; Ensure the Vampire Lord change ability has been removed.
  PlayerRef.DispelSpell(DLC1VampireChange)

  ; Re-enable controls, saving and waiting.
  VampireLordEnablePlayerControls()

  ; We're done with the transformation handling. Player is now free to roam as a
  ; Vampire Lord.
  SetStage(10)

EndFunction

Function Revert()
{
  Called from DLC1RevertEffectScript in OnEffectStart().
}

  If Game.QueryStat("NumVampirePerks") >= DLC1VampireMaxPerks.Value
    Game.AddAchievement(58)
  EndIf

  SetStage(100)

EndFunction

Function ShiftBack()
{
  Called from Stage 100.
}

  If TryingToShiftBack
    Return
  EndIf

  TryingToShiftBack = True
  Actor PlayerRef = Game.GetPlayer()

  While PlayerRef.GetAnimationVariableBool("bIsSynced")
    Utility.Wait(0.1)
  EndWhile

  ShiftingBack = False

  ActuallyShiftBackIfNecessary()

EndFunction

Function ActuallyShiftBackIfNecessary()
{
  Called from ShiftBack() and TransformToHuman animation event.
}

  If ShiftingBack
    Return
  EndIf

  ShiftingBack = True
  Actor PlayerRef = Game.GetPlayer()

  ; Disable save and wait while reverting form.
  PreTransformDisablePlayerControls()

  ; Unregister for animation events first, because if we don't we could get
  ; a Levitate event after we've set DLC1VampireLevitateStateGlobal to 1, and
  ; the value would be incorrect.
  UnregisterForEvents()
  DCL1VampireLevitateStateGlobal.SetValue(1)

  If PlayerRef.IsDead()
    Return
  EndIf

  VampireChange.Apply()
  VampireIMODSound.Play(PlayerRef)

  ; We now add the effect with a long duration and remove it later.
  DLC1VampireChangeBackFXS.Play(PlayerRef, 12.0)

  ; Dispel summons.
  DispelSummons()

  ; Remove the light foot perk if the player has not earned it.
  If !DLC1HasLightfoot
    PlayerRef.RemovePerk(Lightfoot)
  EndIf

  ; Save CurrentEquippedSpell to re-equip when returning to Vampire Lord form.
  CurrentEquippedSpell = PlayerRef.GetEquippedSpell(0)
  (DialogueGenericVampire as VampireQuestScript).LastLeftHandSpell = CurrentEquippedSpell

  ; Save LastEquippedPower to re-equip when returning to Vampire Lord form.
  (DialogueGenericVampire as VampireQuestScript).LastPower = LastEquippedPower

  ; Clear out perks/abilities.
  PlayerRef.RemoveSpell(LeveledAbility)
  PlayerRef.RemoveSpell(LeveledDrainSpell)
  PlayerRef.RemoveSpell(LeveledRaiseDeadSpell)

  PlayerRef.RemoveSpell(DLC1ConjureGargoyleLeftHand)
  PlayerRef.RemoveSpell(DLC1CorpseCurse)
  PlayerRef.RemoveSpell(DLC1NightCloak)
  PlayerRef.RemoveSpell(DLC1Revert)
  PlayerRef.RemoveSpell(DLC1SupernaturalReflexes)
  PlayerRef.RemoveSpell(DLC1VampireBats)
  PlayerRef.RemoveSpell(DLC1VampireDetectLife)
  PlayerRef.RemoveSpell(DLC1VampireLordSunDamage)
  PlayerRef.RemoveSpell(DLC1VampireMistForm)
  PlayerRef.RemoveSpell(DLC1VampiresGrip)

  PlayerRef.DispelSpell(DLC1Revert)
  PlayerRef.DispelSpell(DLC1SupernaturalReflexes)
  PlayerRef.DispelSpell(DLC1VampireDetectLife)
  PlayerRef.DispelSpell(DLC1VampireMistform)
  PlayerRef.DispelSpell(VampireHuntersSight)

  ; Remove Vampire Lord VFX.
  PlayerRef.RemoveSpell(DLC1AbVampireFloatBodyFX)

  ; Restore current stage vampirism.
  PlayerVampireQuest.VampireProgression(PlayerRef, PlayerVampireQuest.VampireStatus, Verbose = False)

  ; Make sure your health is reasonable before turning you back.
  Float CurrentHealth = PlayerRef.GetAV("health")

  If CurrentHealth <= 70
    PlayerRef.RestoreAV("health", 70 - CurrentHealth)
  EndIf

  ; Remove vampire lord armor.
  ; PlayerRef.RemoveItem(DLC1ClothesVampireLordArmor, 2, True)

  ; Switch back the player race. This will call OnRaceSwitchComplete() on the
  ; DLC1PlayerVampireScript, which will in turn invoke Shutdown() on this
  ; script.
  PlayerRef.SetRace((VampireTrackingQuest as DLC1VampireTrackingQuest).PlayerRace)

  ; We remove the Effect shader here now. And now we also try to book end it
  ; with another shader.
  DLC1VampireChangeBackFXS.Stop(PlayerRef)
  DLC1VampireChangeBack02FXS.Play(PlayerRef, 0.1)

EndFunction

Function Shutdown()
{
  Called by DLC1PlayerVampireScript in OnRaceSwitchComplete().
}

  If ShuttingDown
    Return
  EndIf

  Actor PlayerRef = Game.GetPlayer()
  ShuttingDown = True

  ; Player should no longer be attacked on sight.
  VampireLordSetHate(False)

  ; And you're now recognized.
  Game.SetPlayerReportCrime(True)

  ; The player is no longer a Vampire Lord and so is not levitating.
  DCL1VampireLevitateStateGlobal.SetValue(0)

  ; We always have to call this in Shutdown, or the spell loaded counts will
  ; get out of sync.
  PlayerRef.RemoveSpell(VampireHuntersSight)

  ; Unload all Vampire Lord spells.
  UnloadSpells()

  ; Reset vampire item status variables and re-equip any that were equipped
  ; before transformation.
  If DLC1nVampireNecklaceBats.Value == 1
    PlayerRef.EquipItem(DLC1nVampireNightPowerNecklaceBats, abPreventRemoval = False, abSilent = True)
  EndIf

  If DLC1nVampireNecklaceGargoyle.Value == 1
    PlayerRef.EquipItem(DLC1nVampireNightPOwerNecklaceGargoyle, abPreventRemoval = False, abSilent = True)
  EndIf

  If DLC1nVampireRingBeast.Value == 1
    PlayerRef.EquipItem(DLC1nVampireBloodMagicRingBeast, abPreventRemoval = False, abSilent = True)
  EndIf

  If DLC1nVampireRingErudite.Value == 1
    PlayerRef.EquipItem(DLC1nVampireBloodMagicRingErudite, abPreventRemoval = False, abSilent = True)
  EndIf

  DLC1nVampireNecklaceBats.SetValue(0)
  DLC1nVampireNecklaceGargoyle.SetValue(0)
  DLC1nVampireRingBeast.SetValue(0)
  DLC1nVampireRingErudite.SetValue(0)

  ; Remove UI restrictions.
  PlayerRef.RemovePerk(DLC1VampireActivationBlocker)
  Game.SetBeastForm(False)
  Game.ShowFirstPersonGeometry(True)
  Game.EnableFastTravel(True)
  PostRevertEnablePlayerControls()

  ; Stop the quest.
  Stop()

EndFunction

Function EstablishLeveledSpells()
{
  This function figures out which Drain Spell and Vampire Ability the
  player should get as a Vampire Lord. It sets the properties LeveledDrainSpell and LeveledAbility.
}

  Actor PlayerRef = Game.GetPlayer()
  Int PlayerLevel = PlayerRef.GetLevel()

  ; Establish the leveled Vampire Drain spell.
  If PlayerLevel <= 10
    LeveledDrainSpell = DLC1VampireDrain05
    LeveledRaiseDeadSpell = DLC1VampireRaiseDeadLeftHand01
  ElseIf PlayerLevel <= 20
    LeveledDrainSpell = DLC1VampireDrain06
    LeveledRaiseDeadSpell = DLC1VampireRaiseDeadLeftHand02
  ElseIf PlayerLevel <= 30
    LeveledDrainSpell = DLC1VampireDrain07
    LeveledRaiseDeadSpell = DLC1VampireRaiseDeadLeftHand03
  ElseIf PlayerLevel <= 40
    LeveledDrainSpell = DLC1VampireDrain08
    LeveledRaiseDeadSpell = DLC1VampireRaiseDeadLeftHand04
  Else
    LeveledDrainSpell = DLC1VampireDrain09
    LeveledRaiseDeadSpell = DLC1VampireRaiseDeadLeftHand05
  EndIf

  ; Establish the Leveled Vampire Ability.
  If PlayerLevel <= 10
    LeveledAbility = DLC1PlayerVampireLvl10AndBelowAbility
  ElseIf PlayerLevel <= 15
    LeveledAbility = DLC1PlayerVampireLvl15AndBelowAbility
  ElseIf PlayerLevel <= 20
    LeveledAbility = DLC1PlayerVampireLvl20AndBelowAbility
  ElseIf PlayerLevel <= 25
    LeveledAbility = DLC1PlayerVampireLvl25AndBelowAbility
  ElseIf PlayerLevel <= 30
    LeveledAbility = DLC1PlayerVampireLvl30AndBelowAbility
  ElseIf PlayerLevel <= 35
    LeveledAbility = DLC1PlayerVampireLvl35AndBelowAbility
  ElseIf PlayerLevel <= 40
    LeveledAbility = DLC1PlayerVampireLvl40AndBelowAbility
  ElseIf PlayerLevel <= 45
    LeveledAbility = DLC1PlayerVampireLvl45AndBelowAbility
  Else
    LeveledAbility = DLC1PlayerVampireLvl50AndOverAbility
  EndIf

EndFunction

Function CheckPerkSpells()
{
  Check to see if we need to add any perk-gated spells. We call this at the
  initial shift, and again when we enter Levitate mode. The latter because we
  may have additional perks since we first became a vampire lord.
}

  Actor PlayerRef = Game.GetPlayer()

  If PlayerRef.HasPerk(DLC1CorpseCursePerk) \
      && !PlayerRef.HasSpell(DLC1CorpseCurse)
    PlayerRef.AddSpell(DLC1CorpseCurse, False)
  EndIf

  If PlayerRef.HasPerk(DLC1DetectLifePerk) \
      && !PlayerRef.HasSpell(DLC1VampireDetectLife)
    PlayerRef.AddSpell(DLC1VampireDetectLife, False)
  EndIf

  If PlayerRef.HasPerk(DLC1GargoylePerk) \
      && !PlayerRef.HasSpell(DLC1ConjureGargoyleLeftHand)
    PlayerRef.AddSpell(DLC1ConjureGargoyleLeftHand, False)
  EndIf

  If PlayerRef.HasPerk(DLC1MistformPerk) \
      && !PlayerRef.HasSpell(DLC1VampireMistform)
    PlayerRef.AddSpell(DLC1VampireMistform, False)
  EndIf

  If PlayerRef.HasPerk(DLC1NightCloakPerk) \
      && !PlayerRef.HasSpell(DLC1NightCloak)
    PlayerRef.AddSpell(DLC1NightCloak, False)
  EndIf

  If PlayerRef.HasPerk(DLC1SupernaturalReflexesPerk) \
      && !PlayerRef.HasSpell(DLC1SupernaturalReflexes)
    PlayerRef.AddSpell(DLC1SupernaturalReflexes, False)
  EndIf

  If PlayerRef.HasPerk(DLC1VampiricGrip) \
      && !PlayerRef.HasSpell(DLC1VampiresGrip)
    PlayerRef.AddSpell(DLC1VampiresGrip, False)
  EndIf

EndFunction

Function DispelSummons()
{
  Dispel summoning spells, such as from the school of conjuration or werewolf
  form.
}

  Actor PlayerRef = Game.GetPlayer()
  Int Count = VampireDispelList.GetSize()

  While Count
    Count -= 1
    Spell SpellToDispel = VampireDispelList.GetAt(Count) as Spell

    If SpellToDispel != None
      PlayerRef.DispelSpell(SpellToDispel)
    EndIf
  EndWhile

EndFunction

Function VampireLordSetHate(Bool Hate = True)
{
  Set whether the player should be an enemy of vampire hate factions.
}

  Actor PlayerRef = Game.GetPlayer()

  ; Add the player to the vampire lord faction.
  If Hate
    PlayerRef.AddToFaction(DLC1PlayerVampireLordFaction)
  Else
    PlayerRef.RemoveFromFaction(DLC1PlayerVampireLordFaction)
  EndIf

  Int Index = DLC1VampireHateFactions.GetSize()

  While Index
    Index -= 1
    (DLC1VampireHateFactions.GetAt(Index) as Faction).SetPlayerEnemy(Hate)
  EndWhile

  PlayerRef.SetAttackActorOnSight(Hate)

EndFunction

Function RegisterForEvents()
{
  Register for all of the animation events we care about.
}

  Actor PlayerRef = Game.GetPlayer()

  RegisterForAnimationEvent(PlayerRef, Ground)
  RegisterForAnimationEvent(PlayerRef, Levitate)
  RegisterForAnimationEvent(PlayerRef, BiteStart)
  RegisterForAnimationEvent(PlayerRef, LiftoffStart)
  RegisterForAnimationEvent(PlayerRef, LandStart)
  RegisterForAnimationEvent(PlayerRef, TransformToHuman)

EndFunction

Function UnregisterForEvents()
{
  Unregister for all registered animation events.
}

  Actor PlayerRef = Game.GetPlayer()

  UnRegisterForAnimationEvent(PlayerRef, Ground)
  UnRegisterForAnimationEvent(PlayerRef, Levitate)
  UnRegisterForAnimationEvent(PlayerRef, BiteStart)
  UnRegisterForAnimationEvent(PlayerRef, LiftoffStart)
  UnRegisterForAnimationEvent(PlayerRef, LandStart)
  UnRegisterForAnimationEvent(PlayerRef, TransformToHuman)

EndFunction

Function HandleEquippedPower(Spell EquippedPower)
{
  Called from DLC1PlayerVampireScript when the player equips a power.
}

  If EquippedPower != DLC1Revert
    LastEquippedPower = EquippedPower
  EndIf

EndFunction

Function HandlePlayerLoadGame()
{
  This function is called from DLC1PlayerVampireScript from the OnPlayerLoadGame
  event. Since the preloaded state of spells is not saved, we need to balance
  our Preload calls with Unload calls. This function

  We only do this after PrepShift has finished. That way we avoid calls to this
  function before or while PrepShift is active, thereby avoiding calling
  PreloadSpells twice.
}

  If Prepped
    PreloadSpells()
  EndIf

EndFunction

Function PreloadSpells()
{
  Preload all of the spells that could be equipped to the left or right hand.
  This will prevent a delay after EquipSpell before the casting art is loaded.
  This should be called when we start the script.
}

  LeveledDrainSpell.Preload()
  LeveledRaiseDeadSpell.Preload()
  DLC1ConjureGargoyleLeftHand.Preload()
  DLC1CorpseCurse.Preload()
  DLC1VampiresGrip.Preload()

EndFunction

Function UnloadSpells()
{
  Unload all of the spells the player could equip.
  This should be called when we shut the script down.
}

  LeveledDrainSpell.Unload()
  LeveledRaiseDeadSpell.Unload()
  DLC1ConjureGargoyleLeftHand.Unload()
  DLC1CorpseCurse.Unload()
  DLC1VampiresGrip.Unload()

EndFunction

Function PreTransformDisablePlayerControls()
{
  Disable controls during the transformation.
}

  Game.SetInChargen(True, True, False)

  Game.DisablePlayerControls( \
      abMovement = True, \
      abFighting = True, \
      abCamSwitch = True, \
      abMenu = True, \
      abActivate = True, \
      abJournalTabs = True, \
      aiDisablePOVType = 1)

EndFunction

Function PostRevertEnablePlayerControls()
{
  Enable controls after revert form.
}

  Game.EnablePlayerControls( \
      abMovement = True, \
      abFighting = True, \
      abCamSwitch = True, \
      abMenu = True, \
      abActivate = True, \
      abJournalTabs = True, \
      aiDisablePOVType = 1)

  Game.SetInChargen(False, False, False)

EndFunction

Function VampireLordEnablePlayerControls()
{
  Enable controls appropriate for Vamprie Lord form.
}

  Game.EnablePlayerControls( \
      abMovement = True, \
      abFighting = True, \
      abCamSwitch = False, \
      abMenu = True, \
      abActivate = True, \
      abJournalTabs = True, \
      aiDisablePOVType = 1)

  Game.DisablePlayerControls( \
      abMovement = False, \
      abFighting = False, \
      abCamSwitch = True, \
      abMenu = False, \
      abActivate = False, \
      abJournalTabs = False, \
      aiDisablePOVType = 1)

  Game.SetInChargen(False, False, False)

EndFunction

; ------------------------------------------------------------------------------
; OBSOLETE FUNCTIONS
; ------------------------------------------------------------------------------

Function Feed(Actor victim)
{
  Called from Stage 11 (disabled).
}

EndFunction

Function WarnPlayer()
{
  Called from Stage 20 (disabled).
}

  VampireWarn.Apply()

EndFunction
