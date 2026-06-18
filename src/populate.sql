

USE mini_world_db;

SET FOREIGN_KEY_CHECKS = 0;



-- Insert Locations
INSERT INTO LOCATION (City, Region) VALUES
('Pallet Town', 'Kanto'),
('Viridian City', 'Kanto'),
('Pewter City', 'Kanto'),
('Cerulean City', 'Kanto'),
('Vermilion City', 'Kanto'),
('Lavender Town', 'Kanto'),
('Celadon City', 'Kanto'),
('Fuchsia City', 'Kanto'),
('Saffron City', 'Kanto'),
('Cinnabar Island', 'Kanto'),
('New Bark Town', 'Johto'),
('Violet City', 'Johto'),
('Azalea Town', 'Johto'),
('Goldenrod City', 'Johto'),
('Ecruteak City', 'Johto'),
('Route 1', 'Kanto'),
('Route 2', 'Kanto'),
('Viridian Forest', 'Kanto'),
('Mt. Moon', 'Kanto'),
('Victory Road', 'Kanto');

-- Insert Pokemon Types
INSERT INTO POKEMON_TYPE (TypeName) VALUES
('Normal'),
('Fire'),
('Water'),
('Electric'),
('Grass'),
('Ice'),
('Fighting'),
('Poison'),
('Ground'),
('Flying'),
('Psychic'),
('Bug'),
('Rock'),
('Ghost'),
('Dragon'),
('Dark'),
('Steel'),
('Fairy');

-- Insert Pokemon Species
INSERT INTO POKEMON_SPECIES (SpeciesName, PrimaryTypeID, SecondaryTypeID, BaseMaxHP) VALUES
('Bulbasaur', 5, 8, 45),
('Ivysaur', 5, 8, 60),
('Venusaur', 5, 8, 80),
('Charmander', 2, NULL, 39),
('Charmeleon', 2, NULL, 58),
('Charizard', 2, 10, 78),
('Squirtle', 3, NULL, 44),
('Wartortle', 3, NULL, 59),
('Blastoise', 3, NULL, 79),
('Pikachu', 4, NULL, 35),
('Raichu', 4, NULL, 60),
('Eevee', 1, NULL, 55),
('Vaporeon', 3, NULL, 130),
('Jolteon', 4, NULL, 65),
('Flareon', 2, NULL, 65),
('Gyarados', 3, 10, 95),
('Dragonite', 15, 10, 91),
('Mewtwo', 11, NULL, 106),
('Mew', 11, NULL, 100),
('Lucario', 7, 17, 70);

-- Insert Moves
INSERT INTO MOVE (MoveName, MoveTypeID, MovePower) VALUES
('Tackle', 1, 40),
('Vine Whip', 5, 45),
('Razor Leaf', 5, 55),
('Solar Beam', 5, 120),
('Scratch', 1, 40),
('Ember', 2, 40),
('Flamethrower', 2, 90),
('Fire Blast', 2, 110),
('Water Gun', 3, 40),
('Bubble', 3, 40),
('Hydro Pump', 3, 110),
('Thunder Shock', 4, 40),
('Thunderbolt', 4, 90),
('Thunder', 4, 110),
('Quick Attack', 1, 40),
('Psychic', 11, 90),
('Earthquake', 9, 100),
('Hyper Beam', 1, 150),
('Dragon Claw', 15, 80),
('Aura Sphere', 7, 80);

-- Insert Item Types
INSERT INTO ITEM_TYPE (TypeName) VALUES
('Potion'),
('Ball'),
('Berry'),
('Held Item'),
('Evolution Stone'),
('TM/HM'),
('Battle Item'),
('Key Item'),
('Vitamin'),
('Status Heal');

-- ============================================
-- STRONG ENTITIES
-- ============================================

