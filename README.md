# Pokémon Database Management System 🎮

**Phase 4 Database Project - Complete Implementation**

---

##  Project Overview

A comprehensive database management system for a **Pokémon Battle League** universe, designed in **strict Third Normal Form (3NF)** with a Python command-line interface for data management and queries.

**Domain:** Pokémon Trainer Management System  
**Database:** MySQL 8.0  
**Application:** Python 3.12 with PyMySQL  
**Total Tables:** 27 (highly normalized)  
**Total Records:** 500+ realistic entries  

---

##  Project Structure

```
DNA/
├── schema2.sql                    # Complete 3NF database schema (27 tables)
├── populate.sql                   # 500+ records of sample data
├── main_app.py                    # Python CLI application (13 operations)
├── VIDEO_RECORDING_GUIDE.md       # Step-by-step video demo script
├── MYSQL_WORKBENCH_QUERIES.md     # All SQL queries for verification
└── README.md                      # This file
```

---

##  Database Schema Highlights

### **Strict Third Normal Form (3NF) Design**

**27 Tables organized into:**

1. **Lookup Tables (5):** LOCATION, POKEMON_TYPE, POKEMON_SPECIES, MOVE_CATEGORY, ITEM_CATEGORY
2. **Strong Entities (6):** TRAINER, POKEMON, GYM_LEADER, GYM, TOURNAMENT, ITEM
3. **Pricing Table (1):** ITEM_PRICING (multi-valued attributes)
4. **Weak Entities (2):** TRAINER_BADGE_COLLECTION (badges earned), MOVE (Pokemon moves)
5. **Subclass Tables (2):** CONSUMABLE_ITEM, EQUIPMENT_ITEM
6. **Binary Relationships (8):** OWNS, LEADS, CHALLENGES, USES_ITEM, HOLDS_ITEM, POKEMON_MOVE, MOVE_EFFECTIVENESS, BATTLE_PARTICIPATION
7. **N-ary Relationships (4):** PARTICIPATES_IN (Tournament), BATTLE (3-way), BATTLE_STAGE (Tournament brackets), POKEMON_WEAKNESS (Type effectiveness)

### **Key Features:**
-  All foreign key constraints with proper CASCADE/RESTRICT/SET NULL
-  Zero data redundancy (full normalization)
-  Realistic Pokemon domain with Trainers, Gyms, Tournaments, Battles
-  Complex relationships: Trainers own Pokemon, challenge Gyms, earn Badges, participate in Tournaments

---

## 💻 Python Application Features

### **Command-Line Interface (CLI)**

**7 READ Operations** (Exceeds 5 minimum requirement):
1. **View All Trainers** - Display all registered trainers with hometown, badges, experience level
2. **Search Trainer's Pokemon** - View all Pokemon owned by a specific trainer
3. **View Gym Leaders and Gyms** - List all 8 gyms with leaders, specialties, difficulty
4. **Search Pokemon by Type** - Find all Pokemon of a specific type (Fire, Water, etc.)
5. **View Trainer Badges** - Display badges earned by a trainer
6. **View Tournament Results** - Show tournament rankings and participation
7. **View Pokemon Moves** - List all moves learned by a Pokemon

**6 WRITE Operations** (Exceeds 3 minimum requirement):
1. **Register New Trainer (INSERT)** - Add new trainer with registration details
2. **Catch New Pokemon (INSERT)** - Record newly caught Pokemon with ownership
3. **Level Up Pokemon (UPDATE)** - Increase Pokemon level, EXP, HP
4. **Earn Gym Badge (INSERT)** - Record badge earned from gym challenge
5. **Release Pokemon (DELETE)** - Remove Pokemon from database
6. **Update Trainer Info (UPDATE)** - Modify trainer contact information

### **Technical Implementation:**
-  **Parameterized queries** using `%s` placeholders (prevents SQL injection)
-  **Manual transaction management** with `connection.commit()` and `rollback()`
-  **DictCursor** for readable dictionary-based results
-  **Error handling** with try-except blocks
-  **Dynamic credential input** (portable across systems)
-  **Table-formatted output** with aligned columns and headers

