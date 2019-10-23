Scriptname DLC1VQ02HarkonScript extends ReferenceAlias
{ Script on DLC1VQ02 Harkon Alias. }

Event OnRaceSwitchComplete()

  ; Assumes the first time he transforms is to set this stage.
  If !GetOwningQuest().GetStageDone(15)
    ; Causes Harkon to forcegreet the player.
    GetOwningQuest().SetStage(15)
    (Self.GetReference() as Actor).EvaluatePackage()
  EndIf

EndEvent