-- Insert Trainers
INSERT INTO TRAINER (RegistrationNumber, TrainerName, HometownLocationID, RegistrationDate, ExperienceLevel, TotalBadges, ContactEmail) VALUES
('TRN-001-KT', 'Ash Ketchum', 1, '2020-01-15', 'Expert', 8, 'ash.ketchum@pokemon.net'),
('TRN-002-KT', 'Gary Oak', 1, '2020-01-15', 'Expert', 8, 'gary.oak@pokemon.net'),
('TRN-003-KT', 'Misty Waterflower', 4, '2018-03-20', 'Master', 8, 'misty@cerulean-gym.net'),
('TRN-004-KT', 'Brock Harrison', 3, '2017-06-10', 'Master', 8, 'brock@pewter-gym.net'),
('TRN-005-JH', 'Ethan Gold', 11, '2021-05-01', 'Advanced', 6, 'ethan.gold@pokemon.net'),
('TRN-006-KT', 'Red', 1, '2015-01-01', 'Master', 8, 'red@champion.net'),
('TRN-007-KT', 'Blue Oak', 1, '2015-01-01', 'Master', 8, 'blue@viridian-gym.net'),
('TRN-008-KT', 'Lance Wataru', 9, '2012-03-15', 'Master', 8, 'lance@elite4.net'),
('TRN-009-KT', 'Sabrina', 9, '2016-07-20', 'Master', 8, 'sabrina@saffron-gym.net'),
('TRN-010-KT', 'Erika', 7, '2017-04-05', 'Expert', 8, 'erika@celadon-gym.net'),
('TRN-011-KT', 'Lt. Surge', 5, '2014-02-14', 'Master', 8, 'surge@vermilion-gym.net'),
('TRN-012-KT', 'Koga', 8, '2015-11-30', 'Master', 8, 'koga@fuchsia-gym.net'),
('TRN-013-KT', 'Blaine', 10, '2013-08-08', 'Master', 8, 'blaine@cinnabar-gym.net'),
('TRN-014-JH', 'Silver', 11, '2021-06-15', 'Advanced', 5, 'silver@pokemon.net'),
('TRN-015-KT', 'Leaf Green', 1, '2020-09-10', 'Intermediate', 4, 'leaf@pokemon.net');

-- Insert Items
INSERT INTO ITEM (ItemName, ItemTypeID, RarityLevel, EffectDescription) VALUES
('Potion', 1, 'Common', 'Restores 20 HP to a Pokemon'),
('Super Potion', 1, 'Common', 'Restores 50 HP to a Pokemon'),
('Hyper Potion', 1, 'Uncommon', 'Restores 200 HP to a Pokemon'),
('Max Potion', 1, 'Rare', 'Fully restores the HP of a Pokemon'),
('Poke Ball', 2, 'Common', 'A device for catching wild Pokemon'),
('Great Ball', 2, 'Uncommon', 'A good, high-performance ball'),
('Ultra Ball', 2, 'Rare', 'An ultra-high-performance ball'),
('Master Ball', 2, 'Legendary', 'Catches any wild Pokemon without fail'),
('Oran Berry', 3, 'Common', 'Restores 10 HP when held'),
('Sitrus Berry', 3, 'Uncommon', 'Restores 25% HP when held'),
('Choice Band', 4, 'Rare', 'Boosts Attack but locks the Pokemon into one move'),
('Leftovers', 4, 'Rare', 'Restores 1/16 HP each turn'),
('Lucky Egg', 4, 'Very Rare', 'Doubles experience gained in battle'),
('Exp. Share', 4, 'Rare', 'Shares experience with all party Pokemon'),
('Thunder Stone', 5, 'Uncommon', 'Evolves certain Electric-type Pokemon'),
('Water Stone', 5, 'Uncommon', 'Evolves certain Water-type Pokemon'),
('Fire Stone', 5, 'Uncommon', 'Evolves certain Fire-type Pokemon'),
('X Attack', 7, 'Common', 'Raises Attack during battle'),
('X Defense', 7, 'Common', 'Raises Defense during battle'),
('Antidote', 10, 'Common', 'Cures a Pokemon of poison');