---

##  Setup Instructions

### **1. Prerequisites**
```bash
# MySQL 8.0 or higher
# Python 3.12 or higher
# PyMySQL library
```

### **2. Install Python Dependencies**
```bash
# Create virtual environment (optional but recommended)
python3 -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate

# Install PyMySQL
pip install pymysql
```

### **3. Database Setup**
```bash
# Login to MySQL
mysql -u root -p

# Run schema creation
source schema2.sql

# Populate with sample data
source populate.sql
```

### **4. Run Application**
```bash
python main_app.py
```

**Login Credentials:**
- **Username:** root (or your MySQL username)
- **Password:** Your MySQL password
- **Database:** mini_world_db (auto-connected)

---

##  Sample Data Included

### **Trainers:** 16 trainers including:
- Ash Ketchum (8 badges, Expert level)
- Gary Oak (8 badges, Expert level)
- Misty, Brock, Red, Blue (Gym Leaders & Champions)

### **Pokemon:** 35+ Pokemon including:
- Pikachu, Charizard, Blastoise, Gyarados
- Various levels (1-75), types, and stats
- Shiny variants and active party tracking

### **Gyms:** 8 Official Kanto Gyms:
- Pewter (Rock), Cerulean (Water), Vermilion (Electric)
- Celadon (Grass), Fuchsia (Poison), Saffron (Psychic)
- Cinnabar (Fire), Viridian (Ground)

### **Other Data:**
- 18 Pokemon Types, 50+ Moves, 20+ Items
- 3 Tournaments (Indigo Plateau, Silver Conference, etc.)
- 100+ Battle records with outcomes

---

## 🎬 Video Demonstration Guide

Two comprehensive documentation files included:

1. **VIDEO_RECORDING_GUIDE.md**
   - Complete 5-minute script with timing
   - Narration for each operation
   - BEFORE→EXECUTE→AFTER demonstration pattern
   - Pre-recording setup checklist

2. **MYSQL_WORKBENCH_QUERIES.md**
   - All SQL queries for MySQL Workbench verification
   - BEFORE/AFTER queries for each WRITE operation
   - Direct MySQL equivalents of Python operations
   - Quick copy-paste reference section

---

##  Usage Examples

### **Example 1: View All Trainers**
```
Enter your choice: 1

Total Trainers: 17

ID    Name                 Reg Number      Level           Badges   City                 Region    
--------------------------------------------------------------------------------------------------------------
1     Ash Ketchum          TRN-001-KT      Expert          8        Pallet Town          Kanto     
2     Gary Oak             TRN-002-KT      Expert          8        Pallet Town          Kanto     
19    Tilak                TRN-016-KT      Master          0        Lavender Town        Kanto     
22    santhosh             TRN-152-KT      Expert          0        New Bark Town        Johto     
```

### **Example 2: Search Trainer's Pokemon**
```
Enter your choice: 2
Enter trainer name to search: Ash Ketchum

Pokemon owned by Ash Ketchum: 4

ID    Nickname        Species         Type                 Level   HP     Shiny   Active  
----------------------------------------------------------------------------------------------------
3     Charizard       Charizard       Fire/Flying          65      265    No      Yes     
1     Pikachu         Pikachu         Electric             55      175    No      Yes     
2     Butterfree      Butterfree      Bug/Flying           35      115    No      No      
4     Snorlax         Snorlax         Normal               50      320    No      Yes     
```

### **Example 3: Catch New Pokemon**
```
Enter your choice: 9
Enter trainer ID: 22
Enter species ID: 10 (Caterpie)
Enter nickname: Sparky
Enter level: 10

 Pokemon 'Sparky' caught successfully! Pokemon ID: 38
```

### **Example 4: Level Up Pokemon**
```
Enter your choice: 10
Enter Pokemon nickname: Sparky
Enter new level: 20

 Pokemon 'Sparky' leveled up to 20!
  - Experience gained: +10,000
  - HP increased: 55 → 75
```

---

##  Key SQL Queries

### **Complex JOIN Example (READ 2):**
```sql
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
ORDER BY p.Level DESC;
```

