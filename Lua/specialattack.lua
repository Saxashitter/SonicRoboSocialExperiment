--By MrBrick
--this script makes it so every time you start or stop holding buttons,
--there is a chance to get ambushed by a special enemy
freeslot('sfx_spatk1', 'sfx_spatk2')

addHook('PreThinkFrame', function()
	for p in players.iterate do
		--bunch of checks, sorry if it looks ugly!!
		if not (p and p.valid and p.oldbuttons != nil) then continue end
		if p.oldbuttons == p.cmd.buttons then continue end
		if not P_RandomChance(FU/66) then continue end
		if not (p.mo and p.mo.valid) then continue end
		if p.playerstate == PST_DEAD then continue end
		
		--as you know, my daughter has a very special attack
		p.specialattack = TICRATE*2
		S_StartSound(p.mo, sfx_spatk1)
	end
end)

--special attack logic
addHook('PlayerThink', function(p)
	if not (p and p.valid and p.mo and p.mo.valid) then return end
	if p.specialattack
		p.mo.momx = 0
		p.mo.momy = 0
		p.mo.momz = 0
		if p.specialattack == 1
			P_KillMobj(p.mo)
			S_StartSound(p.mo, sfx_spatk2)
		end
		p.specialattack = $-1
	end
end)
--special attack hud
hud.add(function(v, p)
	if not (p and p.valid and p.specialattack) then return end
	v.drawFill(0,0,320,200,31)
	v.drawScaled(107*FU,90*FU,FU/8,v.cachePatch('SPATTACK'))
end)

addHook('PostThinkFrame', function() --save this tics buttons for next tic
	for p in players.iterate do
		if not (p and p.valid) then continue end
		p.oldbuttons = p.cmd.buttons
	end
end)