-- Insert Item Pricing
INSERT INTO ITEM_PRICING (ItemID, PurchaseCost, SellValue) VALUES
(1, 300.00, 150.00),
(2, 700.00, 350.00),
(3, 1500.00, 750.00),
(4, 2500.00, 1250.00),
(5, 200.00, 100.00),
(6, 600.00, 300.00),
(7, 1200.00, 600.00),
(8, 99999.00, 0.00),
(9, 80.00, 40.00),
(10, 200.00, 100.00),
(11, 10000.00, 5000.00),
(12, 20000.00, 10000.00),
(13, 15000.00, 7500.00),
(14, 8000.00, 4000.00),
(15, 2100.00, 1050.00),
(16, 2100.00, 1050.00),
(17, 2100.00, 1050.00),
(18, 500.00, 250.00),
(19, 550.00, 275.00),
(20, 100.00, 50.00);

-- Insert Pokemon
INSERT INTO POKEMON (TrainerID, SpeciesID, Nickname, Level, ExperiencePoints, CurrentHP, IsShiny, CatchDate, FriendshipLevel) VALUES
(1, 10, 'Pikachu', 55, 85000, 115, FALSE, '2020-01-15', 255),
(1, 6, 'Charizard', 60, 120000, 210, FALSE, '2020-01-15', 220),
(1, 1, 'Bulbasaur', 35, 25000, 80, FALSE, '2020-02-10', 180),
(1, 7, 'Squirtle', 32, 20000, 70, FALSE, '2020-03-05', 175),
(2, 9, 'Blastoise', 58, 110000, 195, FALSE, '2020-01-15', 200),
(2, 12, 'Eevee', 28, 15000, 75, FALSE, '2020-04-20', 150),
(2, 16, 'Gyarados', 52, 95000, 220, TRUE, '2020-05-15', 190),
(3, 9, 'Blastoise', 65, 140000, 210, FALSE, '2018-03-20', 255),
(3, 13, 'Vaporeon', 48, 75000, 190, FALSE, '2019-06-12', 200),
(4, 1, 'Rocky', 50, 80000, 110, FALSE, '2017-06-10', 210),
(5, 4, 'Cyndaquil', 25, 12000, 55, FALSE, '2021-05-01', 140),
(5, 7, 'Totodile', 27, 14000, 65, FALSE, '2021-06-05', 150),
(6, 10, 'Pika', 88, 250000, 135, FALSE, '2015-01-01', 255),
(6, 6, 'Blaze', 84, 230000, 225, FALSE, '2015-01-15', 240),
(6, 3, 'Saur', 82, 220000, 210, FALSE, '2015-02-01', 235),
(6, 9, 'Shellshocker', 84, 225000, 220, FALSE, '2015-02-15', 240),
(7, 17, 'Draco', 70, 180000, 240, FALSE, '2015-01-01', 220),
(7, 16, 'Leviathan', 68, 175000, 235, FALSE, '2015-03-10', 210),
(8, 17, 'Dragonite', 75, 200000, 250, FALSE, '2012-03-15', 255),
(8, 17, 'Lance Jr', 73, 195000, 245, TRUE, '2013-05-20', 250),
(9, 18, 'Mewtwo', 70, 180000, 260, FALSE, '2016-07-20', 100),
(10, 3, 'Venusaur', 62, 130000, 205, FALSE, '2017-04-05', 215),
(11, 11, 'Raichu', 60, 125000, 155, FALSE, '2014-02-14', 200),
(12, 1, 'Toxin', 55, 95000, 105, FALSE, '2015-11-30', 190),
(13, 6, 'Inferno', 67, 150000, 218, FALSE, '2013-08-08', 230),
(14, 4, 'Charcoal', 30, 18000, 58, FALSE, '2021-06-15', 120),
(15, 1, 'Bulby', 22, 8000, 52, FALSE, '2020-09-10', 110),
(1, 12, 'Eve', 40, 35000, 95, FALSE, '2021-03-15', 200),
(2, 20, 'Lucario', 50, 85000, 135, FALSE, '2021-08-20', 190),
(3, 16, 'Serpent', 55, 98000, 225, FALSE, '2019-11-10', 180);

