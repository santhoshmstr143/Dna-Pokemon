"""
============================================
Pokémon Database Management System
Command-Line Interface Application
============================================
Part B: Application Interface (Python)
Matches schema2.sql (STRICT 3NF)
"""

import pymysql
import sys
from getpass import getpass
from datetime import datetime, date

def get_db_connection(db_user, db_pass, db_host, db_name):
    """Establishes a connection to the MySQL database."""
    try:
        connection = pymysql.connect(
            host=db_host,
            user=db_user,
            password=db_pass,
            database=db_name,
            cursorclass=pymysql.cursors.DictCursor,
            autocommit=False
        )
        print("Database connection successful.")
        return connection
    except pymysql.Error as e:
        print(f"Error connecting to MySQL Database: {e}", file=sys.stderr)
        return None

# ============================================
# READ OPERATIONS (5+ Query Functions)
# ============================================

def view_all_trainers(connection):
    """READ 1: View all trainers with their details."""
    print("\n--- All Trainers ---")
    try:
        with connection.cursor() as cursor:
            sql_query = """
                SELECT t.TrainerID, t.TrainerName, t.RegistrationNumber, 
                       t.ExperienceLevel, t.TotalBadges, l.City, l.Region
                FROM TRAINER t
                LEFT JOIN LOCATION l ON t.HometownLocationID = l.LocationID
                ORDER BY t.TrainerID
            """
            cursor.execute(sql_query)
            results = cursor.fetchall()
            
            if not results:
                print("No trainers found.")
            else:
                print(f"\nTotal Trainers: {len(results)}\n")
                # Print table header
                print(f"{'ID':<5} {'Name':<20} {'Reg Number':<15} {'Level':<15} {'Badges':<8} {'City':<20} {'Region':<10}")
                print("-" * 110)
                # Print table rows
                for row in results:
                    city = row['City'] if row['City'] else 'Unknown'
                    region = row['Region'] if row['Region'] else 'Unknown'
                    reg_num = row['RegistrationNumber'] if row['RegistrationNumber'] else 'N/A'
                    print(f"{row['TrainerID']:<5} {row['TrainerName']:<20} {reg_num:<15} {row['ExperienceLevel']:<15} {row['TotalBadges']:<8} {city:<20} {region:<10}")
    except pymysql.Error as e:
        print(f"Error during query: {e}", file=sys.stderr)
    except Exception as e:
        print(f"Unexpected error: {e}", file=sys.stderr)

def search_trainer_pokemon(connection):
    """READ 2: Search for all Pokemon owned by a specific trainer."""
    print("\n--- Trainer's Pokemon ---")
    trainer_name = input("Enter trainer name to search: ").strip()
    
    try:
        with connection.cursor() as cursor:
            sql_query = """
                SELECT p.PokemonID, p.Nickname, ps.SpeciesName, p.Level, 
                       p.CurrentHP, pt1.TypeName as PrimaryType, pt2.TypeName as SecondaryType,
                       p.IsShiny, o.IsInActiveParty
                FROM POKEMON p
                JOIN TRAINER t ON p.TrainerID = t.TrainerID
                JOIN POKEMON_SPECIES ps ON p.SpeciesID = ps.SpeciesID
                JOIN POKEMON_TYPE pt1 ON ps.PrimaryTypeID = pt1.TypeID
                LEFT JOIN POKEMON_TYPE pt2 ON ps.SecondaryTypeID = pt2.TypeID
                JOIN OWNS o ON p.PokemonID = o.PokemonID AND p.TrainerID = o.TrainerID
                WHERE t.TrainerName = %s
                ORDER BY p.Level DESC
            """
            cursor.execute(sql_query, (trainer_name,))
            results = cursor.fetchall()
            
            if not results:
                print(f"No Pokemon found for trainer '{trainer_name}'.")
            else:
                print(f"\nPokemon owned by {trainer_name}: {len(results)}\n")
                # Print table header
                print(f"{'ID':<5} {'Nickname':<15} {'Species':<15} {'Type':<20} {'Level':<7} {'HP':<6} {'Shiny':<7} {'Active':<8}")
                print("-" * 100)
                # Print table rows
                for row in results:
                    shiny = "Yes" if row['IsShiny'] else "No"
                    active = "Yes" if row['IsInActiveParty'] else "No"
                    secondary_type = f"/{row['SecondaryType']}" if row['SecondaryType'] else ""
                    type_str = f"{row['PrimaryType']}{secondary_type}"
                    print(f"{row['PokemonID']:<5} {row['Nickname']:<15} {row['SpeciesName']:<15} {type_str:<20} {row['Level']:<7} {row['CurrentHP']:<6} {shiny:<7} {active:<8}")
    except pymysql.Error as e:
        print(f"Error during query: {e}", file=sys.stderr)

