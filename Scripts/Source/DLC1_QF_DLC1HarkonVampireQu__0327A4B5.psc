;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 16
Scriptname DLC1_QF_DLC1HarkonVampireQu__0327A4B5 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Harkon
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Harkon Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN AUTOCAST TYPE DLC1HarkonVampireChangeScript
Quest __temp = self as Quest
DLC1HarkonVampireChangeScript kmyQuest = __temp as DLC1HarkonVampireChangeScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.Revert()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN AUTOCAST TYPE DLC1HarkonVampireChangeScript
Quest __temp = self as Quest
DLC1HarkonVampireChangeScript kmyQuest = __temp as DLC1HarkonVampireChangeScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.Transform()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Perk Property WerewolfFeedPerk  Auto  

Perk Property DLC1PlayerWerewolfSavageFeeding  Auto  
