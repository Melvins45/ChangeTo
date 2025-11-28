# SQL to Sequelize Generator - Updates Summary

## Changes Made

### 1. **Code Filtering**
- Now **ignores all lines except**:
  - CREATE TABLE statements
  - PRIMARY KEY definitions
  - FOREIGN KEY constraints
  - KEY/INDEX definitions
- Removed processing of other ALTER TABLE statements and auxiliary SQL commands

### 2. **Separate File Generation**
- **Migrations**: Each table gets its own migration file
  - Format: `{timestamp}-create-{tablename}.js`
  - Located in `migrations/` directory
  
- **Models**: Each table gets its own model file
  - Format: `{tablename}.js`
  - Located in `models/` directory

### 3. **ZIP Output**
- All generated files are automatically packaged into a ZIP file
- ZIP filename: `sequelize-generated-{YYYYMMDD_HHMMSS}.zip`
- ZIP structure:
  ```
  sequelize-generated-{timestamp}.zip
  ├── migrations/
  │   ├── {timestamp}-create-table1.js
  │   ├── {timestamp}-create-table2.js
  │   └── ...
  └── models/
      ├── table1.js
      ├── table2.js
      └── ...
  ```

### 4. **Enhanced Migration Files**
- Includes proper type mapping for all SQL types
- Adds `createdAt` and `updatedAt` timestamps automatically
- Proper handling of:
  - PRIMARY KEY with auto-increment
  - FOREIGN KEY constraints with CASCADE/SET NULL rules
  - Column constraints (NOT NULL, etc.)
  - Type conversion (INT, VARCHAR, TEXT, DATE, etc.)

### 5. **Enhanced Model Files**
- Uses Sequelize's standard model format
- Includes association templates for foreign keys (commented out for manual configuration)
- Proper DataTypes mapping
- Timestamps enabled by default

### 6. **UI Improvements**
- Button text updated: "Générer Sequelize & ZIP"
- Success message shows ZIP file location
- Error handling with proper dialogs
- Display of generated files structure

## Features

✓ Automatic file generation from SQL dump  
✓ One migration file per table  
✓ One model file per table  
✓ ZIP compression of all files  
✓ Automatic cleanup of temporary files  
✓ Full type mapping support  
✓ Primary and foreign key preservation  

## Usage

1. Click "Charger fichier SQL" to load your SQL file
2. Click "Générer Sequelize & ZIP" to generate files
3. A ZIP file will be created with all migrations and models
4. Extract and place in your Sequelize project structure

## Files Generated

For each table in your SQL:
- **Migration**: Sequelize migration file with full schema definition
- **Model**: Sequelize model file with associations templates

All files follow Sequelize best practices and conventions.
