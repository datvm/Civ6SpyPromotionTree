-- Promotions
INSERT INTO Types("Type", "Kind") VALUES
	('PROMOTION_SPY_COUNTERINTELLIGENCE', 'KIND_PROMOTION'),
	('PROMOTION_SPY_MASTERMISCHIEF', 'KIND_PROMOTION'),
	('PROMOTION_SPY_DEEPNETWORK', 'KIND_PROMOTION'),
	('PROMOTION_SPY_MASTERTHIEF', 'KIND_PROMOTION'),
	('PROMOTION_SPY_DIRTYPOLITICS', 'KIND_PROMOTION'),
	('PROMOTION_SPY_ASSASSIN', 'KIND_PROMOTION'),
	('PROMOTION_SPY_MANINSUIT', 'KIND_PROMOTION');

INSERT INTO UnitPromotions(UnitPromotionType, Name, Description, "Level", PromotionClass, "Column") VALUES
	('PROMOTION_SPY_COUNTERINTELLIGENCE', 'LOC_PROMOTION_SPY_COUNTERINTELLIGENCE_NAME', 'LOC_PROMOTION_SPY_COUNTERINTELLIGENCE_DESCRIPTION', 1, 'PROMOTION_CLASS_SPY', 1),
	('PROMOTION_SPY_MASTERMISCHIEF', 'LOC_PROMOTION_SPY_MASTERMISCHIEF_NAME', 'LOC_PROMOTION_SPY_MASTERMISCHIEF_DESCRIPTION', 1, 'PROMOTION_CLASS_SPY', 3),
	('PROMOTION_SPY_DEEPNETWORK', 'LOC_PROMOTION_SPY_DEEPNETWORK_NAME', 'LOC_PROMOTION_SPY_DEEPNETWORK_DESCRIPTION', 2, 'PROMOTION_CLASS_SPY', 1),
	('PROMOTION_SPY_MASTERTHIEF', 'LOC_PROMOTION_SPY_MASTERTHIEF_NAME', 'LOC_PROMOTION_SPY_MASTERTHIEF_DESCRIPTION', 2, 'PROMOTION_CLASS_SPY', 3),
	('PROMOTION_SPY_DIRTYPOLITICS', 'LOC_PROMOTION_SPY_DIRTYPOLITICS_NAME', 'LOC_PROMOTION_SPY_DIRTYPOLITICS_DESCRIPTION', 3, 'PROMOTION_CLASS_SPY', 2),
	('PROMOTION_SPY_ASSASSIN', 'LOC_PROMOTION_SPY_ASSASSIN_NAME', 'LOC_PROMOTION_SPY_ASSASSIN_DESCRIPTION', 4, 'PROMOTION_CLASS_SPY', 3),
	('PROMOTION_SPY_MANINSUIT', 'LOC_PROMOTION_SPY_MANINSUIT_NAME', 'LOC_PROMOTION_SPY_MANINSUIT_DESCRIPTION', 4, 'PROMOTION_CLASS_SPY', 1);
	
INSERT INTO UnitPromotionPrereqs("UnitPromotion", "PrereqUnitPromotion") VALUES
	('PROMOTION_SPY_DEEPNETWORK', 'PROMOTION_SPY_COUNTERINTELLIGENCE'),
	('PROMOTION_SPY_MASTERTHIEF', 'PROMOTION_SPY_MASTERMISCHIEF'),
	('PROMOTION_SPY_DIRTYPOLITICS', 'PROMOTION_SPY_DEEPNETWORK'),
	('PROMOTION_SPY_DIRTYPOLITICS', 'PROMOTION_SPY_MASTERTHIEF'),
	('PROMOTION_SPY_ASSASSIN', 'PROMOTION_SPY_DIRTYPOLITICS'),
	('PROMOTION_SPY_MANINSUIT', 'PROMOTION_SPY_DIRTYPOLITICS');
	
INSERT INTO UnitPromotionModifiers(UnitPromotionType, ModifierId)
	SELECT 'PROMOTION_SPY_COUNTERINTELLIGENCE', ModifierId
	FROM UnitPromotionModifiers
	WHERE UnitPromotionType = 'PROMOTION_SPY_SEDUCTION' OR UnitPromotionType = 'PROMOTION_SPY_SURVEILLANCE';

INSERT INTO UnitPromotionModifiers(UnitPromotionType, ModifierId)
	SELECT 'PROMOTION_SPY_MASTERMISCHIEF', ModifierId
	FROM UnitPromotionModifiers
	WHERE UnitPromotionType = 'PROMOTION_SPY_DEMOLITIONS' OR UnitPromotionType = 'PROMOTION_SPY_SATCHEL_CHARGES';

INSERT INTO UnitPromotionModifiers(UnitPromotionType, ModifierId)
	SELECT 'PROMOTION_SPY_DEEPNETWORK', ModifierId
	FROM UnitPromotionModifiers
	WHERE UnitPromotionType = 'PROMOTION_SPY_QUARTERMASTER' OR UnitPromotionType = 'PROMOTION_SPY_POLYGRAPH';
	
INSERT INTO UnitPromotionModifiers(UnitPromotionType, ModifierId)
	SELECT 'PROMOTION_SPY_MASTERTHIEF', ModifierId
	FROM UnitPromotionModifiers
	WHERE UnitPromotionType = 'PROMOTION_SPY_CON_ARTIST' OR UnitPromotionType = 'PROMOTION_SPY_CAT_BURGLAR';
	
