--Noire du Joyeux Printemps / Joyous Spring Black
local s,id=GetID()
function s.initial_effect(c)
	--SPSummon self when an effect is negated 
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetCountLimit(1,id,EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(s.spcon1)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	-- SPSummon self when "joyous spring" on field
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetRange(LOCATION_HAND)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetCountLimit(1,id,EFFECT_COUNT_CODE_OATH)
	e2:SetCondition(s.spcon2)
	c:RegisterEffect(e1)
	c:RegisterEffect(e2)
end
s.listed_series={0x902}
function s.spcon1(e,c)
	if c==nil then return true end
	local tp=e:GetHandlerPlayer()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_MZONE,0,1,c)
end
function s.cfilter(c)
	return c:IsFaceup() and (c:IsSetCard(0x902) or c:GetCode()==14558127)
end
function s.spfilter(c)
	return c:IsFaceup() and c:IsDisabled()
end
function s.spcon2(e,c)
	if c==nil then return true end
	local tp=e:GetHandlerPlayer()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_MZONE,0,1,nil)
end