def view_gym_leaders_and_gyms(connection):
    """READ 3: View all gyms with their leaders and specialties."""
    print("\n--- Gym Leaders and Gyms ---")
    try:
        with connection.cursor() as cursor:
            sql_query = """
                SELECT g.GymID, g.GymName, g.BadgeName, g.DifficultyLevel,
                       gl.LeaderName, pt.TypeName as Specialty, l.City, l.Region
                FROM GYM g
                JOIN LEADS ld ON g.GymID = ld.GymID
                JOIN GYM_LEADER gl ON ld.LeaderID = gl.LeaderID
                JOIN POKEMON_TYPE pt ON g.TypeSpecialtyID = pt.TypeID
                JOIN LOCATION loc ON g.LocationID = loc.LocationID
                LEFT JOIN LOCATION l ON g.LocationID = l.LocationID
                ORDER BY g.DifficultyLevel
            """
            cursor.execute(sql_query)
            results = cursor.fetchall()
            
            if not results:
                print("No gyms found.")
            else:
                print(f"\nTotal Gyms: {len(results)}\n")
                # Print table header
                print(f"{'ID':<5} {'Gym Name':<25} {'Leader':<20} {'Specialty':<12} {'Badge':<18} {'City':<20} {'Difficulty':<10}")
                print("-" * 120)
                # Print table rows
                for row in results:
                    print(f"{row['GymID']:<5} {row['GymName']:<25} {row['LeaderName']:<20} {row['Specialty']:<12} {row['BadgeName']:<18} {row['City']:<20} {row['DifficultyLevel']:<10}")
    except pymysql.Error as e:
        print(f"Error during query: {e}", file=sys.stderr)

def search_pokemon_by_type(connection):
    """READ 4: Search Pokemon by type."""
    print("\n--- Search Pokemon by Type ---")
    type_name = input("Enter Pokemon type (Fire, Water, Electric, etc.): ").strip()
    
    try:
        with connection.cursor() as cursor:
            sql_query = """
                SELECT p.PokemonID, p.Nickname, ps.SpeciesName, p.Level,
                       t.TrainerName, pt1.TypeName as PrimaryType, pt2.TypeName as SecondaryType
                FROM POKEMON p
                JOIN POKEMON_SPECIES ps ON p.SpeciesID = ps.SpeciesID
                JOIN POKEMON_TYPE pt1 ON ps.PrimaryTypeID = pt1.TypeID
                LEFT JOIN POKEMON_TYPE pt2 ON ps.SecondaryTypeID = pt2.TypeID
                JOIN TRAINER t ON p.TrainerID = t.TrainerID
                WHERE pt1.TypeName = %s OR pt2.TypeName = %s
                ORDER BY p.Level DESC
            """
            cursor.execute(sql_query, (type_name, type_name))
            results = cursor.fetchall()
            
            if not results:
                print(f"No Pokemon found with type '{type_name}'.")
            else:
                print(f"\n{type_name}-type Pokemon found: {len(results)}\n")
                # Print table header
                print(f"{'ID':<5} {'Nickname':<15} {'Species':<15} {'Type':<20} {'Level':<7} {'Trainer':<20}")
                print("-" * 90)
                # Print table rows
                for row in results:
                    secondary_type = f"/{row['SecondaryType']}" if row['SecondaryType'] else ""
                    type_str = f"{row['PrimaryType']}{secondary_type}"
                    print(f"{row['PokemonID']:<5} {row['Nickname']:<15} {row['SpeciesName']:<15} {type_str:<20} {row['Level']:<7} {row['TrainerName']:<20}")
    except pymysql.Error as e:
        print(f"Error during query: {e}", file=sys.stderr)