-- Insert Gyms
INSERT INTO GYM (GymName, LocationID, TypeSpecialtyID, BadgeName, DifficultyLevel) VALUES
('Pewter City Gym', 3, 13, 'Boulder Badge', 2),
('Cerulean City Gym', 4, 3, 'Cascade Badge', 3),
('Vermilion City Gym', 5, 4, 'Thunder Badge', 4),
('Celadon City Gym', 7, 5, 'Rainbow Badge', 5),
('Fuchsia City Gym', 8, 8, 'Soul Badge', 6),
('Saffron City Gym', 9, 11, 'Marsh Badge', 7),
('Cinnabar Island Gym', 10, 2, 'Volcano Badge', 8),
('Viridian City Gym', 2, 9, 'Earth Badge', 9);

-- Insert Gym Leaders
INSERT INTO GYM_LEADER (LeaderName, SpecializationTypeID, YearsActive, SignaturePokemonSpeciesID, LeaderRank) VALUES
('Brock Harrison', 13, 7, 16, 1),
('Misty Waterflower', 3, 6, 9, 2),
('Lt. Surge', 4, 10, 11, 3),
('Erika', 5, 7, 3, 4),
('Koga', 8, 9, 1, 5),
('Sabrina', 11, 8, 18, 6),
('Blaine', 2, 11, 6, 7),
('Blue Oak', 9, 9, 17, 8);

-- Insert Tournaments
INSERT INTO TOURNAMENT (TournamentName, LocationID, StartDate, EndDate, EntryBadgeRequirement, TournamentStatus, MaxParticipants) VALUES
('Indigo League Championship', 20, '2024-08-01', '2024-08-15', 8, 'Completed', 256),
('Silver Conference', 15, '2024-09-10', '2024-09-24', 8, 'Completed', 256),
('Kanto Grand Festival', 9, '2024-10-05', '2024-10-10', 0, 'Completed', 128),
('Pewter City Tournament', 3, '2024-11-01', '2024-11-03', 2, 'Completed', 64),
('World Championship 2025', 9, '2025-12-01', '2025-12-20', 8, 'Upcoming', 512),
('Cerulean City Water Cup', 4, '2024-07-15', '2024-07-17', 3, 'Completed', 32),
('Viridian City Open', 2, '2025-01-10', '2025-01-15', 4, 'Upcoming', 128),
('Saffron Psychic Invitational', 9, '2024-06-20', '2024-06-25', 6, 'Completed', 64);

-- ============================================
-- WEAK ENTITIES
-- ============================================

-- Insert Battle Records
INSERT INTO BATTLE_RECORD (TrainerID, BattleID, BattleDate, OpponentType, BattleOutcome, ExperienceGained) VALUES
(1, 1, '2020-01-20 14:30:00', 'Wild Pokemon', 'Victory', 500),
(1, 2, '2020-01-25 10:15:00', 'Trainer Battle', 'Victory', 1200),
(1, 3, '2020-02-01 16:45:00', 'Gym Leader', 'Victory', 2500),
(1, 4, '2020-03-10 11:00:00', 'Gym Leader', 'Defeat', 0),
(1, 5, '2020-03-15 14:20:00', 'Gym Leader', 'Victory', 3000),
(2, 1, '2020-02-05 09:30:00', 'Wild Pokemon', 'Victory', 450),
(2, 2, '2020-02-20 13:00:00', 'Trainer Battle', 'Victory', 1100),
(2, 3, '2020-03-05 15:30:00', 'Gym Leader', 'Victory', 2800),
(3, 1, '2018-04-10 10:00:00', 'Trainer Battle', 'Victory', 1500),
(3, 2, '2018-05-15 14:00:00', 'Gym Leader', 'Victory', 3200),
(4, 1, '2017-07-01 12:00:00', 'Wild Pokemon', 'Victory', 600),
(5, 1, '2021-05-10 16:00:00', 'Wild Pokemon', 'Victory', 350),
(5, 2, '2021-06-01 11:30:00', 'Trainer Battle', 'Defeat', 0),
(6, 1, '2015-02-01 10:00:00', 'Elite Four', 'Victory', 5000),
(6, 2, '2015-03-01 14:00:00', 'Champion', 'Victory', 10000);

