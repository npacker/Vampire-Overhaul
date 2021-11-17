Scriptname VampireReverseProgression extends VampireProgression

Function ProvisionAbilities(PlayerVampireQuestScript PlayerVampireQuest)
  Actor PlayerRef = PlayerVampireQuest.PlayerRef
  int VampireStatus = PlayerVampireQuest.VampireStatus
  int VampireRank = PlayerVampireQuest.VampireRank

  If VampireStatus == 1
    PlayerRef.AddSpell(PlayerVampireQuest.VampireMesmerizingGaze, False)
    PlayerVampireQuest.VampireAddLeveledSpell(PlayerVampireQuest.VampireInvisibilitySpells, VampireRank)
    PlayerVampireQuest.VampireAddLeveledSpell(PlayerVampireQuest.VampireRaiseThrallSpells, VampireRank)
    PlayerRef.RemoveSpell(PlayerVampireQuest.VampireFeralVisage)
  ElseIf VampireStatus == 2
    PlayerRef.AddSpell(PlayerVampireQuest.VampireMesmerizingGaze, False)
    PlayerVampireQuest.VampireAddLeveledSpell(PlayerVampireQuest.VampireRaiseThrallSpells, VampireRank)
    PlayerRef.RemoveSpell(PlayerVampireQuest.VampireFeralVisage)
    PlayerVampireQuest.VampireRemoveLeveledSpells(PlayerVampireQuest.VampireInvisibilitySpells)
  ElseIf VampireStatus == 3
    PlayerRef.AddSpell(PlayerVampireQuest.VampireMesmerizingGaze, False)
    PlayerRef.RemoveSpell(PlayerVampireQuest.VampireFeralVisage)
    PlayerVampireQuest.VampireRemoveLeveledSpells(PlayerVampireQuest.VampireInvisibilitySpells)
    PlayerVampireQuest.VampireRemoveLeveledSpells(PlayerVampireQuest.VampireRaiseThrallSpells)
  ElseIf VampireStatus == 4
    PlayerRef.AddSpell(PlayerVampireQuest.VampireFeralVisage, False)
    PlayerRef.RemoveSpell(PlayerVampireQuest.VampireMesmerizingGaze)
    PlayerVampireQuest.VampireRemoveLeveledSpells(PlayerVampireQuest.VampireInvisibilitySpells)
    PlayerVampireQuest.VampireRemoveLeveledSpells(PlayerVampireQuest.VampireRaiseThrallSpells)
  EndIf

  PlayerRef.AddSpell(PlayerVampireQuest.AbVampireChillTouch, False)
  PlayerRef.AddSpell(PlayerVampireQuest.VampireBloodMemory, False)
  PlayerRef.AddSpell(PlayerVampireQuest.VampireChampionOfTheNight, False)
  PlayerRef.AddSpell(PlayerVampireQuest.VampireNightstalker, False)
  PlayerVampireQuest.VampireAddLeveledSpell(PlayerVampireQuest.VampireCharmSpells, VampireRank)
  PlayerVampireQuest.VampireAddLeveledSpell(PlayerVampireQuest.VampireDrainSpells, VampireRank)
  PlayerVampireQuest.VampireAddLeveledAbility(PlayerVampireQuest.AbVampireRankSpells, VampireRank)
  PlayerVampireQuest.VampireAddLeveledAbility(PlayerVampireQuest.VampireClawsSpells, VampireRank)
  PlayerVampireQuest.VampireAddLeveledAbility(PlayerVampireQuest.AbVampireResistanceSpells, 5 - VampireStatus)
  PlayerVampireQuest.VampireAddLeveledAbility(PlayerVampireQuest.AbVampireStageSpells, VampireStatus)
  PlayerVampireQuest.VampireAddLeveledAbility(PlayerVampireQuest.AbVampireWeaknessSpells, VampireStatus)
  PlayerVampireQuest.VampireAddLeveledAbility(PlayerVampireQuest.VampireSunDamageSpells, VampireStatus)
endFunction
