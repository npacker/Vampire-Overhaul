Scriptname DLC1PlayerVampireChangeScript extends Quest

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Race Property DLC1VampireBeastRace Auto
{ The vampire lord race. }

Actor Property PlayerRef Auto
{ The Player. }

;-------------------------------------------------------------------------------
; VAMPIRE LORD FX
;-------------------------------------------------------------------------------

ImageSpaceModifier Property VampireWarn Auto
{ Image space modifier played before change.  }

ImageSpaceModifier Property VampireChange Auto
{ Image space modifier played upon change. }

Sound Property VampireIMODSound Auto
{ Sound played upon change. }

Static Property XMarker Auto
{ Marker at which to play change sound. }

EffectShader Property DLC1VampireChangeBack01FXS Auto
{ Visual effect for revert form. }

Armor Property DLC1ClothesVampireLordArmor Auto
{ The armor worn by the Vampire Lord. }

Spell Property DLC1AbVampireFloatBodyFX Auto
{Spell FX Art holder for Levitation Glow.}

;-------------------------------------------------------------------------------
; VAMPIRE TRACKING
;-------------------------------------------------------------------------------

PlayerVampireQuestScript Property PlayerVampireQuest Auto
{ The main player vampire tracking quest. }

DLC1VampireTrackingQuest Property DLC1VampireLordTrackingQuest Auto
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

Spell Property CurrentEquippedLeftSpell Auto
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
Spell Property DLC1VampireDrain10 Auto

Spell Property LeveledRaiseDeadSpell Auto
Spell Property DLC1VampireRaiseDeadLeftHand01 Auto
Spell Property DLC1VampireRaiseDeadLeftHand02 Auto
Spell Property DLC1VampireRaiseDeadLeftHand03 Auto
Spell Property DLC1VampireRaiseDeadLeftHand04 Auto
Spell Property DLC1VampireRaiseDeadLeftHand05 Auto
Spell Property DLC1VampireRaiseDeadLeftHand06 Auto

Spell Property LeveledConjureGargoyleSpell Auto
Spell Property DLC1ConjureGargoyleLeftHand01 Auto
Spell Property DLC1ConjureGargoyleLeftHand02 Auto
Spell Property DLC1ConjureGargoyleLeftHand03 Auto

Spell Property DLC1VampiresGrip Auto
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

Perk Property DLC1FallDamageReduction Auto
{ Vampire Lord takes reduced fall damage. }

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

