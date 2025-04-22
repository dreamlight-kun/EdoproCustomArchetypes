--Lumière du Joyeux Printemps / Joyous Spring Light
local s,id=GetID()
function s.initial_effect(c)
	Link.AddProcedure(c,s.mtfilter,2,2)
end
s.listed_series={0x902}
function s.mtfilter(c)
	return (c:IsSetCard(0x902) or Card.GetCode(c)==14558127) or (c:IsRace(RACE_SPELLCASTER))
end