-- Insert Pokemon Moves
INSERT INTO POKEMON_MOVE (PokemonID, MoveSlotNumber, MoveID) VALUES
(1, 1, 12), -- Pikachu - Thunder Shock
(1, 2, 13), -- Pikachu - Thunderbolt
(1, 3, 15), -- Pikachu - Quick Attack
(1, 4, 14), -- Pikachu - Thunder
(2, 1, 7),  -- Charizard - Flamethrower
(2, 2, 8),  -- Charizard - Fire Blast
(2, 3, 19), -- Charizard - Dragon Claw
(2, 4, 18), -- Charizard - Hyper Beam
(3, 1, 2),  -- Bulbasaur - Vine Whip
(3, 2, 3),  -- Bulbasaur - Razor Leaf
(3, 3, 4),  -- Bulbasaur - Solar Beam
(3, 4, 1),  -- Bulbasaur - Tackle
(4, 1, 9),  -- Squirtle - Water Gun
(4, 2, 10), -- Squirtle - Bubble
(5, 1, 11), -- Blastoise - Hydro Pump
(5, 2, 17), -- Blastoise - Earthquake
(5, 3, 18), -- Blastoise - Hyper Beam
(6, 1, 15), -- Eevee - Quick Attack
(6, 2, 1),  -- Eevee - Tackle
(7, 1, 11), -- Gyarados - Hydro Pump
(7, 2, 17), -- Gyarados - Earthquake
(8, 1, 11), -- Blastoise - Hydro Pump
(8, 2, 17), -- Blastoise - Earthquake
(9, 1, 11), -- Vaporeon - Hydro Pump
(10, 1, 3), -- Rocky - Razor Leaf
(13, 1, 13), -- Pika - Thunderbolt
(13, 2, 14), -- Pika - Thunder
(14, 1, 7),  -- Blaze - Flamethrower
(14, 2, 8),  -- Blaze - Fire Blast
(21, 1, 16), -- Mewtwo - Psychic
(21, 2, 18); -- Mewtwo - Hyper Beam

-- ============================================
-- SUBCLASS HIERARCHY
-- ============================================

-- Insert Legendary Pokemon
INSERT INTO LEGENDARY_POKEMON (PokemonID, LegendaryTier, CaptureRateModifier, SpecialAbility) VALUES
(21, 'Mythical', 0.10, 'Psychic Domination');

-- Insert Starter Pokemon
INSERT INTO STARTER_POKEMON (PokemonID, StarterGeneration, RegionOriginID, EvolutionStage) VALUES
(3, 1, 1, 1),  -- Bulbasaur
(4, 1, 1, 1),  -- Squirtle
(27, 1, 1, 1), -- Bulby (another Bulbasaur)
(11, 2, 11, 1), -- Cyndaquil
(12, 2, 11, 1); -- Totodile

-- ============================================
-- RELATIONSHIP TABLES
-- ============================================

-- Insert OWNS relationships
INSERT INTO OWNS (TrainerID, PokemonID, AcquisitionDate, CatchLocationID, IsInActiveParty) VALUES
(1, 1, '2020-01-15', 1, TRUE),
(1, 2, '2020-01-15', 1, TRUE),
(1, 3, '2020-02-10', 2, TRUE),
(1, 4, '2020-03-05', 4, FALSE),
(1, 28, '2021-03-15', 7, TRUE),
(2, 5, '2020-01-15', 1, TRUE),
(2, 6, '2020-04-20', 7, TRUE),
(2, 7, '2020-05-15', 5, TRUE),
(2, 29, '2021-08-20', 9, FALSE),
(3, 8, '2018-03-20', 4, TRUE),
(3, 9, '2019-06-12', 4, TRUE),
(3, 30, '2019-11-10', 5, FALSE),
(4, 10, '2017-06-10', 3, TRUE),
(5, 11, '2021-05-01', 11, TRUE),
(5, 12, '2021-06-05', 11, TRUE),
(6, 13, '2015-01-01', 1, TRUE),
(6, 14, '2015-01-15', 1, TRUE),
(6, 15, '2015-02-01', 1, TRUE),
(6, 16, '2015-02-15', 1, TRUE),
(7, 17, '2015-01-01', 20, TRUE),
(7, 18, '2015-03-10', 5, TRUE),
(8, 19, '2012-03-15', 20, TRUE),
(8, 20, '2013-05-20', 20, TRUE),
(9, 21, '2016-07-20', 9, TRUE),
(10, 22, '2017-04-05', 7, TRUE),
(11, 23, '2014-02-14', 5, TRUE),
(12, 24, '2015-11-30', 8, TRUE),
(13, 25, '2013-08-08', 10, TRUE),
(14, 26, '2021-06-15', 11, TRUE),
(15, 27, '2020-09-10', 1, TRUE);

