Scriptname PlayerVampireUpdate1000 extends PlayerVampireUpdate

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Spell Property AbVampireSkills Auto
{ Vanilla Champion of the Night. }

Spell Property AbVampireSkills02 Auto
{ Vanilla Nightstalker's Footsteps. }

Spell Property VampireStrength01 Auto
{ Vanilla Stage 1 Vampire Strength spell. }

Spell Property VampireStrength02 Auto
{ Vanilla Stage 1 Vampire Strength spell. }

Spell Property VampireStrength03 Auto
{ Vanilla Stage 1 Vampire Strength spell. }

Spell Property VampireStrength04 Auto
{ Vanilla Stage 1 Vampire Strength spell. }

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function Update(Actor PlayerRef, PlayerVampireQuestScript PlayerVampireQuest)

  PlayerRef.RemoveSpell(AbVampireSkills)
  PlayerRef.RemoveSpell(AbVampireSkills02)
  PlayerRef.RemoveSpell(VampireStrength01)
  PlayerRef.RemoveSpell(VampireStrength02)
  PlayerRef.RemoveSpell(VampireStrength03)
  PlayerRef.RemoveSpell(VampireStrength04)

EndFunction