### **Parameterized INSERT Example (WRITE 1):**
```sql
INSERT INTO TRAINER (RegistrationNumber, TrainerName, HometownLocationID, 
                    RegistrationDate, ExperienceLevel, TotalBadges, ContactEmail)
VALUES (%s, %s, %s, %s, %s, %s, %s);
```

### **Parameterized UPDATE Example (WRITE 3):**
```sql
UPDATE POKEMON 
SET Level = %s, 
    ExperiencePoints = ExperiencePoints + %s,
    CurrentHP = CurrentHP + %s
WHERE Nickname = %s;
```

---

##  Phase 4 Requirements Compliance

| Requirement | Implementation | Status |
|-------------|----------------|--------|
| Minimum 5 READ operations | 7 READ operations |  Exceeds |
| Minimum 3 WRITE operations | 6 WRITE operations (2 INSERT, 2 UPDATE, 1 DELETE) |  Exceeds |
| Parameterized queries | All queries use `%s` placeholders |  Complete |
| Transaction management | Manual commit/rollback throughout |  Complete |
| No ORM usage | Pure PyMySQL with raw SQL |  Complete |
| Database persistence | All changes immediately visible in MySQL |  Verified |
| Error handling | Try-except blocks on all operations |  Complete |
| 3NF Schema | 27 tables, zero redundancy |  Complete |
| 500+ records | Populated with realistic data |  Complete |

---

##  Technical Details

### **Database Connection:**
```python
connection = pymysql.connect(
    host='localhost',
    user=input("Username: "),
    password=getpass("Password: "),
    database='mini_world_db',
    cursorclass=pymysql.cursors.DictCursor,
    autocommit=False  # Manual transaction control
)
```

### **Query Execution Pattern:**
```python
with connection.cursor() as cursor:
    sql_query = "SELECT ... WHERE column = %s"
    cursor.execute(sql_query, (parameter,))
    results = cursor.fetchall()
    
    # For writes:
    connection.commit()  # Makes changes persistent
```

### **Error Handling:**
```python
try:
    # Database operations
    connection.commit()
except pymysql.Error as e:
    connection.rollback()
    print(f"Error: {e}", file=sys.stderr)
```

---

## 🎓 Learning Outcomes

This project demonstrates:
-  **Database normalization** to Third Normal Form
-  **Complex multi-table queries** with multiple JOINs
-  **Python-MySQL integration** using PyMySQL
-  **SQL injection prevention** via parameterized queries
-  **Transaction management** for data integrity
-  **CLI application design** with user-friendly interface
-  **Relational database design** for real-world domain
-  **Foreign key constraints** and referential integrity

---

##  Support & Documentation

- **Schema Reference:** See `schema2.sql` for complete table definitions
- **Sample Data:** See `populate.sql` for all INSERT statements
- **Video Guide:** See `VIDEO_RECORDING_GUIDE.md` for demonstration script
- **MySQL Queries:** See `MYSQL_WORKBENCH_QUERIES.md` for verification queries

---

##  Project Statistics

```
Total Tables:        27
Total Records:       500+
Total Code Lines:    1,050+ (Python + SQL)
Foreign Keys:        35+
READ Operations:     7
WRITE Operations:    6
Normalization:       3NF (Strict)
Database Engine:     InnoDB
Character Set:       utf8mb4
```

---

##  Testing & Verification

All operations have been manually tested and verified:

 **Database Persistence:** Changes made in Python app immediately visible in MySQL Workbench  
 **Referential Integrity:** Foreign key constraints working correctly (CASCADE deletes)  
 **Transaction Safety:** Rollback on errors prevents partial updates  
 **Data Validation:** Input validation and error messages for invalid data  
 **Query Correctness:** All queries return accurate results matching schema design  

---

##  License & Academic Use

**Academic Project** - Created for Database Management Systems Course (Phase 4)  
Free to reference for educational purposes.

---

**Project Completed:** November 2025  
**Database:** mini_world_db  
**Theme:** Pokémon Battle League Management System  
**Status:**  Production Ready

---