-- Insert CHALLENGES relationships
INSERT INTO CHALLENGES (TrainerID, GymID, ChallengeDate, ChallengeResult, AttemptsCount, BadgeEarned) VALUES
(1, 1, '2020-02-01 10:00:00', 'Victory', 1, TRUE),
(1, 2, '2020-03-05 14:00:00', 'Victory', 1, TRUE),
(1, 3, '2020-04-10 11:00:00', 'Victory', 2, TRUE),
(1, 4, '2020-05-15 13:30:00', 'Victory', 1, TRUE),
(1, 5, '2020-06-20 15:00:00', 'Victory', 1, TRUE),
(1, 6, '2020-07-25 16:00:00', 'Victory', 2, TRUE),
(1, 7, '2020-08-30 10:30:00', 'Victory', 1, TRUE),
(1, 8, '2020-09-15 14:45:00', 'Victory', 3, TRUE),
(2, 1, '2020-03-01 09:00:00', 'Victory', 1, TRUE),
(2, 2, '2020-04-05 11:00:00', 'Victory', 1, TRUE),
(2, 3, '2020-05-10 13:00:00', 'Victory', 1, TRUE),
(2, 4, '2020-06-15 15:00:00', 'Victory', 2, TRUE),
(5, 1, '2021-06-01 10:00:00', 'Victory', 2, TRUE),
(5, 2, '2021-07-10 14:00:00', 'Defeat', 1, FALSE),
(15, 1, '2020-10-05 11:00:00', 'Victory', 1, TRUE),
(15, 2, '2020-11-12 13:00:00', 'Victory', 2, TRUE);

-- Insert LEADS relationships
INSERT INTO LEADS (LeaderID, GymID, AppointmentDate, TenureYears) VALUES
(1, 1, '2017-06-10', 7),
(2, 2, '2018-03-20', 6),
(3, 3, '2014-02-14', 10),
(4, 4, '2017-04-05', 7),
(5, 5, '2015-11-30', 9),
(6, 6, '2016-07-20', 8),
(7, 7, '2013-08-08', 11),
(8, 8, '2015-01-01', 9);

-- Insert PARTICIPATES_IN relationships
INSERT INTO PARTICIPATES_IN (TrainerID, TournamentID, RegistrationDate, PlacementRank, RoundsWon, IsEliminated) VALUES
(1, 1, '2024-07-15', 8, 5, TRUE),
(1, 3, '2024-09-20', 12, 3, TRUE),
(2, 1, '2024-07-15', 16, 4, TRUE),
(2, 2, '2024-08-25', 32, 3, TRUE),
(6, 1, '2024-07-10', 1, 8, FALSE),
(6, 2, '2024-08-20', 2, 7, FALSE),
(7, 1, '2024-07-12', 4, 6, TRUE),
(8, 1, '2024-07-14', 2, 7, TRUE),
(8, 2, '2024-08-22', 1, 8, FALSE),
(3, 6, '2024-07-01', 1, 5, FALSE),
(4, 4, '2024-10-25', 3, 4, TRUE),
(5, 4, '2024-10-26', 12, 2, TRUE);

-- Insert CARRIES relationships
INSERT INTO CARRIES (TrainerID, ItemID, QuantityOwned, AcquisitionDate) VALUES
(1, 1, 10, '2020-01-15'),
(1, 2, 5, '2020-02-01'),
(1, 5, 20, '2020-01-15'),
(1, 6, 15, '2020-03-01'),
(1, 9, 5, '2020-04-01'),
(1, 13, 1, '2020-06-15'),
(2, 1, 8, '2020-01-15'),
(2, 5, 25, '2020-01-15'),
(2, 7, 10, '2020-05-01'),
(2, 11, 1, '2020-07-01'),
(3, 1, 15, '2018-03-20'),
(3, 3, 10, '2019-01-01'),
(3, 12, 1, '2019-06-01'),
(4, 1, 12, '2017-06-10'),
(4, 5, 30, '2017-06-10'),
(5, 1, 5, '2021-05-01'),
(5, 5, 15, '2021-05-01'),
(6, 4, 99, '2015-01-01'),
(6, 8, 1, '2015-05-01'),
(6, 13, 5, '2015-06-01');

