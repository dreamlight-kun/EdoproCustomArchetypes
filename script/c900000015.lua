--Lumière du Joyeux Printemps / Joyous Spring Light
local s,id=GetID()
function s.initial_effect(c)
	Link.AddProcedure(c,s.mtfilter,2,2)
	--Reborn
	local e1:Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetTargetRange(LOCATION_GRAVE,0)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,id,EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(s.cond)
	e1:SetTarget(s.tar)
	e1:SetOperation(s.act)
	c:RegisterEffect(e1)
end
s.listed_series={0x902}
function s.mtfilter(c)
	return (c:IsSetCard(0x902) or Card.GetCode(c)==14558127) or (c:IsRace(RACE_SPELLCASTER))
end
function s.tgfilter(c)
	return c:IsRace(RACE_SPELLCASTER) and c:IsAttribute(ATTRIBUTE_FIRE)
end

function s.cond(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLinkSummoned() and Duel.IsExistingMatchingCard(s.tgfilter,tp,LOCATION_GRAVE,0,1,nil)
end

function s.tar(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.tgfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,1)
end

function s.act(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,s.tgfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
	end
end