Scriptname VampireNormalProgression extends VampireProgression

Function ProvisionAbilities(PlayerVampireQuestScript PlayerVampireQuest)
  Actor PlayerRef = PlayerVampireQuest.PlayerRef
  int VampireStatus = PlayerVampireQuest.VampireStatus
  int VampireRank = PlayerVampireQuest.VampireRank

  If VampireStatus == 1
    PlayerVampireQuest.VampireAddLeveledSpell(PlayerVampireQuest.VampireRaiseThrallSpells, VampireRank)
    PlayerRef.RemoveSpell(PlayerVampireQuest.VampireMesmerizingGaze)
    PlayerVampireQuest.VampireRemoveLeveledSpells(PlayerVampireQuest.VampireInvisibilitySpells)
  ElseIf VampireStatus == 2
    PlayerRef.AddSpell(PlayerVampireQuest.VampireMesmerizingGaze, False)
    PlayerVampireQuest.VampireAddLeveledSpell(PlayerVampireQuest.VampireRaiseThrallSpells, VampireRank)
    PlayerVampireQuest.VampireRemoveLeveledSpells(PlayerVampireQuest.VampireInvisibilitySpells)
  ElseIf VampireStatus == 3
    PlayerRef.AddSpell(PlayerVampireQuest.VampireMesmerizingGaze, False)
    PlayerVampireQuest.VampireAddLeveledSpell(PlayerVampireQuest.VampireRaiseThrallSpells, VampireRank)
    PlayerVampireQuest.VampireRemoveLeveledSpells(PlayerVampireQuest.VampireInvisibilitySpells)
  ElseIf VampireStatus == 4
    PlayerRef.AddSpell(PlayerVampireQuest.VampireMesmerizingGaze, False)
    PlayerVampireQuest.VampireAddLeveledSpell(PlayerVampireQuest.VampireRaiseThrallSpells, VampireRank)
    PlayerVampireQuest.VampireAddLeveledSpell(PlayerVampireQuest.VampireInvisibilitySpells, VampireRank)
  EndIf

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
  PlayerRef.RemoveSpell(PlayerVampireQuest.VampireFeralVisage)
endFunction