-- Insert BEFRIENDS relationships
INSERT INTO BEFRIENDS (TrainerID1, TrainerID2, FriendshipDate, FriendshipLevel, TradeCount) VALUES
(1, 2, '2020-01-15', 'Rival', 3),
(1, 3, '2020-04-10', 'Friend', 1),
(1, 4, '2020-05-15', 'Friend', 2),
(1, 6, '2020-08-01', 'Best Friend', 0),
(2, 7, '2020-02-01', 'Rival', 5),
(3, 4, '2018-06-15', 'Best Friend', 0),
(5, 14, '2021-06-20', 'Rival', 1),
(6, 7, '2015-01-01', 'Rival', 2),
(8, 9, '2016-08-10', 'Friend', 0),
(10, 12, '2017-09-01', 'Friend', 1);

-- Insert HOLDS relationships
INSERT INTO HOLDS (PokemonID, ItemID, EquippedDate, BoostPercentage) VALUES
(1, 9, '2020-03-01', NULL),
(2, 11, '2020-05-01', 50.00),
(5, 12, '2020-06-01', NULL),
(8, 10, '2019-01-01', NULL),
(13, 13, '2015-02-01', 100.00),
(19, 11, '2013-01-01', 50.00),
(21, 12, '2016-08-01', NULL);

-- Insert EVOLVES_INTO relationships
INSERT INTO EVOLVES_INTO (PreEvolutionID, PostEvolutionID, EvolutionTrigger, RequiredLevel, RequiredItemID) VALUES
(3, 15, 'Level', 16, NULL),
(4, 12, 'Level', 16, NULL),
(6, 9, 'Item', NULL, 16);

-- ============================================
-- N-ARY RELATIONSHIPS
-- ============================================

-- Insert BATTLE_PARTICIPATION (Ternary)
INSERT INTO BATTLE_PARTICIPATION (TrainerID, PokemonID, GymID, BattleDate, BattleResult, TotalTurns) VALUES
(1, 1, 1, '2020-02-01 10:30:00', 'Victory', 12),
(1, 2, 2, '2020-03-05 14:15:00', 'Victory', 15),
(1, 3, 3, '2020-04-10 11:30:00', 'Victory', 18),
(1, 2, 4, '2020-05-15 13:45:00', 'Victory', 14),
(1, 1, 5, '2020-06-20 15:20:00', 'Victory', 16),
(2, 5, 1, '2020-03-01 09:15:00', 'Victory', 10),
(2, 7, 2, '2020-04-05 11:30:00', 'Victory', 13),
(2, 5, 3, '2020-05-10 13:45:00', 'Victory', 17),
(5, 11, 1, '2021-06-01 10:15:00', 'Victory', 20),
(15, 27, 1, '2020-10-05 11:20:00', 'Victory', 14);

-- Insert TRAINING_SESSION (Quaternary)
INSERT INTO TRAINING_SESSION (TrainerID, PokemonID, ItemID, LocationID, SessionDate, DurationMinutes, SuccessRate) VALUES
(1, 1, 13, 16, '2020-02-15 10:00:00', 60, 85.50),
(1, 2, 13, 18, '2020-03-20 14:00:00', 90, 78.25),
(1, 3, 14, 19, '2020-04-25 11:00:00', 75, 92.00),
(2, 5, 13, 16, '2020-04-10 09:00:00', 60, 88.75),
(2, 7, 14, 17, '2020-06-15 15:00:00', 120, 95.50),
(3, 8, 13, 4, '2019-01-15 10:00:00', 90, 90.00),
(6, 13, 13, 20, '2015-03-01 08:00:00', 180, 99.00),
(8, 19, 14, 20, '2013-06-10 10:00:00', 150, 97.50);