def view_trainer_badges(connection):
    """READ 5: View all badges earned by a trainer."""
    print("\n--- Trainer Badges ---")
    trainer_name = input("Enter trainer name: ").strip()
    
    try:
        with connection.cursor() as cursor:
            sql_query = """
                SELECT tbc.BadgeNumber, tbc.BadgeName, g.GymName, tbc.EarnedDate
                FROM TRAINER_BADGE_COLLECTION tbc
                JOIN TRAINER t ON tbc.TrainerID = t.TrainerID
                JOIN GYM g ON tbc.GymID = g.GymID
                WHERE t.TrainerName = %s
                ORDER BY tbc.BadgeNumber
            """
            cursor.execute(sql_query, (trainer_name,))
            results = cursor.fetchall()
            
            if not results:
                print(f"No badges found for trainer '{trainer_name}'.")
            else:
                print(f"\nBadges earned by {trainer_name}: {len(results)}/8\n")
                # Print table header
                print(f"{'Badge#':<8} {'Badge Name':<20} {'Gym':<30} {'Earned Date':<15}")
                print("-" * 80)
                # Print table rows
                for row in results:
                    print(f"{row['BadgeNumber']:<8} {row['BadgeName']:<20} {row['GymName']:<30} {str(row['EarnedDate']):<15}")
    except pymysql.Error as e:
        print(f"Error during query: {e}", file=sys.stderr)

def view_tournament_results(connection):
    """READ 6: View tournament participation and results."""
    print("\n--- Tournament Results ---")
    try:
        with connection.cursor() as cursor:
            sql_query = """
                SELECT t.TournamentName, tr.TrainerName, p.PlacementRank, 
                       p.RoundsWon, p.IsEliminated, tour.TournamentStatus
                FROM PARTICIPATES_IN p
                JOIN TOURNAMENT t ON p.TournamentID = t.TournamentID
                JOIN TRAINER tr ON p.TrainerID = tr.TrainerID
                JOIN TOURNAMENT tour ON t.TournamentID = tour.TournamentID
                ORDER BY t.TournamentName, p.PlacementRank
            """
            cursor.execute(sql_query)
            results = cursor.fetchall()
            
            if not results:
                print("No tournament results found.")
            else:
                print(f"\nTotal Tournament Entries: {len(results)}\n")
                # Print table header
                print(f"{'Tournament':<30} {'Trainer':<20} {'Rank':<6} {'Rounds Won':<12} {'Status':<12} {'Tournament Status':<18}")
                print("-" * 110)
                # Print table rows
                for row in results:
                    status = "Eliminated" if row['IsEliminated'] else "Active"
                    print(f"{row['TournamentName']:<30} {row['TrainerName']:<20} {row['PlacementRank']:<6} {row['RoundsWon']:<12} {status:<12} {row['TournamentStatus']:<18}")
    except pymysql.Error as e:
        print(f"Error during query: {e}", file=sys.stderr)