ObjectReference SoundMarker

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnAnimationEvent(ObjectReference Target, String EventName)

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
    AdvanceBloodPoints()

    If PlayerRef.HasPerk(DLC1VampireBite)
      PlayerRef.RestoreActorValue("Health", DLC1BiteHealthRecover)
    EndIf

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

    ; There may not be a currently equipped spell when on the ground. Store it
    ; so that it can be re-equipped next time the player levitates.
    If PlayerRef.GetEquippedItemType(0) == 9
      CurrentEquippedLeftSpell = PlayerRef.GetEquippedSpell(0)

      PlayerRef.UnequipSpell(CurrentEquippedLeftSpell, 0)
    EndIf

    ; Now unequip and remove whatever spells are in the left & right hands.
    PlayerRef.UnequipSpell(LeveledDrainSpell, 1)
    PlayerRef.RemoveSpell(LeveledConjureGargoyleSpell)
    PlayerRef.RemoveSpell(LeveledRaiseDeadSpell)
    PlayerRef.RemoveSpell(DlC1CorpseCurse)
    PlayerRef.RemoveSpell(DLC1VampiresGrip)
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

    ; Re-equip whatever spell was previously eqiupped in the left hand. If no
    ; spell was equipped, default the the Raise Dead spell.
    If CurrentEquippedLeftSpell == None
      If (DialogueGenericVampire as VampireQuestScript).LastLeftHandSpell == None
        CurrentEquippedLeftSpell = LeveledRaiseDeadSpell
      Else
        CurrentEquippedLeftSpell = (DialogueGenericVampire as VampireQuestScript).LastLeftHandSpell
      EndIf
    EndIf

    ; Check to see if we need to add any perk-related spells.
    ; We need to do this here because the player may have added new perks since
    ; the last time.
    CheckPerkSpells()
    PlayerRef.AddSpell(LeveledRaiseDeadSpell, False)
    PlayerRef.EquipSpell(CurrentEquippedLeftSpell, 0)
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

  ; Dispel summons.
  DispelSummons()

  ; Set up grab offset for Vampiric Grip.
  PlayerRef.SetActorValue("GrabActorOffset", 70)

  ; First, establish our leveled spells. The player cannot level up while
  ; a Vampire Lord so we only need to do this once.
  EstablishLeveledSpells()

  ; Preload the spells the player can equip.
  PreloadSpells()

  ; Abort if the player has died.
  If PlayerRef.IsDead()
    Return
  EndIf

  ; Set up the UI restrictions.
  PreTransformDisablePlayerControls()
  Game.EnableFastTravel(False)
  Game.ForceThirdPerson()
  Game.ShowFirstPersonGeometry(False)
  Game.SetBeastForm(True)
  PlayerRef.AddPerk(DLC1VampireActivationBlocker)

  ; Screen effect and sound.
  VampireChange.Apply()
  VampireIMODSound.Play(PlayerRef)

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

  ; Check if the player is wearing any Night Power/Blood Magic artifacts.
  If PlayerRef.isEquipped(DLC1nVampireBloodMagicRingBeast)
    DLC1nVampireRingBeast.SetValue(1)

    Float CurrentHealth = PlayerRef.GetActorValue("health")

    If CurrentHealth <= 100
      PlayerRef.RestoreActorValue("health", 101 - CurrentHealth)
    EndIf

    PlayerRef.UnequipItem(DLC1nVampireBloodMagicRingBeast, False, True)
  EndIf

  If PlayerRef.isEquipped(DLC1nVampireBloodMagicRingErudite)
    DLC1nVampireRingErudite.SetValue(1)

    Float CurrentMagicka = PlayerRef.GetActorValue("magicka")

    If CurrentMagicka <= 100
      PlayerRef.RestoreActorValue("magicka", 101 - CurrentMagicka)
    EndIf

    PlayerRef.UnequipItem(DLC1nVampireBloodMagicRingErudite, False, True)
  EndIf

  If PlayerRef.isEquipped(DLC1nVampireNightPowerNecklaceBats)
    DLC1nVampireNecklaceBats.SetValue(1)
  EndIf

  If PlayerRef.isEquipped(DLC1nVampireNightPOwerNecklaceGargoyle)
    DLC1nVampireNecklaceGargoyle.SetValue(1)
  EndIf

  ; Apply image space modifier before the magic happens.
  VampireWarn.Apply()

  ; Remove player's inventory prior to race change, causing them to be naked
  ; when they change back.
  PlayerRef.UnequipAll()

  ; Initialize the full shift by triggering the OnRaceSwitchComplete() event in
  ; DLC1PlayerVampireScript.
  PlayerRef.SetRace(DLC1VampireBeastRace)

EndFunction

