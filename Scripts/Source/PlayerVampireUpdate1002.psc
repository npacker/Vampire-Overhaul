Scriptname PlayerVampireUpdate1002 extends PlayerVampireUpdate

Faction Property DLC1SummonedGargoyleFaction Auto
{ Faction for player-summoned gargoyles. }

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function Update(Actor PlayerRef, PlayerVampireQuestScript PlayerVampireQuest)

  PlayerRef.AddToFaction(DLC1SummonedGargoyleFaction)

EndFunction
