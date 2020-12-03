Scriptname PlayerVampireUpdate1003 extends PlayerVampireUpdate

Spell Property VampireInvisibilityPower Auto
{ New Embrace of Shadows. }

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function Update(Actor PlayerRef, PlayerVampireQuestScript PlayerVampireQuest)

  If PlayerVampireQuest.VampireStatus == 1
    Spell SpellEquippedLeft = PlayerRef.GetEquippedSpell(0)
    Spell SpellEquippedRight = PlayerRef.GetEquippedSpell(1)
    Spell InvisibilitySpell = PlayerVampireQuest.VampireInvisibilitySpells[PlayerVampireQuest.VampireRank]

    PlayerRef.RemoveSpell(InvisibilitySpell)
    PlayerRef.AddSpell(VampireInvisibilityPower)

    If SpellEquippedLeft == InvisibilitySpell || SpellEquippedRight == InvisibilitySpell
      PlayerRef.EquipSpell(VampireInvisibilityPower, 2)
    EndIf
  Else
    PlayerRef.RemoveSpell(VampireInvisibilityPower)
  EndIf

EndFunction