Function PostChange()
{
  Called from DLC1PlayerVampireScript in OnRaceSwitchComplete().
}

  If TrackingStarted
    Return
  EndIf

  TrackingStarted = True

  ; Add levitation VFX.
  PlayerRef.AddSpell(DLC1AbVampireFloatBodyFX, abVerbose = False)

  ; Register for animation events now. This function is called after the race
  ; switch is complete, and the behavior graph changes during that time. If we
  ; register for events while the change is happening, one or more events might
  ; get un-registered when the player's behavior graph changes and we won't get
  ; events for it.
  RegisterForEvents()

  ; Equip the vampire lord armor.
  ; Int VampireLordArmorCount = PlayerRef.GetItemCount(DLC1ClothesVampireLordArmor)
  ;
  ; If VampireLordArmorCount == 0
  ;   PlayerRef.AddItem(DLC1ClothesVampireLordArmor, 1, abSilent = True)
  ; EndIf
  ;
  ; PlayerRef.EquipItem(DLC1ClothesVampireLordArmor, abPreventRemoval = True, abSilent = True)

  ; Replace with Vampire Lord version of sun damage.
  PlayerRef.AddSpell(DLC1VampireLordSunDamage, False)

  ; Add Vampire Lord leveled abilities.
  PlayerRef.AddSpell(LeveledAbility, False)

  ; Add base Vampire Lord powers.
  PlayerRef.AddSpell(DLC1VampireBats, False)
  PlayerRef.AddSpell(VampireHuntersSight, False)

  ; Add the Revert power.
  PlayerRef.AddSpell(DLC1Revert, False)

  ; Default power is Bats if none was previously equipped.
  If (DialogueGenericVampire as VampireQuestScript).LastPower == None
    (DialogueGenericVampire as VampireQuestScript).LastPower = DLC1VampireBats
  EndIf

  ; Equip the last power the player had equipped as a vampire lord.
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

  ; Add fall damage reduction perk.
  PlayerRef.AddPerk(DLC1FallDamageReduction)

  ; Ensure the Vampire Lord change ability has been removed.
  PlayerRef.DispelSpell(DLC1VampireChange)

  ; Cause the player to be attacked on sight.
  VampireLordSetHate(True)

  ; Create a detection event in case the player is hidden when they turn.
  PlayerRef.CreateDetectionEvent(PlayerRef, 500)

  ; Alert anyone nearby that they should now know the player is a vampire.
  ; Do not sned the transformation alert if the player is in Castle Volkihar.
  If !DLC1SendWerewolfLocationExceptions.HasForm(PlayerRef.GetCurrentLocation())
    Game.SendWereWolfTransformation()
  EndIf

  ; But they also don't know that it's you.
  Game.SetPlayerReportCrime(False)

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

  If Game.QueryStat("NumVampirePerks") >= DLC1VampireMaxPerks.GetValue()
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

  While PlayerRef.GetAnimationVariableBool("bIsSynced")
    Utility.Wait(0.05)
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

  ; Abort if the player has died.
  If PlayerRef.IsDead()
    Return
  EndIf

  ; Disable save and wait while reverting form.
  PreTransformDisablePlayerControls()

  ; Unregister for animation events first, because if we don't we could get
  ; a Levitate event after we've set DLC1VampireLevitateStateGlobal to 1, and
  ; the value would be incorrect.
  UnregisterForEvents()

  ; We now add the visual FX with a long duration and remove it later.
  DLC1VampireChangeBack01FXS.Play(PlayerRef)

  ; Apply revert screen effects.
  VampireChange.Apply()

  ; Place sound marker.
  SoundMarker = PlayerRef.PlaceAtMe(XMarker)

  ; Play transform sound.
  VampireIMODSound.Play(SoundMarker)

  ; Remove the light foot perk if the player has not earned it.
  If !DLC1HasLightfoot
    PlayerRef.RemovePerk(Lightfoot)
  EndIf

  ; Remove fall damage reduction.
  PlayerRef.RemovePerk(DLC1FallDamageReduction)

  ; Save CurrentEquippedLeftSpell to re-equip when returning to Vampire Lord form.
  (DialogueGenericVampire as VampireQuestScript).LastLeftHandSpell = CurrentEquippedLeftSpell

  ; Save LastEquippedPower to re-equip when returning to Vampire Lord form.
  (DialogueGenericVampire as VampireQuestScript).LastPower = LastEquippedPower

  ; Ensure attributes are at a reasonable level after changing back.
  Float CurrentHealth = PlayerRef.GetActorValue("health")
  Float CurrentStamina = PlayerRef.GetActorValue("stamina")
  Float CurrentMagicka = PlayerRef.GetActorValue("magicka")

  If CurrentHealth < 100
    PlayerRef.RestoreActorValue("health", 100 - CurrentHealth)
  EndIf

  If CurrentStamina < 100
    PlayerRef.RestoreActorValue("stamina", 100 - CurrentStamina)
  EndIf

  If CurrentMagicka < 100
    PlayerRef.RestoreActorValue("magicka", 100 - CurrentMagicka)
  EndIf

  ; Clear out perks/abilities.
  PlayerRef.RemoveSpell(LeveledAbility)
  PlayerRef.RemoveSpell(LeveledDrainSpell)
  PlayerRef.RemoveSpell(LeveledRaiseDeadSpell)
  PlayerRef.RemoveSpell(LeveledConjureGargoyleSpell)

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

  ; Land before transforming back.
  ; If !PlayerRef.IsSneaking()
    ; PlayerRef.StartSneaking()
    ; PlayerRef.WaitForAnimationEvent(Ground)
  ; EndIf

  ; Remove Vampire Lord VFX.
  PlayerRef.RemoveSpell(DLC1AbVampireFloatBodyFX)

  ; Re-equip vampire items that were equipped before transformation.
  If DLC1nVampireNecklaceBats.GetValue() == 1
    PlayerRef.EquipItem(DLC1nVampireNightPowerNecklaceBats, abPreventRemoval = False, abSilent = True)
  EndIf

  If DLC1nVampireNecklaceGargoyle.GetValue() == 1
    PlayerRef.EquipItem(DLC1nVampireNightPOwerNecklaceGargoyle, abPreventRemoval = False, abSilent = True)
  EndIf

  If DLC1nVampireRingBeast.GetValue() == 1
    PlayerRef.EquipItem(DLC1nVampireBloodMagicRingBeast, abPreventRemoval = False, abSilent = True)
  EndIf

  If DLC1nVampireRingErudite.GetValue() == 1
    PlayerRef.EquipItem(DLC1nVampireBloodMagicRingErudite, abPreventRemoval = False, abSilent = True)
  EndIf

  ; Remove vampire lord armor.
  ; Int VampireLordArmorCount = PlayerRef.GetItemCount(DLC1ClothesVampireLordArmor)
  ;
  ; PlayerRef.RemoveItem(DLC1ClothesVampireLordArmor, aiCount = VampireLordArmorCount, abSilent = True)

  ; Ensure effect shader is removed.
  DLC1VampireChangeBack01FXS.Stop(PlayerRef)

  ; Switch back the player race. This will call OnRaceSwitchComplete() on the
  ; DLC1PlayerVampireScript, which will in turn invoke PostRevert() on this
  ; script.
  Utility.Wait(0.1)
  PlayerRef.SetRace(DLC1VampireLordTrackingQuest.PlayerRace)

