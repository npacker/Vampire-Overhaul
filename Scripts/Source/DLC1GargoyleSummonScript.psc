Scriptname DLC1GargoyleSummonScript extends Actor

Actor Property PlayerRef Auto

Event OnLoad()

  Self.SetRelationshipRank(PlayerRef, 3)
  Self.IgnoreFriendlyHits(true)

EndEvent
