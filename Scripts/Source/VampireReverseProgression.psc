Scriptname VampireReverseProgression extends VampireProgression

Function ProvisionAbilities()
  PlayerVampireQuestScript PlayerVampireQuest = (self as Quest) as PlayerVampireQuestScript
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
endFunction
