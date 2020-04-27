Scriptname PlayerVampireUpdate1001 extends PlayerVampireUpdate

Spell Property VampireInvisibilityPC Auto
{ Vanilla Embrace of Shadows. }

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

    PlayerRef.RemoveSpell(VampireInvisibilityPC)

    If !PlayerRef.HasSpell(InvisibilitySpell)
      PlayerRef.AddSpell(InvisibilitySpell, False)
    EndIf

    If SpellEquippedLeft == VampireInvisibilityPC
      PlayerRef.EquipSpell(InvisibilitySpell, 0)
    EndIf

    If SpellEquippedRight == VampireInvisibilityPC
      PlayerRef.EquipSpell(InvisibilitySpell, 1)
    EndIf
  Else
    PlayerRef.RemoveSpell(VampireInvisibilityPC)
  EndIf

EndFunction
