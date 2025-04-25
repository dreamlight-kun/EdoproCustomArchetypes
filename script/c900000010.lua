--Grandes Couleurs pour un Joyeux Printemps / Many Colours for a Joyous Spring
local s,id=GetID()
function s.initial_effect(c)
	Synchro.AddProcedure(c,s.tfilter,1,1,s.ntfilter,1,1)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(s.drtr)
	e1:SetCondition(s.drcond)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetOperation(s.dr)
	c:RegisterEffect(e1)
	--limit summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e2:SetCondition(s.nspcond)
	e2:SetTarget(s.sumlimit)
	e2:SetValue(1,1)
	c:RegisterEffect(e2)
	--limit attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ATTACK)
	e3:SetCondition(s.noatkcond)
	c:RegisterEffect(e3)
end
function s.tfilter(c)
	return (c:IsSetCard(0x902) or Card.GetCode(c)==14558127) and c:IsType(TYPE_TUNER)
end
function s.ntfilter(c)
	return c:IsSetCard(0x902) or Card.GetCode(c)==14558127
end
function s.sumfilter(c)
	return c:IsSetCard(0x902) or c:IsAttribute(ATTRIBUTE_FIRE)
end
function s.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return s.sumfilter(c)
end
function s.noatkcond(e,tp,eg,ev,ep,re,r,rp)
	return Duel.IsExistingMatchingCard(s.ntfilter,tp,LOCATION_MZONE,0,1,e:GetHandler():GetCode())
end
