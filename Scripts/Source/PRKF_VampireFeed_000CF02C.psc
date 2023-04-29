;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 32
Scriptname PRKF_VampireFeed_000CF02C Extends Perk Hidden

;BEGIN FRAGMENT Fragment_24
Function Fragment_24(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
PlayerVampireFeedController.HandleSleepingBiteRight(akTargetRef as Actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_21
Function Fragment_21(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
PlayerVampireFeedController.HandleSleepingBiteLeft(akTargetRef as Actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
PlayerVampireFeedController.HandleCombatBite(akTargetRef as Actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
PlayerVampireFeedController.HandleBite(akTargetRef as Actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
PlayerVampireFeedController.HandleFeed(akTargetRef as Actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
PlayerVampireFeedController.HandleFeed(akTargetRef as Actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_30
Function Fragment_30(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
PlayerVampireFeedController.HandleSleepingFeed(akTargetRef as Actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
PlayerVampireFeedController.HandleSleepingFeedLeft(akTargetRef as Actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
PlayerVampireFeedController.HandleBite(akTargetRef as Actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_26
Function Fragment_26(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
PlayerVampireFeedController.HandleSleepingFeedRight(akTargetRef as Actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
PlayerVampireFeedController.HandleCombatFeed(akTargetRef as Actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_28
Function Fragment_28(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
PlayerVampireFeedController.HandleSleepingBite(akTargetRef as Actor)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PlayerVampireFeedControllerScript Property PlayerVampireFeedController Auto
