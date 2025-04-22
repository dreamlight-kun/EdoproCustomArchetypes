--Déité lunaire du Joyeux Printemps / Joyous Spring Moon Deity
local s,id=GetID()
function s.initial_effect(c)
	Xyz.AddProcedure(c,nil,8,2,s.mataltfilter,0,6)
end
s.listed_series={0x902}
function s.matfilter(c)
	return c:IsFaceup() and c:GetLevel()==8
end

function s.mataltfilter(c)
	return c:IsSetCard(0x902) and (c:IsType(TYPE_RITUAL) or c:IsType(TYPE_FUSION) or c:IsType(TYPE_LINK) or c:IsType(TYPE_XYZ) or c:IsType(TYPE_SYNCHRO)) and  not (c:GetCode()==s)
end