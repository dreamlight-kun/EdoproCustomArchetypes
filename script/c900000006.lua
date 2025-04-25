--Bleue du Joyeux Printemps / Joyous Spring Blue 
local s,id=GetID()
function s.initial_effect(c)
	--Naming
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetValue(9000000001)
	c:RegisterEffect(e1)
	--Draw 1
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetCost(Cost.RevealSelf)
	e2:SetCondition(s.drcond)
	e2:SetTarget(s.drtg)
	e2:SetOperation(s.dr)
	c:RegisterEffect(e2)
	--SPSuumon itself
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCost(s.discard)
	e3:SetTarget(s.sptg)
	e3:SteOperation(s.spop)
	c:RegisterEffect(e3)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function s.dr(e,tp,eg,ep,ev,re,r,rp)