EndFunction

Function PostRevert()
{
  Called by DLC1PlayerVampireScript in OnRaceSwitchComplete().
}

  If ShuttingDown
    Return
  EndIf

  ShuttingDown = True

  ; Apply ending effect shader.
  DLC1VampireLordTrackingQuest.PlayRevertShaderTail()

  ; Player should no longer be attacked on sight.
  VampireLordSetHate(False)

  ; And you're now recognized.
  Game.SetPlayerReportCrime(True)

  ; We always have to call this in Shutdown, or the spell loaded counts will
  ; get out of sync.
  PlayerRef.RemoveSpell(VampireHuntersSight)

  ; Run shutdown tasks.
  Shutdown()

EndFunction

Function Shutdown()
{
  Clean up state and stop quest.
}

  ; Unload all Vampire Lord spells.
  UnloadSpells()

  ; The player is no longer a Vampire Lord and so is not levitating.
  DCL1VampireLevitateStateGlobal.SetValue(0)

  ; Reset vampire item status variables.
  DLC1nVampireNecklaceBats.SetValue(0)
  DLC1nVampireNecklaceGargoyle.SetValue(0)
  DLC1nVampireRingBeast.SetValue(0)
  DLC1nVampireRingErudite.SetValue(0)

  ; Delete sound marker.
  If SoundMarker
    SoundMarker.Disable()
    SoundMarker.Delete()
  EndIf

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

  Int PlayerLevel = PlayerRef.GetLevel()

  If PlayerLevel <= 25
    LeveledConjureGargoyleSpell = DLC1ConjureGargoyleLeftHand01
  ElseIf PlayerLevel <= 40
    LeveledConjureGargoyleSpell = DLC1ConjureGargoyleLeftHand02
  Else
    LeveledConjureGargoyleSpell = DLC1ConjureGargoyleLeftHand03
  EndIf

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
  ElseIf PlayerLevel <= 50
    LeveledDrainSpell = DLC1VampireDrain09
    LeveledRaiseDeadSpell = DLC1VampireRaiseDeadLeftHand05
  Else
    LeveledDrainSpell = DLC1VampireDrain10
    LeveledRaiseDeadSpell = DLC1VampireRaiseDeadLeftHand06
  EndIf

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

  If PlayerRef.HasPerk(DLC1CorpseCursePerk) \
      && !PlayerRef.HasSpell(DLC1CorpseCurse)
    PlayerRef.AddSpell(DLC1CorpseCurse, False)
  EndIf

  If PlayerRef.HasPerk(DLC1DetectLifePerk) \
      && !PlayerRef.HasSpell(DLC1VampireDetectLife)
    PlayerRef.AddSpell(DLC1VampireDetectLife, False)
  EndIf

  If PlayerRef.HasPerk(DLC1GargoylePerk) \
      && !PlayerRef.HasSpell(LeveledConjureGargoyleSpell)
    PlayerRef.AddSpell(LeveledConjureGargoyleSpell, False)
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

  If Hate
    PlayerRef.AddToFaction(DLC1PlayerVampireLordFaction)
  Else
    PlayerRef.RemoveFromFaction(DLC1PlayerVampireLordFaction)
  EndIf

  Int Index = DLC1VampireHateFactions.GetSize()

  While Index
    Index -= 1

    Faction HateFaction = DLC1VampireHateFactions.GetAt(Index) as Faction

    HateFaction.SetEnemy(DLC1PlayerVampireLordFaction)
    HateFaction.SetPlayerEnemy(Hate)
  EndWhile

