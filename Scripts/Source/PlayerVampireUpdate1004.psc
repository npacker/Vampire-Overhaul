Scriptname PlayerVampireUpdate1004 extends PlayerVampireUpdate

Spell Property VampireInvisibilityPower Auto

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function Update(Actor PlayerRef, PlayerVampireQuestScript PlayerVampireQuest)

  If PlayerVampireQuest.VampireStatus == 1
    Spell SpellEquippedPower = PlayerRef.GetEquippedSpell(2)
    Spell InvisibilitySpell = PlayerVampireQuest.VampireInvisibilitySpells[PlayerVampireQuest.VampireRank]

    PlayerRef.RemoveSpell(VampireInvisibilityPower)
    PlayerRef.AddSpell(InvisibilitySpell, False)

    If SpellEquippedPower == VampireInvisibilityPower
      PlayerRef.EquipSpell(InvisibilitySpell, 2)
    EndIf
  Else
    PlayerRef.RemoveSpell(VampireInvisibilityPower)
  EndIf

EndFunction
