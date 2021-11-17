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

  PlayerRef.RemoveSpell(PlayerVampireQuest.VampireFeralVisage)
endFunction