def view_pokemon_moves(connection):
    """READ 7: View all moves for a specific Pokemon."""
    print("\n--- Pokemon Moves ---")
    nickname = input("Enter Pokemon nickname: ").strip()
    
    try:
        with connection.cursor() as cursor:
            sql_query = """
                SELECT p.Nickname, ps.SpeciesName, pm.MoveSlotNumber, 
                       m.MoveName, pt.TypeName as MoveType, m.MovePower
                FROM POKEMON p
                JOIN POKEMON_SPECIES ps ON p.SpeciesID = ps.SpeciesID
                JOIN POKEMON_MOVE pm ON p.PokemonID = pm.PokemonID
                JOIN MOVE m ON pm.MoveID = m.MoveID
                JOIN POKEMON_TYPE pt ON m.MoveTypeID = pt.TypeID
                WHERE p.Nickname = %s
                ORDER BY pm.MoveSlotNumber
            """
            cursor.execute(sql_query, (nickname,))
            results = cursor.fetchall()
            
            if not results:
                print(f"No moves found for Pokemon '{nickname}'.")
            else:
                print(f"\nMoves for {results[0]['Nickname']} ({results[0]['SpeciesName']}):\n")
                # Print table header
                print(f"{'Slot':<6} {'Move Name':<25} {'Type':<12} {'Power':<10}")
                print("-" * 60)
                # Print table rows
                for row in results:
                    power = str(row['MovePower']) if row['MovePower'] else "Status"
                    print(f"{row['MoveSlotNumber']:<6} {row['MoveName']:<25} {row['MoveType']:<12} {power:<10}")
    except pymysql.Error as e:
        print(f"Error during query: {e}", file=sys.stderr)

# ============================================
# WRITE OPERATIONS (3+ Update Functions)
# ============================================

def add_new_trainer(connection):
    """WRITE 1: INSERT - Add a new trainer to the database."""
    print("\n--- Register New Trainer ---")
    
    try:
        trainer_name = input("Enter trainer name: ").strip()
        reg_number = input("Enter registration number (e.g., TRN-XXX-YY): ").strip()
        email = input("Enter contact email: ").strip()
        
        # Show available locations
        with connection.cursor() as cursor:
            sql_query = "SELECT LocationID, City, Region FROM LOCATION ORDER BY Region, City"
            cursor.execute(sql_query)
            locations = cursor.fetchall()
            print("\nAvailable Locations:")
            for loc in locations[:10]:  # Show first 10
                print(f"  {loc['LocationID']}: {loc['City']}, {loc['Region']}")
        
        hometown_id = input("Enter hometown LocationID: ").strip()
        
        # Get experience level
        print("\nExperience Levels: Novice, Intermediate, Advanced, Expert, Master")
        exp_level = input("Enter experience level [Novice]: ").strip() or "Novice"
        
        with connection.cursor() as cursor:
            sql_query = """
                INSERT INTO TRAINER (RegistrationNumber, TrainerName, HometownLocationID, 
                                    RegistrationDate, ExperienceLevel, TotalBadges, ContactEmail)
                VALUES (%s, %s, %s, %s, %s, %s, %s)
            """
            reg_date = date.today()
            cursor.execute(sql_query, (reg_number, trainer_name, hometown_id, 
                                      reg_date, exp_level, 0, email))
            connection.commit()
            
            print(f"\n✓ Trainer '{trainer_name}' successfully registered with ID: {cursor.lastrowid}")
    
    except pymysql.Error as e:
        connection.rollback()
        print(f"Error inserting trainer: {e}", file=sys.stderr)
    except Exception as e:
        connection.rollback()
        print(f"Invalid input: {e}", file=sys.stderr)

