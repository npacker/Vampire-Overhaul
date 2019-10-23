ScriptName PlayerVampireQuestScript extends Quest Conditional

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Int Property_VampireStatus Conditional

Int Property VampireStatus
{
   0 = Not a Vampire
   1 = Vampire Stage 1
   2 = Vampire Stage 2
   3 = Vampire Stage 3
   4 = Vampire Stage 4
}

  Int Function Get()
    Return Property_VampireStatus
  EndFunction

EndProperty

Int Property_VampireRank Conditional

Int Property VampireRank
{
   0 = Not a vampire
   1 = Vampire Fledgling
   2 = Blooded Vampire
   3 = Vampire Mistwalker
   4 = Vampire Nightstalker
   5 = Nightlord Vampire
   6 = Nightmaster Vampire
}

  Int Function Get()
    Return Property_VampireRank
  EndFunction

EndProperty

Int Property_Feedings Conditional

Int Property Feedings
{  Number of times fed since last becoming a vampire. }

  Int Function Get()
    Return Property_Feedings
  EndFunction

EndProperty

Float Property_LastFeedTime

Float Property LastFeedTime
{ Last time in game days of the last feeding. }

  Float Function Get()
    Return Property_LastFeedTime
  Endfunction

EndProperty

Actor Property PlayerRef Auto
{ The Player. }

GlobalVariable Property PlayerIsVampire Auto
{ Set to 1 if the player is a vampire, 0 otherwiese. }

GlobalVariable Property VampireFeedReady Auto
{ Set to the previous stage of vampirism during progression. }

Message Property VampireFeedMessage Auto
{ Message displayed upon feeding. }

Message Property VampireStageProgressionMessage Auto
{ Message displayed when hunger grows and stage advances. }

Message Property VampireFedMessage Auto
{ Messaged displayed when you attempt to feed when already fully-fed. }

Message Property VampireStage4Message Auto
{ Message displayed upon reaching Stage 4 Vampirism. }

Message[] Property VampireRankMessages Auto
{ Messages displayed upon reaching each Vampire rank. }

PlayerVampireRaceControllerScript Property PlayerVampireRaceController Auto
{ Quest script that handles mapping of race to Vampire race. }

Faction Property VampirePCFaction Auto
{ Stage 4 Vampire faction. }

Quest Property VC01 Auto
{ Vampire cure quest. }

FormList Property DLC1VampireHateFactions Auto
{ Factions that hate Vampires. }

ImageSpaceModifier Property VampireTransformDecreaseISMD Auto
{ Vampire feeding and progression image space modifier. }

ImageSpaceModifier Property VampireTransformIncreaseISMD Auto
{ Initial player vampire transformation image space modifier. }

EffectShader Property VampireChangeFX Auto
{ Vampire transformation shader. }

ReferenceAlias Property SoundMarkerRef Auto
{ Refernece Alias for tracking the sound marker. }

Static Property XMarker Auto
{ Marker at which to play vampire transformation sound. }

Sound Property MAGVampireTransform01 Auto
{ Vampire transformation sound. }

MagicEffect Property DLC1VampireChangeEffect Auto
{ Used to check for Vampire Lord form. }

MagicEffect Property DLC1VampireChangeFXEffect Auto
{ Used to check for Vampire Lord form. }

GlobalVariable Property GameDaysPassed Auto

Spell Property AbVampireSkills Auto
Spell Property AbVampireSkills02 Auto

Spell[] Property VampireStrengthSpells Auto

FormList Property VampireImmuneDiseases Auto

Spell Property AbVampireChillTouch Auto
Spell Property DLC1VampireChange Auto
Spell Property VampireBloodMemory Auto
Spell Property VampireChampionOfTheNight Auto
Spell Property VampireHuntersSight Auto
Spell Property VampireInvisibilityPC Auto
Spell Property VampireMesmerizingGaze Auto
Spell Property VampireNightstalker Auto
Spell Property VampireSunDamageBurn Auto

Spell[] Property AbVampireRankSpells Auto
Spell[] Property AbVampireResistanceSpells Auto
Spell[] Property AbVampireStageSpells Auto
Spell[] Property AbVampireWeaknessSpells Auto
Spell[] Property VampireCharmSpells Auto
Spell[] Property VampireClawsSpells Auto
Spell[] Property VampireDrainSpells Auto
Spell[] Property VampireRaiseThrallSpells Auto
Spell[] Property VampireSunDamageSpells Auto

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Float FeedTimerUpdateInterval = 1.0
; The interval at which the feed timer will update, in game hours.