INSERT INTO UnitPromotionModifiers(UnitPromotionType, ModifierId)
	SELECT 'PROMOTION_SPY_DIRTYPOLITICS', ModifierId
	FROM UnitPromotionModifiers
	WHERE UnitPromotionType = 'PROMOTION_SPY_GUERILLA_LEADER' OR UnitPromotionType = 'PROMOTION_SPY_COVERT_ACTION' OR UnitPromotionType = 'PROMOTION_SPY_SMEAR_CAMPAIGN';
	
INSERT INTO UnitPromotionModifiers(UnitPromotionType, ModifierId)
	SELECT 'PROMOTION_SPY_ASSASSIN', ModifierId
	FROM UnitPromotionModifiers
	WHERE UnitPromotionType = 'PROMOTION_SPY_ACE_DRIVER' OR UnitPromotionType = 'PROMOTION_SPY_LICENSE_TO_KILL' OR UnitPromotionType = 'PROMOTION_SPY_DISGUISE';
	
INSERT INTO UnitPromotionModifiers(UnitPromotionType, ModifierId)
	SELECT 'PROMOTION_SPY_MANINSUIT', ModifierId
	FROM UnitPromotionModifiers
	WHERE UnitPromotionType = 'PROMOTION_SPY_LINGUIST' OR UnitPromotionType = 'PROMOTION_SPY_TECHNOLOGIST' OR UnitPromotionType = 'PROMOTION_SPY_ROCKET_SCIENTIST';

DELETE FROM UnitPromotions WHERE PromotionClass = 'PROMOTION_CLASS_SPY' AND "Column" = 0;

-- Set to Promotion Tree
UPDATE GlobalParameters SET "Value" = 8 WHERE "Name" = 'ESPIONAGE_MAX_LEVEL';
UPDATE Units SET NumRandomChoices = 0 WHERE PromotionClass = 'PROMOTION_CLASS_SPY';

-- Move Spy to Maths For Catherine
INSERT INTO Requirements("RequirementId", "RequirementType", "ProgressWeight") VALUES ('REQUIRES_TECHNOLOGY_MATHEMATICS', 'REQUIREMENT_PLAYER_HAS_TECHNOLOGY', 1);
INSERT INTO RequirementSets("RequirementSetId", "RequirementSetType") VALUES ('PLAYER_HAS_MATHEMATICS_TECHNOLOGY_AND_CAPITAL', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements("RequirementSetId", "RequirementId") VALUES
	('PLAYER_HAS_MATHEMATICS_TECHNOLOGY_AND_CAPITAL', 'REQUIRES_TECHNOLOGY_MATHEMATICS'),
	('PLAYER_HAS_MATHEMATICS_TECHNOLOGY_AND_CAPITAL', 'REQUIRES_CAPITAL_CITY');

INSERT INTO RequirementArguments("RequirementId", "Name", "Type", "Value") VALUES ('REQUIRES_TECHNOLOGY_MATHEMATICS', 'TechnologyType', 'ARGTYPE_IDENTITY', 'TECH_MATHEMATICS');

UPDATE Modifiers SET OwnerRequirementSetId = 'PLAYER_HAS_MATHEMATICS_TECHNOLOGY_AND_CAPITAL' WHERE ModifierId = 'UNIQUE_LEADER_ADD_SPY_UNIT';

-- Add a Spy for everyone add Feudalism
INSERT INTO CivicModifiers("CivicType", "ModifierId") VALUES ('CIVIC_FEUDALISM', 'CIVIC_GRANT_SPY');

-- Change function of Non-state Actors
---- Remove original feature
DELETE FROM PolicyModifiers WHERE PolicyType = 'POLICY_FUTURE_COUNTER_SCIENCE';

---- Fake feature (+0% XP), LUA script will take care of it
INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
	('FUTURE_COUNTER_SCIENCE_SPY_GRANT_TWO_PROMOTIONS', 'MODIFIER_PLAYER_UNITS_ADJUST_UNIT_EXPERIENCE_MODIFIER');
INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
	('FUTURE_COUNTER_SCIENCE_SPY_GRANT_TWO_PROMOTIONS', 'Amount', 'ARGTYPE_IDENTITY', 0);
INSERT INTO PolicyModifiers(PolicyType, ModifierId)
	SELECT PolicyType, 'FUTURE_COUNTER_SCIENCE_SPY_GRANT_TWO_PROMOTIONS'
	FROM Policies
	WHERE PolicyType = 'POLICY_FUTURE_COUNTER_SCIENCE';
-- INSERT INTO PolicyModifiers(PolicyType, ModifierId) VALUES
	-- ('POLICY_FUTURE_COUNTER_SCIENCE', 'FUTURE_COUNTER_SCIENCE_SPY_GRANT_TWO_PROMOTIONS');
	
-- For debug
-- INSERT INTO CivicModifiers("CivicType", "ModifierId") VALUES ('CIVIC_CODE_OF_LAWS', 'CIVIC_GRANT_SPY');
-- UPDATE Policies SET PrereqCivic = 'CIVIC_CODE_OF_LAWS', GovernmentSlotType = 'SLOT_MILITARY' WHERE PolicyType = 'POLICY_FUTURE_COUNTER_SCIENCE';