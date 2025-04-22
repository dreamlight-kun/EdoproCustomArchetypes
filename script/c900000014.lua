--Pâle du Joyeux Printemps / Joyous Spring Pale
local s,id=GetID()
function s.initial_effect(c)
	--Naming
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_CHANGE_CODE)
	e1:SetCode(EFFECT_TYPE_SINGLE)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetOperation(s.rename)
	c:RegisterEffect(e1)
	--SPSummon self when "joyous spring" card on field or controlling a level 8 or 3
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetCountLimit(1,id,EFFECT_COUNT_CODE_OATH)
	e2:SetCondition(s.spcond)
	e2:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	c:RegisterEffect(e2)
	--SPSummon from Deck level 8 FIRE Spellcaster
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetTarget(s.sptar)
	e3:SetTargetRange(LOCATION_DECK+LOCATION_GRAVE,0)
	e3:SetOperation(s.spd)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e5)
end
s.listed_series={0x902}
function s.spcfilter(c)
	return c:IsFaceup() and (c:GetLevel()==3 or c:GetLevel()==8 or c:IsSetCard(0x902) or c:Code()==14558127)
end
function s.spcond(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.spcfilter,tp,LOCATION_MZONE,0,1,nil)
end
function s.spdfilter(c)
	return c:GetRace()==RACE_SPELLCASTER and c:GetAttribute()==ATTRIBUTE_FIRE and c:GetLevel()==8
end
function s.sptar(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.spdfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function s.rename(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:Alias(14558127)
end
function s.spd(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.spdfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if #g>0 then
		Duel.SpecialSummon(g,SUMMON_TYPE_SPECIAL,tp,tp,false,false,POS_FACEUP)
	end
end