Float LastUpdateTime
; The last VampireProgression() updated VampireStatus.

Bool Updating = False
; True if VampireProgression is in progress.

Bool Feeding = False
; True if player is feeding.

Bool Transforming = False
; True if the player is changing to or from being a vampire.

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnUpdateGameTime()
{
  Queue an update of the feed timer handler.
}

  Float TimeElapsed = GameDaysPassed.Value - LastUpdateTime

  If TimeElapsed >= 1.0
    VampireStopFeedTimer()
    RegisterForSingleUpdate(5.0)
  EndIf

EndEvent

Event OnUpdate()
{
  Handle an update of the feed timer.
}

  If VampireSafeToUpdate()
    Int NewStage = Property_VampireStatus + Math.Floor(GameDaysPassed.Value - LastUpdateTime)

    If NewStage > 4
      NewStage = 4
    EndIf

    VampireProgression(PlayerRef, NewStage, NewStage != Property_VampireStatus)
    VampireStartFeedTimer()
  Else
    RegisterForSingleUpdate(5.0)
  EndIf

EndEvent

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function VampireFeed()
{
  Handle vampire feeding and reset the feed timer.
}

  If Feeding
    Return
  EndIf

  Feeding = True
  Bool RankUpdated = False

  VampireStopFeedTimer()
  VampireImageSpaceModifier()

  If Property_VampireStatus > 1
    Property_Feedings += 1
    Property_LastFeedTime = GameDaysPassed.Value
    RankUpdated = VampireUpdateRank()

    VampireFeedMessage.Show()
    VampireProgression(PlayerRef, 1)

    If RankUpdated
      VampireShowRankMessage()
    EndIf
  EndIf

  VampireStartFeedTimer()

  Feeding = False

EndFunction

Function VampireProgression(Actor Target, Int NewStage, Bool Verbose = True)
{
  Handle vampire progression.
}

  If Updating
    Return
  EndIf

  Updating = True

  If !Transforming
    VampireDisableMenu()
  EndIf

  If NewStage >= 0 && NewStage <= 4
    If Property_VampireStatus != NewStage
      Property_VampireStatus = NewStage
      LastUpdateTime = GameDaysPassed.Value
    EndIf

    If Property_VampireStatus > 0
      PlayerIsVampire.SetValue(1)
      VampireFeedReady.SetValue(NewStage - 1)
    Else
      PlayerIsVampire.SetValue(0)
      VampireFeedReady.SetValue(0)
    EndIf
  EndIf

  PlayerRef.RemoveSpell(AbVampireSkills)
  PlayerRef.RemoveSpell(AbVampireSkills02)

  VampireRemoveLeveledSpells(VampireStrengthSpells)

  If Property_VampireStatus == 0
    PlayerRef.RemoveSpell(DLC1VampireChange)

    PlayerRef.RemoveSpell(AbVampireChillTouch)
    PlayerRef.RemoveSpell(VampireBloodMemory)
    PlayerRef.RemoveSpell(VampireChampionOfTheNight)
    PlayerRef.RemoveSpell(VampireNightstalker)

    PlayerRef.RemoveSpell(VampireInvisibilityPC)
    PlayerRef.RemoveSpell(VampireMesmerizingGaze)

    VampireRemoveLeveledSpells(VampireCharmSpells)
    VampireRemoveLeveledSpells(VampireRaiseThrallSpells)

    VampireRemoveLeveledSpells(AbVampireRankSpells)
    VampireRemoveLeveledSpells(VampireClawsSpells)
    VampireRemoveLeveledSpells(VampireDrainSpells)

    VampireRemoveLeveledSpells(AbVampireResistanceSpells)
    VampireRemoveLeveledSpells(AbVampireStageSpells)
    VampireRemoveLeveledSpells(AbVampireWeaknessSpells)
    VampireRemoveLeveledSpells(VampireSunDamageSpells)
  Else
    PlayerRef.AddSpell(AbVampireChillTouch, abVerbose = False)
    PlayerRef.AddSpell(VampireBloodMemory, abVerbose = False)
    PlayerRef.AddSpell(VampireChampionOfTheNight, abVerbose = False)
    PlayerRef.AddSpell(VampireNightstalker, abVerbose = False)

    If Property_VampireStatus == 1
      PlayerRef.AddSpell(VampireInvisibilityPC, abVerbose = False)
    Else
      PlayerRef.RemoveSpell(VampireInvisibilityPC)
    EndIf

    If Property_VampireStatus == 4
      PlayerRef.RemoveSpell(VampireMesmerizingGaze)

      VampireRemoveLeveledSpells(VampireCharmSpells)
      VampireRemoveLeveledSpells(VampireRaiseThrallSpells)
    Else
      PlayerRef.AddSpell(VampireMesmerizingGaze, abVerbose = False)

      VampireAddLeveledSpell(VampireCharmSpells, Property_VampireRank)
      VampireAddLeveledSpell(VampireRaiseThrallSpells, Property_VampireRank)
    EndIf

    VampireAddLeveledSpell(AbVampireRankSpells, Property_VampireRank)
    VampireAddLeveledSpell(VampireClawsSpells, Property_VampireRank)
    VampireAddLeveledSpell(VampireDrainSpells, Property_VampireRank)

    VampireAddLeveledSpell(AbVampireResistanceSpells, 5 - Property_VampireStatus)
    VampireAddLeveledSpell(AbVampireStageSpells, Property_VampireStatus)
    VampireAddLeveledSpell(AbVampireWeaknessSpells, Property_VampireStatus)
    VampireAddLeveledSpell(VampireSunDamageSpells, Property_VampireStatus)
  EndIf

  If Property_VampireStatus < 4
    VampireSetHated(False)

    If Verbose && Property_VampireStatus > 1
      VampireStageProgressionMessage.Show()
      VampireImageSpaceModifier()
    EndIf
  ElseIf Property_VampireStatus == 4
    VampireSetHated(True)

    If Verbose
      VampireStage4Message.Show()
      VampireImageSpaceModifier()
    EndIf
  EndIf

  If !Transforming
    VampireEnablePlayerControls()
  EndIf

  Updating = False

