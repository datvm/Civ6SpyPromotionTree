INSERT OR REPLACE INTO EnglishText("Tag", "Text") VALUES
	('LOC_PROMOTION_SPY_COUNTERINTELLIGENCE_NAME', 'Counter Intelligence'),
	('LOC_PROMOTION_SPY_MASTERMISCHIEF_NAME', 'Master Mischief'),
	('LOC_PROMOTION_SPY_DEEPNETWORK_NAME', 'Deep Network'),
	('LOC_PROMOTION_SPY_MASTERTHIEF_NAME', 'Master Thief'),
	('LOC_PROMOTION_SPY_ASSASSIN_NAME', 'Master Assassin'),
	('LOC_PROMOTION_SPY_MANINSUIT_NAME', 'Man in Suit'),
	('LOC_PROMOTION_SPY_DIRTYPOLITICS_NAME', 'Dirty Politics'),
	('LOC_PROMOTION_SPY_COUNTERINTELLIGENCE_DESCRIPTION', 'Counterspying is at +2 level and all city districts are defended (+1 more level at districts within 1 hex).'),
	('LOC_PROMOTION_SPY_MASTERMISCHIEF_DESCRIPTION', 'Sabotage Production and Breach Dam at +2 levels.'),
	('LOC_PROMOTION_SPY_DEEPNETWORK_DESCRIPTION', 'If this Spy is in home territory, all your Spies operate at +1 level and enemies Spies in your land operate at -1 level.'),
	('LOC_PROMOTION_SPY_MASTERTHIEF_DESCRIPTION', 'Siphon Funds and Steal Great Works at +2 levels.'),
	('LOC_PROMOTION_SPY_DIRTYPOLITICS_DESCRIPTION', 'Fabricate Scandals, Foment Unrest and Recruit Partisans at +2 levels.'),
	('LOC_PROMOTION_SPY_ASSASSIN_DESCRIPTION', 'Takes no time to establish in enemy cities. Neutralize Governor at +2 levels. Escape at +4 level if caught.'),
	('LOC_PROMOTION_SPY_MANINSUIT_DESCRIPTION', 'Steal Technology and Disrupt Rocketry at +2 level. Time to complete all missions reduced by 25%.');

UPDATE LocalizedText
	SET Text = 'You Spies start with 2 promotions (3 for Catherine).'
	WHERE Tag = 'LOC_POLICY_FUTURE_COUNTER_SCIENCE_DESCRIPTION' AND Language = 'en_US';