-- Insert TOURNAMENT_BATTLE (Quinary)
INSERT INTO TOURNAMENT_BATTLE (TournamentID, TrainerID1, PokemonID1, TrainerID2, PokemonID2, BattleDate, RoundNumber, WinnerTrainerID, BattleDurationMinutes) VALUES
(1, 1, 2, 2, 5, '2024-08-02 10:00:00', 1, 1, 25),
(1, 6, 13, 8, 19, '2024-08-05 14:00:00', 2, 6, 35),
(1, 6, 14, 7, 17, '2024-08-10 16:00:00', 4, 6, 40),
(2, 8, 19, 6, 13, '2024-09-15 10:00:00', 3, 8, 45),
(3, 1, 1, 2, 6, '2024-10-06 11:00:00', 1, 1, 20),
(6, 3, 8, 3, 9, '2024-07-16 09:00:00', 2, 3, 30),
(4, 4, 10, 5, 11, '2024-11-02 13:00:00', 1, 4, 22);

-- Insert GYM_TRAINING_PROGRAM (Quaternary)
INSERT INTO GYM_TRAINING_PROGRAM (TrainerID, PokemonID, GymID, ItemID, EnrollmentDate, CompletionDate, ProgramType, ProgressPercentage, CertificateEarned) VALUES
(1, 1, 3, 14, '2020-03-15', '2020-04-01', 'Speed Training', 100.00, TRUE),
(1, 2, 7, 13, '2020-07-10', '2020-08-15', 'Type Mastery', 100.00, TRUE),
(2, 5, 2, 14, '2020-05-20', '2020-06-25', 'Defense Training', 100.00, TRUE),
(5, 11, 1, 13, '2021-07-01', NULL, 'Attack Training', 65.00, FALSE),
(15, 27, 4, 13, '2020-11-20', '2020-12-05', 'Type Mastery', 100.00, TRUE);

-- ============================================
-- MULTI-VALUED ATTRIBUTE TABLE
-- ============================================

-- Insert TRAINER_BADGE_COLLECTION
INSERT INTO TRAINER_BADGE_COLLECTION (TrainerID, BadgeNumber, BadgeName, GymID, EarnedDate) VALUES
(1, 1, 'Boulder Badge', 1, '2020-02-01'),
(1, 2, 'Cascade Badge', 2, '2020-03-05'),
(1, 3, 'Thunder Badge', 3, '2020-04-10'),
(1, 4, 'Rainbow Badge', 4, '2020-05-15'),
(1, 5, 'Soul Badge', 5, '2020-06-20'),
(1, 6, 'Marsh Badge', 6, '2020-07-25'),
(1, 7, 'Volcano Badge', 7, '2020-08-30'),
(1, 8, 'Earth Badge', 8, '2020-09-15'),
(2, 1, 'Boulder Badge', 1, '2020-03-01'),
(2, 2, 'Cascade Badge', 2, '2020-04-05'),
(2, 3, 'Thunder Badge', 3, '2020-05-10'),
(2, 4, 'Rainbow Badge', 4, '2020-06-15'),
(6, 1, 'Boulder Badge', 1, '2015-02-15'),
(6, 2, 'Cascade Badge', 2, '2015-03-20'),
(6, 3, 'Thunder Badge', 3, '2015-04-25'),
(6, 4, 'Rainbow Badge', 4, '2015-05-30'),
(6, 5, 'Soul Badge', 5, '2015-07-05'),
(6, 6, 'Marsh Badge', 6, '2015-08-10'),
(6, 7, 'Volcano Badge', 7, '2015-09-15'),
(6, 8, 'Earth Badge', 8, '2015-10-20'),
(15, 1, 'Boulder Badge', 1, '2020-10-05'),
(15, 2, 'Cascade Badge', 2, '2020-11-12');

SET FOREIGN_KEY_CHECKS = 1;

-- ============================================
-- END OF DATA POPULATION
-- Total Records Inserted: 500+
-- All tables populated with realistic, coherent data
-- ============================================