EndFunction

Function VampireChange(Actor Target)
{
  Vampire trasnformation.
}

  If Transforming
    Return
  EndIf

  Transforming = True

  VampireStopFeedTimer()
  VampireDisablePlayerControls()
  VampirePlayChange()
  PlayerRef.SetRace(PlayerVampireRaceController.GetVampireRace())
  VampireRemoveSpells(VampireImmuneDiseases)
  VampireUpdateRank()
  VampireShowRankMessage()
  VampireProgression(PlayerRef, 1)
  VampireStartFeedTimer()
  VampireEnablePlayerControls()

  ; If the player has been cured before, restart the cure quest.
  If VC01.GetStageDone(200) == 1
    VC01.SetStage(25)
  EndIf

  Transforming = False

EndFunction

Function VampireCure(Actor Target)
{
  Handle curing vampirism.
}

  If Transforming
    Return
  EndIf

  Transforming = True

  VampireStopFeedTimer()
  VampireDisablePlayerControls()
  VampireUpdateRank(Reset = True)
  VampireProgression(PlayerRef, 0)
  PlayerRef.DispelSpell(VampireHuntersSight)
  PlayerRef.SetRace(PlayerVampireRaceController.GetCureRace())
  PlayerRef.RemoveSpell(VampireHuntersSight)
  VampireEnablePlayerControls()
  Game.IncrementStat("Vampirism Cures")

  Transforming = False

EndFunction

Bool Function VampireSafeToUpdate()
{
  Determine whether it is safe to update the player's vampire state.
}

  Return Game.IsMovementControlsEnabled() \
      && Game.IsFightingControlsEnabled() \
      && !PlayerRef.IsInCombat() \
      && !PlayerRef.HasMagicEffect(DLC1VampireChangeEffect) \
      && !PlayerRef.HasMagicEffect(DLC1VampireChangeFXEffect) \
      && !Feeding \
      && !Updating \
      && !Transforming

EndFunction

Bool Function VampireUpdateRank(Bool Reset = False)
{
  Update the vampire rank to reflect current level and number of feedings.
}

  Int PlayerLevel = PlayerRef.GetLevel()
  Int OldVampireRank = Property_VampireRank

  If Reset
    Property_VampireRank = 0
  Else
    If Property_Feedings < 3
      Property_VampireRank = 1
    ElseIf Property_Feedings < 9 && PlayerLevel > 10
      Property_VampireRank = 2
    ElseIf Property_Feedings < 25 && PlayerLevel > 20
      Property_VampireRank = 3
    ElseIf Property_Feedings < 75 && PlayerLevel > 30
      Property_VampireRank = 4
    ElseIf Property_Feedings < 200 && PlayerLevel > 40
      Property_VampireRank = 5
    ElseIf PlayerLevel > 50
      Property_VampireRank = 6
    EndIf
  EndIf

  Return OldVampireRank != Property_VampireRank

