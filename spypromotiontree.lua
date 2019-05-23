function GetUnit(playerId, unitId)
	return Players[playerId]:GetUnits():FindID(unitId);
end

function GrantPromotion(playerId, unitId, experience)
	local unit = GetUnit(playerId, unitId);
	unit:GetExperience():ChangeExperience(experience);
end

ExposedMembers.SPT_GrantPromotion = GrantPromotion;