EndFunction

Function AdvanceBloodPoints()

  DLC1VampireBloodPoints.SetValue(DLC1VampireBloodPoints.GetValue() + 1)

  If DLC1VampireTotalPerksEarned.GetValue() < DLC1VampireMaxPerks.GetValue()
    DLC1BloodPointsMsg.Show()

    If DLC1VampireBloodPoints.GetValue() >= DLC1VampireNextPerk.GetValue()
      DLC1VampireBloodPoints.SetValue(DLC1VampireBloodPoints.GetValue() - DLC1VampireNextPerk.GetValue())
      DLC1VampirePerkPoints.SetValue(DLC1VampirePerkPoints.GetValue() + 1)
      DLC1VampireTotalPerksEarned.SetValue(DLC1VampireTotalPerksEarned.GetValue() + 1)
      DLC1VampireNextPerk.SetValue(DLC1VampireNextPerk.GetValue() + 2)
      DLC1VampirePerkEarned.Show()
    EndIf
  EndIf

  PlayerRef.SetActorValue("VampirePerks", DLC1VampireBloodPoints.GetValue() / DLC1VampireNextPerk.GetValue() * 100.0)

EndFunction

Function RegisterForEvents()

  DCL1VampireLevitateStateGlobal.SetValue(1)

  RegisterForAnimationEvent(PlayerRef, Ground)
  RegisterForAnimationEvent(PlayerRef, Levitate)
  RegisterForAnimationEvent(PlayerRef, BiteStart)
  RegisterForAnimationEvent(PlayerRef, LiftoffStart)
  RegisterForAnimationEvent(PlayerRef, LandStart)
  RegisterForAnimationEvent(PlayerRef, TransformToHuman)

EndFunction

Function UnregisterForEvents()

  UnRegisterForAnimationEvent(PlayerRef, Ground)
  UnRegisterForAnimationEvent(PlayerRef, Levitate)
  UnRegisterForAnimationEvent(PlayerRef, BiteStart)
  UnRegisterForAnimationEvent(PlayerRef, LiftoffStart)
  UnRegisterForAnimationEvent(PlayerRef, LandStart)
  UnRegisterForAnimationEvent(PlayerRef, TransformToHuman)

  DCL1VampireLevitateStateGlobal.SetValue(1)

EndFunction

Function HandleEquippedspell(Spell EquippedSpell)
{
  Called from DLC1PlayerVampireScript hwen the player equips a spell.
}

  CurrentEquippedLeftSpell = EquippedSpell

Endfunction

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
  LeveledConjureGargoyleSpell.Preload()
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
  LeveledConjureGargoyleSpell.Unload()
  DLC1CorpseCurse.Unload()
  DLC1VampiresGrip.Unload()

EndFunction

Function PreTransformDisablePlayerControls()

  (PlayerRef.GetBaseObject() as ActorBase).SetInvulnerable(True)

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

Function VampireLordEnablePlayerControls()

  Game.EnablePlayerControls( \
      abMovement = True, \
      abFighting = True, \
      abCamSwitch = False, \
      abMenu = True, \
      abActivate = True, \
      abJournalTabs = True, \
      aiDisablePOVType = 1)

  Game.SetInChargen(False, False, False)

  (PlayerRef.GetBaseObject() as ActorBase).SetInvulnerable(False)

EndFunction

Function PostRevertEnablePlayerControls()

  Game.EnablePlayerControls( \
      abMovement = True, \
      abFighting = True, \
      abCamSwitch = True, \
      abMenu = True, \
      abActivate = True, \
      abJournalTabs = True, \
      aiDisablePOVType = 1)

  Game.SetInChargen(False, False, False)

  (PlayerRef.GetBaseObject() as ActorBase).SetInvulnerable(False)

EndFunction