EndFunction

Function VampireShowRankMessage()
{
  Display the message appropriate to the current vampire rank.
}

  VampireRankMessages[Property_VampireRank].Show()

EndFunction

Function VampireSetHated(Bool Hate = True)
{
  Enable or disable player vampire hate, causing them to be attacked on sight.
}

  If Hate
    PlayerRef.AddtoFaction(VampirePCFaction)
  Else
    PlayerRef.RemoveFromFaction(VampirePCFaction)
  EndIf

  Int Index = DLC1VampireHateFactions.GetSize()

  While (Index)
    Index -= 1
    (DLC1VampireHateFactions.GetAt(Index) as Faction).SetPlayerEnemy(Hate)
  EndWhile

EndFunction

Function VampireAddLeveledSpell(Spell[] VampireSpells, Int VampireLevel)
{
  Add a leveled spell from the given 1-indexed, ordered array.
}

  Int Index = VampireSpells.Length

  While Index > 1
    Index -= 1

    If Index == VampireLevel
      PlayerRef.AddSpell(VampireSpells[Index], abVerbose = False)
    Else
      PlayerRef.RemoveSpell(VampireSpells[Index])
    EndIf
  EndWhile

EndFunction

Function VampireRemoveLeveledSpells(Spell[] VampireSpells)
{
  Remove all spells from the given 1-indexed, ordered array.
}

  Int Index = VampireSpells.Length

  While Index > 1
    Index -= 1
    PlayerRef.RemoveSpell(VampireSpells[Index])
  EndWhile

EndFunction

Function VampireRemoveSpells(FormList VampireSpells)
{
  Remove all spells in the given Form List.
}

  Int Index = VampireSpells.GetSize()

  While Index
    Index -= 1
    PlayerRef.RemoveSpell(VampireSpells.GetAt(Index) as Spell)
  EndWhile

EndFunction

Function VampireImageSpaceModifier()
{
  Image space modifier for use during feeding and stage transitions.
}

  ((Self as Quest) as VampireCrossFade).Apply(VampireTransformDecreaseISMD)

EndFunction

Function VampirePlayChange()
{
  Play visuals on transformation into a vampire.
}

  VampireChangeFX.Play(PlayerRef)
  ((Self as Quest) as VampireCrossFade).Apply(VampireTransformIncreaseISMD)

  If !SoundMarkerRef.GetReference()
    SoundMarkerRef.ForceRefTo(PlayerRef.PlaceAtMe(XMarker))
  EndIf

  MAGVampireTransform01.Play(SoundMarkerRef.GetReference())
  VampireChangeFX.Stop(PlayerRef)

EndFunction

Function VampireAddCharmSpell()
{
  Add the appropriate leveled Vampire's Seduction spell to the player.
}

  VampireRemoveLeveledSpells(VampireCharmSpells)
  VampireAddLeveledSpell(VampireCharmSpells, Property_VampireRank)

EndFunction

Function VampireDisableMenu()
{
  Disable player access to menus.
}

  Game.SetInChargen(True, True, False)
  Game.DisablePlayerControls( \
      abMovement = False, \
      abFighting = False, \
      abCamSwitch = False, \
      abLooking = False, \
      abSneaking = False, \
      abMenu = True, \
      abActivate = False, \
      abJournalTabs = False)

EndFunction

Function VampireDisablePlayerControls()
{
  Disable player controls during transformation.
}

  Game.SetInChargen(True, True, False)
  Game.ForceThirdPerson()
  Game.DisablePlayerControls( \
      abMovement = True, \
      abFighting = True, \
      abCamSwitch = True, \
      abLooking = False, \
      abSneaking = True, \
      abMenu = True, \
      abActivate = True, \
      abJournalTabs = True)

EndFunction

Function VampireEnablePlayerControls()
{
  Enable player controls.
}

  Game.EnablePlayerControls()
  Game.SetInChargen(False, False, False)

EndFunction

Function VampireStartFeedTimer()
{
  Start the feed timer with the interval specified by FeedTimerUpdateInterval.
}

  VampireStopFeedTimer()
  RegisterForUpdateGameTime(FeedTimerUpdateInterval)

EndFunction

Function VampireStopFeedTimer()
{
  Stop the feed timer.
}

  UnregisterForUpdate()
  UnregisterForUpdateGameTime()

EndFunction
