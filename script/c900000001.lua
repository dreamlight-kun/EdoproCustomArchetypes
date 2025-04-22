--Blanche du Joyeux Printemps / Joyous Spring White
local s,id=GetID()
function s.initial_effect(c)
	-- search function
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.target1)
	e1:SetCondition(s.condition1)
	e1:SetOperation(s.activate1)
	-- spsummon self from gy or hand if "joyous spring" in gy
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetCountLimit(1,id,EFFECT_COUNT_CODE_OATH)
	e2:SetCondition(s.condition2)
	e2:SetRange(LOCATION_GRAVE+LOCATION_HAND)
	c:RegisterEffect(e1)
	c:RegisterEffect(e2)
	
end
s.listed_series={0x902}
function s.condition1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_DECK,0,1,nil)
end

function s.cfilter(c)
	return c:IsSetCard(0x902) and c:IsType(TYPE_EFFECT) and Card.GetLevel(c)>=4 and c:IsAbleToGrave() and not c:IsType(TYPE_RITUAL)
end

function s.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetTargetPlayer(tp)
end

function s.activate1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELECT)
	local g=Duel.SelectMatchingCard(tp,s.cfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		local tohand=Duel.SelectYesNo(tp,HINTMSG_ATOHAND)
		if tohand then
			Duel.SendtoHand(g,tp,REASON_EFFECT)
		else
			Duel.SendtoGrave(g,REASON_EFFECT)
		end
	end
end

function s.cfilter2(c)
	return c:IsSetCard(0x902) or Card.GetCode(c)==14558127
end

function s.condition2(e,c)
	if c==nil then return true end
	local tp=e:GetHandlerPlayer()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(s.cfilter2,tp,LOCATION_GRAVE,0,1,c)
end




