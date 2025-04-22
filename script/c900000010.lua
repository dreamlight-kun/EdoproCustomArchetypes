--Grandes Couleurs pour un Joyeux Printemps / Many Colours for a Joyous Spring
local s,id=GetID()
function s.initial_effect(c)
	Synchro.AddProcedure(c,s.tfilter,1,1,s.ntfilter,1,1)
end
function s.tfilter(c)
	return (c:IsSetCard(0x902) or Card.GetCode(c)==14558127) and c:IsType(TYPE_TUNER)
end
function s.ntfilter(c)
	return c:IsSetCard(0x902) or Card.GetCode(c)==14558127
end
