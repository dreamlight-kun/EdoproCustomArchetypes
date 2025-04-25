--Bleue du Joyeux Printemps / Joyous Spring Blue 
local s,id=GetID()
function s.initial_effect(c)
	--Naming
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetValue(9000000001)
	c:RegisterEffect(e1)
end
