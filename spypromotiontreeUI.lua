spyPromotingUnits = {};

function GetUnit(playerId, unitId)
	return Players[playerId]:GetUnits():FindID(unitId);
end

function SPT_CheckSpyPromotion(playerId, unitId)
	local playerList = spyPromotingUnits[playerId];
	if (not playerList or not playerList[unitId]) then
		return;
	end
	
	local unit = Players[playerId]:GetUnits():FindID(unitId);
	local level = unit:GetExperience():GetLevel();
	
	local expectedLevel = 3;
	if (playerList["addOneMore"]) then
		expectedLevel = expectedLevel + 1;
	end
	
	if (level < expectedLevel) then
		latestUnit = unit;
	
		local nextXP = unit:GetExperience():GetExperienceForNextLevel();
		ExposedMembers.SPT_GrantPromotion(playerId, unitId, nextXP + 1);
	else
		spyPromotingUnits[playerId][unitId] = nil;
	end
end

function SPT_CheckSpiesPromotion(playerId)
	local units = Players[playerId]:GetUnits();
	
	for k, unit in units:Members() do
		SPT_CheckSpyPromotion(playerId, unit:GetID());
	end
end

function SPT_UnitCreated(playerId, unitId)
	-- Get the unit & its info
	local player = Players[playerId];
	local unit = player:GetUnits():FindID(unitId);
	local unitType = GameInfo.Units[unit:GetType()];
	
	if (unitType.UnitType == "UNIT_SPY") then
		-- Check if they have the modifier
		local modifiers = GameEffects.GetModifiers();
		for k, v in pairs(modifiers) do
			local definition = GameEffects.GetModifierDefinition(v);
			if (definition.Id == "FUTURE_COUNTER_SCIENCE_SPY_GRANT_TWO_PROMOTIONS") then
				local owner = GameEffects.GetModifierOwner(v);
				local owningPlayerId = GameEffects.GetObjectsPlayerId(owner);
				
				if (owningPlayerId == playerId) then
					-- Add the unit to the management list
					local playerList = spyPromotingUnits[playerId];
					
					if (not playerList) then
						playerList = {};
						spyPromotingUnits[playerId] = playerList;
						
						-- Check if player is having Catherine's trait
						local traits = getPlayerTraits(playerId);
						if (traits["FLYING_SQUADRON_TRAIT"]) then
							playerList["addOneMore"] = true;
						end
					end
					
					spyPromotingUnits[playerId][unitId] = true;
					SPT_CheckSpyPromotion(playerId, unitId);
					
					break;
				end
			end
		end
	end
end

function getPlayerTraits(playerId: number)
    local result = {};
    local playerConfig = PlayerConfigurations[playerId];
    
    -- Civ Trait
    local playerCiv = playerConfig:GetCivilizationTypeName();
    for row in GameInfo.CivilizationTraits() do
        if (row.CivilizationType == playerCiv) then
            result[row.TraitType] = true;
        end
    end
    
    -- Leader Trait
    local playerLeader = playerConfig:GetLeaderTypeName();
    for row in GameInfo.LeaderTraits() do
        if (row.LeaderType == playerLeader) then
            result[row.TraitType] = true;
        end
    end
    
    return result;
end

Events.UnitAddedToMap.Add(SPT_UnitCreated);
Events.PlayerTurnActivated.Add(SPT_CheckSpiesPromotion)