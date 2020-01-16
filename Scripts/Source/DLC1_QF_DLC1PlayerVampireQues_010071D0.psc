;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 14
Scriptname DLC1_QF_DLC1PlayerVampireQues_010071D0 Extends Quest Hidden

;BEGIN ALIAS PROPERTY PlayerMistform
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerMistform Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerReflexes
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerReflexes Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerBats
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerBats Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN AUTOCAST TYPE DLC1PlayerVampireChangeScript
Quest __temp = self as Quest
DLC1PlayerVampireChangeScript kmyQuest = __temp as DLC1PlayerVampireChangeScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.InitialShift()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE DLC1PlayerVampireChangeScript
Quest __temp = self as Quest
DLC1PlayerVampireChangeScript kmyQuest = __temp as DLC1PlayerVampireChangeScript
;END AUTOCAST
;BEGIN CODE
; normal vamping around
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN AUTOCAST TYPE DLC1PlayerVampireChangeScript
Quest __temp = self as Quest
DLC1PlayerVampireChangeScript kmyQuest = __temp as DLC1PlayerVampireChangeScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.PrepShift()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN AUTOCAST TYPE DLC1PlayerVampireChangeScript
Quest __temp = self as Quest
DLC1PlayerVampireChangeScript kmyQuest = __temp as DLC1PlayerVampireChangeScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.Shutdown()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE DLC1PlayerVampireChangeScript
Quest __temp = self as Quest
DLC1PlayerVampireChangeScript kmyQuest = __temp as DLC1PlayerVampireChangeScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.ShiftBack()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
