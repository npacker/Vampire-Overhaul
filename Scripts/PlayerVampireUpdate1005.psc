Scriptname PlayerVampireUpdate1005 extends PlayerVampireUpdate

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function Update(Actor PlayerRef, PlayerVampireQuestScript PlayerVampireQuest)

  PlayerRef.RemoveSpell(PlayerVampireQuest.AbVampireChillTouch)

EndFunction
