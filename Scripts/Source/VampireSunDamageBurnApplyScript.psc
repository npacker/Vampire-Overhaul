Scriptname VampireSunDamageBurnApplyScript extends ActiveMagicEffect

Spell Property VampireSunDamageBurn Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

  akTarget.AddSpell(VampireSunDamageBurn, False)

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

  akTarget.DispelSpell(VampiresunDamageBurn)

Endevent