;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname DLC1_TIF__01003BA1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
DLC1VQ02HarkonGreet.SetValue(1)
DLC1VQ02HarkonBitesPlayer.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DLC1VampireTurnScript Property DLC1VampireTurn Auto

GlobalVariable Property DLC1HarkonNoActivation Auto

Scene Property DLC1VQ02HarkonBitesPlayer Auto

GlobalVariable Property DLC1VQ02HarkonGreet Auto
