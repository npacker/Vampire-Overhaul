Scriptname DLC1VampireAmuletGargoyleScript extends ObjectReference

GlobalVariable Property DLC1nVampireNecklaceGargoyle Auto

Spell Property SummonGargoyle Auto

Static Property XMarker Auto

Actor Property PlayerRef Auto

ObjectReference CastTarget

Bool Done = False

Event OnLoad()

  If DLC1nVampireNecklaceGargoyle.GetValue() == 1 && !Done
    Done = True
    CastTarget = Self.PlaceAtMe(XMarker)

    SummonGargoyle.RemoteCast(PlayerRef, PlayerRef, CastTarget)
    CastTarget.Disable()
    CastTarget.Delete()
  EndIf

EndEvent

Event OnUnload()

  If CastTarget != None
    CastTarget.Disable()
    CastTarget.Delete()
  EndIf

EndEvent