def catch_new_pokemon(connection):
    """WRITE 2: INSERT - Add a newly caught Pokemon."""
    print("\n--- Catch New Pokemon ---")
    
    try:
        # Show available trainers
        with connection.cursor() as cursor:
            sql_query = "SELECT TrainerID, TrainerName FROM TRAINER ORDER BY TrainerID DESC"
            cursor.execute(sql_query)
            trainers = cursor.fetchall()
            print("\nAvailable Trainers (showing all):")
            for t in trainers:  # Show all trainers
                print(f"  {t['TrainerID']}: {t['TrainerName']}")
        
        trainer_id = int(input("Enter trainer ID: ").strip())
        
        # Show available species
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT ps.SpeciesID, ps.SpeciesName, pt.TypeName 
                FROM POKEMON_SPECIES ps
                JOIN POKEMON_TYPE pt ON ps.PrimaryTypeID = pt.TypeID
                ORDER BY ps.SpeciesName
            """)
            species = cursor.fetchall()
            print("\nAvailable Species:")
            for s in species[:15]:  # Show first 15
                print(f"  {s['SpeciesID']}: {s['SpeciesName']} ({s['TypeName']})")
        
        species_id = int(input("Enter species ID: ").strip())
        nickname = input("Enter nickname for Pokemon: ").strip()
        level = int(input("Enter level [1]: ").strip() or "1")
        
        # Get species base HP
        with connection.cursor() as cursor:
            sql_query = "SELECT BaseMaxHP FROM POKEMON_SPECIES WHERE SpeciesID = %s"
            cursor.execute(sql_query, (species_id,))
            result = cursor.fetchone()
            base_hp = result['BaseMaxHP'] if result else 50
        
        current_hp = base_hp + (level * 2)
        
        # Show available locations
        with connection.cursor() as cursor:
            sql_query = "SELECT LocationID, City FROM LOCATION LIMIT 10"
            cursor.execute(sql_query)
            locations = cursor.fetchall()
            print("\nCatch Locations:")
            for loc in locations:
                print(f"  {loc['LocationID']}: {loc['City']}")
        
        location_id = int(input("Enter catch location ID: ").strip())
        catch_date = date.today()
        
        # Insert Pokemon
        with connection.cursor() as cursor:
            sql_query = """
                INSERT INTO POKEMON (TrainerID, SpeciesID, Nickname, Level, 
                                    ExperiencePoints, CurrentHP, IsShiny, CatchDate, FriendshipLevel)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
            """
            cursor.execute(sql_query, (trainer_id, species_id, nickname, level, 
                                      0, current_hp, False, catch_date, 0))
            pokemon_id = cursor.lastrowid
            
            # Insert OWNS relationship
            sql_owns = """
                INSERT INTO OWNS (TrainerID, PokemonID, AcquisitionDate, CatchLocationID, IsInActiveParty)
                VALUES (%s, %s, %s, %s, %s)
            """
            cursor.execute(sql_owns, (trainer_id, pokemon_id, catch_date, location_id, False))
            
            connection.commit()
            print(f"\n✓ Pokemon '{nickname}' caught successfully! Pokemon ID: {pokemon_id}")
    
    except pymysql.Error as e:
        connection.rollback()
        print(f"Error catching Pokemon: {e}", file=sys.stderr)
    except Exception as e:
        connection.rollback()
        print(f"Invalid input: {e}", file=sys.stderr)

def update_pokemon_level(connection):
    """WRITE 3: UPDATE - Level up a Pokemon."""
    print("\n--- Level Up Pokemon ---")
    
    nickname = input("Enter Pokemon nickname to level up: ").strip()
    
    try:
        with connection.cursor() as cursor:
            # Check if Pokemon exists
            sql_query = "SELECT PokemonID, Level FROM POKEMON WHERE Nickname = %s"
            cursor.execute(sql_query, (nickname,))
            result = cursor.fetchone()
            
            if not result:
                print(f"Pokemon '{nickname}' not found.")
                return
            
            current_level = result['Level']
            print(f"Current level: {current_level}")
            new_level = int(input("Enter new level: ").strip())
            
            if new_level <= current_level:
                print("New level must be higher than current level.")
                return
            
            exp_gain = (new_level - current_level) * 1000
            
            sql_query = """
                UPDATE POKEMON 
                SET Level = %s, 
                    ExperiencePoints = ExperiencePoints + %s,
                    CurrentHP = CurrentHP + %s
                WHERE Nickname = %s
            """
            hp_increase = (new_level - current_level) * 2
            cursor.execute(sql_query, (new_level, exp_gain, hp_increase, nickname))
            connection.commit()
            
            print(f"\n✓ {nickname} leveled up from {current_level} to {new_level}!")
            print(f"  Experience gained: {exp_gain}")
            print(f"  HP increased by: {hp_increase}")
    
    except pymysql.Error as e:
        connection.rollback()
        print(f"Error updating Pokemon: {e}", file=sys.stderr)
    except Exception as e:
        connection.rollback()
        print(f"Invalid input: {e}", file=sys.stderr)

def earn_gym_badge(connection):
    """WRITE 4: INSERT - Record a gym badge earned by trainer."""
    print("\n--- Earn Gym Badge ---")
    
    try:
        # Show trainers
        with connection.cursor() as cursor:
            sql_query = "SELECT TrainerID, TrainerName, TotalBadges FROM TRAINER"
            cursor.execute(sql_query)
            trainers = cursor.fetchall()
            print("\nTrainers:")
            for t in trainers[:10]:
                print(f"  {t['TrainerID']}: {t['TrainerName']} (Badges: {t['TotalBadges']})")
        
        trainer_id = int(input("Enter trainer ID: ").strip())
        
        # Show gyms
        with connection.cursor() as cursor:
            sql_query = "SELECT GymID, GymName, BadgeName FROM GYM"
            cursor.execute(sql_query)
            gyms = cursor.fetchall()
            print("\nGyms:")
            for g in gyms:
                print(f"  {g['GymID']}: {g['GymName']} - {g['BadgeName']}")
        
        gym_id = int(input("Enter gym ID: ").strip())
        
        # Get badge details and current trainer badge count
        with connection.cursor() as cursor:
            sql_query = "SELECT BadgeName FROM GYM WHERE GymID = %s"
            cursor.execute(sql_query, (gym_id,))
            gym_result = cursor.fetchone()
            badge_name = gym_result['BadgeName']
            
            # Get current badge count from TRAINER table
            sql_trainer = "SELECT TotalBadges FROM TRAINER WHERE TrainerID = %s"
            cursor.execute(sql_trainer, (trainer_id,))
            current_badges = cursor.fetchone()['TotalBadges']
            new_badge_count = current_badges + 1
            badge_number = new_badge_count
            
            # Insert badge
            sql_query = """
                INSERT INTO TRAINER_BADGE_COLLECTION (TrainerID, BadgeNumber, BadgeName, GymID, EarnedDate)
                VALUES (%s, %s, %s, %s, %s)
            """
            cursor.execute(sql_query, (trainer_id, badge_number, badge_name, gym_id, date.today()))
            
            # Update trainer's badge count
            sql_update = "UPDATE TRAINER SET TotalBadges = %s WHERE TrainerID = %s"
            cursor.execute(sql_update, (new_badge_count, trainer_id))
            
            # Record challenge
            sql_challenge = """
                INSERT INTO CHALLENGES (TrainerID, GymID, ChallengeDate, ChallengeResult, AttemptsCount, BadgeEarned)
                VALUES (%s, %s, %s, %s, %s, %s)
                ON DUPLICATE KEY UPDATE ChallengeResult = 'Victory', BadgeEarned = TRUE
            """
            cursor.execute(sql_challenge, (trainer_id, gym_id, datetime.now(), 'Victory', 1, True))
            
            connection.commit()
            print(f"\n✓ Badge '{badge_name}' earned! Total badges: {new_badge_count}")
    
    except pymysql.Error as e:
        connection.rollback()
        print(f"Error recording badge: {e}", file=sys.stderr)
    except Exception as e:
        connection.rollback()
        print(f"Invalid input: {e}", file=sys.stderr)

def delete_pokemon(connection):
    """WRITE 5: DELETE - Release a Pokemon."""
    print("\n--- Release Pokemon ---")
    
    nickname = input("Enter Pokemon nickname to release: ").strip()
    confirm = input(f"Are you sure you want to release '{nickname}'? (yes/no): ").strip().lower()
    
    if confirm != 'yes':
        print("Release cancelled.")
        return
    
    try:
        with connection.cursor() as cursor:
            # Check if Pokemon exists
            sql_query = "SELECT PokemonID, Nickname FROM POKEMON WHERE Nickname = %s"
            cursor.execute(sql_query, (nickname,))
            result = cursor.fetchone()
            
            if not result:
                print(f"Pokemon '{nickname}' not found.")
                return
            
            sql_query = "DELETE FROM POKEMON WHERE Nickname = %s"
            cursor.execute(sql_query, (nickname,))
            connection.commit()
            
            print(f"\n✓ Pokemon '{nickname}' has been released.")
    
    except pymysql.Error as e:
        connection.rollback()
        print(f"Error releasing Pokemon: {e}", file=sys.stderr)

def update_trainer_info(connection):
    """WRITE 6: UPDATE - Update trainer contact information."""
    print("\n--- Update Trainer Info ---")
    
    trainer_name = input("Enter trainer name: ").strip()
    
    try:
        with connection.cursor() as cursor:
            # Check if trainer exists
            sql_query = "SELECT TrainerID, ContactEmail FROM TRAINER WHERE TrainerName = %s"
            cursor.execute(sql_query, (trainer_name,))
            result = cursor.fetchone()
            
            if not result:
                print(f"Trainer '{trainer_name}' not found.")
                return
            
            print(f"Current email: {result['ContactEmail']}")
            new_email = input("Enter new email: ").strip()
            
            sql_query = "UPDATE TRAINER SET ContactEmail = %s WHERE TrainerName = %s"
            cursor.execute(sql_query, (new_email, trainer_name))
            connection.commit()
            
            print(f"\n✓ Trainer '{trainer_name}' email updated to {new_email}")
    
    except pymysql.Error as e:
        connection.rollback()
        print(f"Error updating trainer: {e}", file=sys.stderr)

# ============================================
# MAIN CLI INTERFACE
# ============================================

def main_cli(connection):
    """The main command-line interface loop."""
    try:
        while True:
            print("\n" + "=" * 60)
            print("     POKÉMON DATABASE MANAGEMENT SYSTEM")
            print("=" * 60)
            print("\n--- READ OPERATIONS (Queries) ---")
            print("1: View All Trainers")
            print("2: Search Trainer's Pokemon")
            print("3: View Gym Leaders and Gyms")
            print("4: Search Pokemon by Type")
            print("5: View Trainer Badges")
            print("6: View Tournament Results")
            print("7: View Pokemon Moves")
            
            print("\n--- WRITE OPERATIONS (Updates) ---")
            print("8: Register New Trainer (INSERT)")
            print("9: Catch New Pokemon (INSERT)")
            print("10: Level Up Pokemon (UPDATE)")
            print("11: Earn Gym Badge (INSERT)")
            print("12: Release Pokemon (DELETE)")
            print("13: Update Trainer Info (UPDATE)")
            
            print("\n--- EXIT ---")
            print("q: Quit Application")
            print("=" * 60)
            
            choice = input("\nEnter your choice: ").strip().lower()
            
            if choice == '1':
                view_all_trainers(connection)
            elif choice == '2':
                search_trainer_pokemon(connection)
            elif choice == '3':
                view_gym_leaders_and_gyms(connection)
            elif choice == '4':
                search_pokemon_by_type(connection)
            elif choice == '5':
                view_trainer_badges(connection)
            elif choice == '6':
                view_tournament_results(connection)
            elif choice == '7':
                view_pokemon_moves(connection)
            elif choice == '8':
                add_new_trainer(connection)
            elif choice == '9':
                catch_new_pokemon(connection)
            elif choice == '10':
                update_pokemon_level(connection)
            elif choice == '11':
                earn_gym_badge(connection)
            elif choice == '12':
                delete_pokemon(connection)
            elif choice == '13':
                update_trainer_info(connection)
            elif choice == 'q':
                print("\nExiting application...")
                break
            else:
                print("\n⚠ Invalid choice. Please try again.")
    
    finally:
        if connection:
            connection.close()
            print("Database connection closed.")

# ============================================
# APPLICATION ENTRY POINT
# ============================================

if __name__ == "__main__":
    DB_HOST = 'localhost'
    DB_NAME = 'mini_world_db'
    
    print("=" * 60)
    print("  POKÉMON DATABASE MANAGEMENT SYSTEM")
    print("=" * 60)
    print("\nPlease enter your MySQL credentials.")
    
    DB_USER = input("Username: ").strip()
    DB_PASS = getpass("Password: ")
    
    db_conn = get_db_connection(DB_USER, DB_PASS, DB_HOST, DB_NAME)
    
    if db_conn:
        main_cli(db_conn)
    else:
        print("Failed to connect to the database. Application will exit.")
        sys.exit(1)
