Scriptname PlayerVampireUpdateControllerScript extends Quest

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Actor Property PlayerRef Auto
{ The player. }

PlayerVampireQuestScript Property PlayerVampireQuest Auto
{ The Player Vampire Quest. }

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Int CurrentVersion = 1003

Int InstalledVersion

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnInit()

  Update()

EndEvent

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function Update()

  If InstalledVersion < 1000
    ; Remove vanilla vampire abilities.
    ((Self as Quest) as PlayerVampireUpdate1000).Update(PlayerRef, PlayerVampireQuest)
  EndIf

  If InstalledVersion < 1001
    ; Update Embrace of Shadows.
    ; ((Self as Quest) as PlayerVampireUpdate1001).Update(PlayerRef, PlayerVampireQuest)
  EndIf

  If InstalledVersion < 1002
    ; Add player to summoned gargoyle faction.
    ((Self as Quest) as PlayerVampireUpdate1002).Update(PlayerRef, PlayerVampireQuest)
  EndIf

  If InstalledVersion < 1003
    ; Update Embrace of Shadows.
    ((Self as Quest) as PlayerVampireUpdate1003).Update(PlayerRef, PlayerVampireQuest)
  EndIf

  InstalledVersion = CurrentVersion

EndFunction
