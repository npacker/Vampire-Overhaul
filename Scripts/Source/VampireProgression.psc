Scriptname VampireProgression extends Quest Hidden
{
  Base script for implementing vampire progression types. New Progression types
  can extend this script to show up in the properties editor on the
  PlayerVampireQuestScript in the PlayerVampireQuest.
}

Function ProvisionAbilities(PlayerVampireQuestScript PlayerVampireQuest)
{
  Function signature for provisioning vampire abilities. Called from
  PlayerVampireQuestScript.VampireProgression.
}
endFunction

Function RemoveAbilities(PlayerVampireQuestScript PlayerVampireQuest)
{
  Function signature for removing vampire abilities provisioned in
  ProvisionAbilities() above. Called from PlayerVampireQuestScript.Vampirecure.
}
  Actor PlayerRef = PlayerVampireQuest.PlayerRef

  PlayerRef.RemoveSpell(PlayerVampireQuest.AbVampireChillTouch)
  PlayerRef.RemoveSpell(PlayerVampireQuest.DLC1VampireChange)
  PlayerRef.RemoveSpell(PlayerVampireQuest.VampireBloodMemory)
  PlayerRef.RemoveSpell(PlayerVampireQuest.VampireChampionOfTheNight)
  PlayerRef.RemoveSpell(PlayerVampireQuest.VampireMesmerizingGaze)
  PlayerRef.RemoveSpell(PlayerVampireQuest.VampireNightstalker)
  PlayerVampireQuest.VampireRemoveLeveledSpells(PlayerVampireQuest.AbVampireRankSpells)
  PlayerVampireQuest.VampireRemoveLeveledSpells(PlayerVampireQuest.AbVampireResistanceSpells)
  PlayerVampireQuest.VampireRemoveLeveledSpells(PlayerVampireQuest.AbVampireStageSpells)
  PlayerVampireQuest.VampireRemoveLeveledSpells(PlayerVampireQuest.AbVampireWeaknessSpells)
  PlayerVampireQuest.VampireRemoveLeveledSpells(PlayerVampireQuest.VampireCharmSpells)
  PlayerVampireQuest.VampireRemoveLeveledSpells(PlayerVampireQuest.VampireClawsSpells)
  PlayerVampireQuest.VampireRemoveLeveledSpells(PlayerVampireQuest.VampireDrainSpells)
  PlayerVampireQuest.VampireRemoveLeveledSpells(PlayerVampireQuest.VampireInvisibilitySpells)
  PlayerVampireQuest.VampireRemoveLeveledSpells(PlayerVampireQuest.VampireRaiseThrallSpells)
  PlayerVampireQuest.VampireRemoveLeveledSpells(PlayerVampireQuest.VampireSunDamageSpells)
endFunction
