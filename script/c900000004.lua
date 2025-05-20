--Blanche et Noire sous le Joyeux Printemps / Black and White under the Joyous Spring
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_ACTIVATE)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetCountLimit(1,id)
	e4:SetCondition(s.cond)
	e4:SetTarget(s.target)
	c:RegisterEffect(e4)
end
function s.bwfilter(c)
	return c:IsCode(900000001) or c:IsCode(900000002)
end
function s.tarbw(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.bwfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil) end
	Duel.SetTargetPlayer(tp)
end
function s.condnomon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function s.nomon(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return s.condnomon(e,tp,eg,ep,ev,re,r,rp) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(9,CATEGORY_SPECIAL_SUMMON,s.tarbw,1,tp,1)
end
function s.wfilter(c)
	return c:IsCode(900000001)
end
function s.bfilter(c)
	return c:IsCode(900000002)
end
function s.bwonfield(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.bfilter,tp,LOCATION_MZONE,0,1,nil) and Duel.IsExistingMatchingCard(s.wfilter,tp,LOCATION_MZONE,0,1,nil)
end
function s.condbw(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.bwfilter,tp,LOCATION_MZONE,0,1,nil)
end
function s.cond(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0 or Duel.IsExistingMatchingCard(s.bwfilter,tp,LOCATION_MZONE,0,1,nil)
end
function s.activatenomon(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELECT)
	local g=Duel.SelectMatchingCard(tp,s.bwfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil)
	if #g>0 then
		Duel.SpecialSummon(g,SUMMON_TYPE_SPECIAL,tp,tp,false,false,POS_FACEUP)
	end
end

function s.bonfield(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.bfilter,tp,LOCATION_MZONE,0,1,nil)
end
function s.wonfield(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.wfilter,tp,LOCATION_MZONE,0,1,nil)
end

function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=s.nomon(e,tp,eg,ep,ev,re,r,rp,0)
	local b2=s.drtg(e,tp,eg,ep,ev,re,r,rp,0) and s.wonfield(e,tp,eg,ep,ev,re,r,rp)
	local b3=s.tarban(e,tp,eg,ep,ev,re,r,rp,0) and s.bonfield(e,tp,eg,ep,ev,re,r,rp)
	local eta
	if b1 then eta=0  
	elseif b2 and not b3 then eta=1 
	elseif not b2 and b3 then eta=2
	elseif b2 and b3 then eta=3
	if chk==0 then return eta end
	end
	if s.condnomon(e,tp,eg,ep,ev,re,r,rp)==0 and b1 and eta==0 then
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e:SetProperty(0)
		e:SetOperation(s.activatenomon)
		s.nomon(e,tp,eg,ep,ev,re,r,rp,1)
	end
	if eta==3 then
		local op=Duel.SelectEffect(tp,
			{b2,aux.Stringid(id,0)},
			{b3,aux.Stringid(id,1)})
		if op==1 then
			e:SetCategory(CATEGORY_DRAW)
			e:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e:SetOperation(s.draw)
			s.drtg(e,tp,eg,ep,ev,re,r,rp,1)
		elseif op==2 then
			e:SetCategory(CATEGORY_REMOVE)
			e:SetProperty(0)
			e:SetOperation(s.ban)
			s.tarban(e,tp,eg,ep,ev,re,r,rp,1)
		end
	elseif eta=1 then
		e:SetCategory(CATEGORY_DRAW)
		e:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e:SetOperation(s.draw)
		s.drtg(e,tp,eg,ep,ev,re,r,rp,1)
	elseif eta=2 then
		e:SetCategory(CATEGORY_REMOVE)
		e:SetProperty(0)
		e:SetOperation(s.ban)
		s.tarban(e,tp,eg,ep,ev,re,r,rp,1)
	end
end
function s.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function s.draw(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function s.tarban(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_HAND)
end
function s.ban(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_HAND,nil)
	if #g==0 then return end
	local rg=g:RandomSelect(tp,1)
	local tc=rg:GetFirst()
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end


