--Grand Sakura du Joyeux Printemps / Joyous Spring Sakura
local s,id=GetID()
function s.initial_effect(c)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_ACTIVATE)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetCountLimit(1,id)
	c:RegisterEffect(e4)
	--Effect to apply
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(s.ptar)
	--Applying the effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e1:SetRange(LOCATION_FZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(s.ptar)
	e1:SetLabelObject(e2)
	c:RegisterEffect(e1)
	--Quick effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCode(EVENT_CHAIN_ACTIVATING)
	e3:SetCountLimit(1)
	e3:SetTarget(s.gtar)
	e3:SetCondition(s.cond)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_GRAVE,LOCATION_GRAVE)
	e3:SetOperation(s.activate)
	c:RegisterEffect(e3)
end
s.listed_series={0x902}
function s.ptar(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.pfilter,tp,LOCATION_MZONE,0,1,nil) end
end
function s.ptfilter(c)
	return (c:IsSetCard(0x902) or c:GetCode()==14558127) and c:IsFaceup() and c:IsActiveType(TYPE_MONSTER)
end
function s.cond(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.gfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil)
end
function s.gtar()
	if chk==O then return Duel.IsExistingMatchingCard(s.gfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil)
end
function s.gfilter(c)
	return c:IsSetCard(0x902) or c:GetCode()==14558127
end
function s.efilter(e,te,c)
	return te:IsActiveType(TYPE_MONSTER) and te:GetOwner()~=c and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELECT)
	local g=Duel.SelectMatchingCard(tp,s.gfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil)
	if #g>0 then
		local tohand=Duel.SelectYesNo(tp,HINTMSG_ATOHAND)
		if tohand then
			e:SetCategory(CATEGORY_LEAVE_GRAVE)
			Duel.SendtoHand(g,tp,REASON_EFFECT)
		else
			local chain=Duel.GetCurrentChain()
			if chain>=0 then
				e:SetCategory(CATEGORY_REMOVE)
				Duel.NegateEffect(chain-1)
				Duel.Remove(g,nil,REASON_EFFECT)
			end
		end
	end
end
end