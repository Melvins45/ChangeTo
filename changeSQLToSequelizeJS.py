import re
import os
import zipfile
import tkinter as tk
from tkinter import filedialog, scrolledtext, messagebox
from datetime import datetime

class SQLToSequelizeApp:
    def __init__(self, root):
        self.root = root
        self.root.title("SQL → Sequelize Generator")

        # Bouton pour charger un fichier SQL
        self.load_btn = tk.Button(root, text="Charger fichier SQL", command=self.load_sql)
        self.load_btn.pack(pady=10)

        # Zone de texte pour afficher le SQL
        self.sql_text = scrolledtext.ScrolledText(root, width=100, height=20)
        self.sql_text.pack(pady=10)

        # Bouton pour générer Sequelize
        self.gen_btn = tk.Button(root, text="Générer Sequelize & ZIP", command=self.generate)
        self.gen_btn.pack(pady=10)

        # Zone de texte pour afficher le résultat
        self.result_text = scrolledtext.ScrolledText(root, width=100, height=25)
        self.result_text.pack(pady=10)

    def load_sql(self):
        file_path = filedialog.askopenfilename(filetypes=[("SQL files", "*.sql")])
        if file_path:
            with open(file_path, "r", encoding="utf-8") as f:
                sql = f.read()
            self.sql_text.delete("1.0", tk.END)
            self.sql_text.insert(tk.END, sql)

    def generate(self):
        sql = self.sql_text.get("1.0", tk.END)
        zip_path = self.sql_to_sequelize(sql)
        if zip_path:
            self.result_text.delete("1.0", tk.END)
            self.result_text.insert(tk.END, f"✓ ZIP file created successfully!\n\n")
            self.result_text.insert(tk.END, f"Location: {zip_path}\n\n")
            self.result_text.insert(tk.END, "Files included in ZIP:\n")
            self.result_text.insert(tk.END, "- migrations/ (one file per table)\n")
            self.result_text.insert(tk.END, "- models/ (one file per table)\n")
            messagebox.showinfo("Success", f"Files generated and zipped!\n\n{zip_path}")

    def clean_sql(self, sql: str) -> str:
        # Supprimer les commentaires SQL
        sql = re.sub(r"--.*", "", sql)          # commentaires ligne "--"
        sql = re.sub(r"#.*", "", sql)           # commentaires ligne "#"
        sql = re.sub(r"/\*.*?\*/", "", sql, flags=re.S)  # commentaires bloc "/* ... */"
        return sql

    def parse_create_table(self, body: str) -> dict:
        """Parse CREATE TABLE body and extract columns, primary keys, and foreign keys"""
        columns = {}
        primary_keys = []
        foreign_keys = {}
        
        for line in body.split(","):
            line = line.strip()
            if not line:
                continue
                
            # PRIMARY KEY
            if line.upper().startswith("PRIMARY KEY"):
                match = re.search(r"PRIMARY KEY\s*\((.*?)\)", line, re.I)
                if match:
                    primary_keys = [col.strip("`\"'") for col in match.group(1).split(",")]
            
            # FOREIGN KEY (inline)
            elif line.upper().startswith("FOREIGN KEY"):
                match = re.search(r"FOREIGN KEY\s*\((.*?)\)\s*REFERENCES\s*(\w+)\s*\((.*?)\)", line, re.I)
                if match:
                    col = match.group(1).strip("`\"'")
                    ref_table = match.group(2).strip("`\"'")
                    ref_col = match.group(3).strip("`\"'")
                    foreign_keys[col] = {"table": ref_table, "column": ref_col}
            
            # UNIQUE KEY or KEY (index)
            elif line.upper().startswith(("KEY", "UNIQUE")):
                pass  # Skip keys for now
            
            # Column definition
            elif not line.upper().startswith(("FOREIGN", "PRIMARY", "KEY", "UNIQUE", "INDEX")):
                parts = line.split()
                if len(parts) >= 2:
                    col_name = parts[0].strip("`\"'")
                    col_type = parts[1].upper()
                    
                    # Extract size if present
                    size = None
                    if "(" in col_type:
                        base_type, size = col_type.split("(")
                        col_type = base_type
                        size = size.rstrip(")")
                    
                    # Check for NOT NULL and AUTO_INCREMENT
                    is_null = True
                    is_auto = False
                    for part in parts[2:]:
                        if part.upper() == "NOT":
                            is_null = False
                        elif part.upper() == "AUTO_INCREMENT":
                            is_auto = True
                    
                    columns[col_name] = {
                        "type": col_type,
                        "size": size,
                        "nullable": is_null,
                        "autoIncrement": is_auto
                    }
        
        return {
            "columns": columns,
            "primaryKeys": primary_keys,
            "foreignKeys": foreign_keys
        }

    def get_sequelize_type(self, sql_type: str, size: str = None) -> str:
        """Convert SQL type to Sequelize type"""
        type_map = {
            "INT": "Sequelize.INTEGER",
            "INTEGER": "Sequelize.INTEGER",
            "BIGINT": "Sequelize.BIGINT",
            "SMALLINT": "Sequelize.INTEGER",
            "VARCHAR": "Sequelize.STRING",
            "CHAR": "Sequelize.STRING",
            "TEXT": "Sequelize.TEXT",
            "LONGTEXT": "Sequelize.TEXT",
            "FLOAT": "Sequelize.FLOAT",
            "DOUBLE": "Sequelize.DOUBLE",
            "DECIMAL": "Sequelize.DECIMAL",
            "DATE": "Sequelize.DATE",
            "DATETIME": "Sequelize.DATE",
            "TIMESTAMP": "Sequelize.DATE",
            "BOOLEAN": "Sequelize.BOOLEAN",
            "TINYINT": "Sequelize.BOOLEAN"
        }
        
        base_type = type_map.get(sql_type, "Sequelize.STRING")
        
        if size and "STRING" in base_type:
            return f"Sequelize.STRING({size})"
        
        return base_type

    def generate_migration_file(self, table_name: str, table_data: dict) -> str:
        """Generate migration file content for a single table"""
        columns = table_data["columns"]
        primary_keys = table_data["primaryKeys"]
        foreign_keys = table_data["foreignKeys"]
        
        timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
        
        migration = f"'use strict';\n\nmodule.exports = {{\n"
        migration += f"  async up(queryInterface, Sequelize) {{\n"
        migration += f"    await queryInterface.createTable('{table_name}', {{\n"
        
        for col_name, col_info in columns.items():
            sequelize_type = self.get_sequelize_type(col_info["type"], col_info["size"])
            
            migration += f"      {col_name}: {{\n"
            migration += f"        type: {sequelize_type},\n"
            
            if col_name in primary_keys:
                migration += f"        primaryKey: true,\n"
                if col_info["autoIncrement"]:
                    migration += f"        autoIncrement: true,\n"
            
            if not col_info["nullable"] and col_name not in primary_keys:
                migration += f"        allowNull: false,\n"
            else:
                migration += f"        allowNull: true,\n"
            
            migration += f"      }},\n"
        
        
        migration += f"      createdAt: {{\n"
        migration += f"        type: Sequelize.DATE,\n"
        migration += f"        defaultValue: Sequelize.fn('now'),\n"
        migration += f"        allowNull: false\n"
        migration += f"      }},\n"
        migration += f"      updatedAt: {{\n"
        migration += f"        type: Sequelize.DATE,\n"
        migration += f"        defaultValue: Sequelize.fn('now'),\n"
        migration += f"        allowNull: false\n"
        migration += f"      }}\n"
        
        migration += f"    }});\n"
        migration += f"  }},\n\n"
        migration += f"  async down(queryInterface) {{\n"
        migration += f"    await queryInterface.dropTable('{table_name}');\n"
        migration += f"  }}\n"
        migration += f"}};\n"
        
        return migration

    def generate_fk_migration(self, table_name: str, col_name: str, fk_info: dict) -> str:
        """Generate a separate migration that adds a foreign key constraint for a given column"""
        fk_name = f"fk_{table_name}_{col_name}_{fk_info['table']}_{fk_info['column']}"
        migration = f"'use strict';\n\nmodule.exports = {{\n"
        migration += f"  async up(queryInterface, Sequelize) {{\n"
        migration += f"    await queryInterface.addConstraint('{table_name}', {{\n"
        migration += f"      fields: ['{col_name}'],\n"
        migration += f"      type: 'foreign key',\n"
        migration += f"      name: '{fk_name}',\n"
        migration += f"      references: {{\n"
        migration += f"        table: '{fk_info['table']}',\n"
        migration += f"        field: '{fk_info['column']}'\n"
        migration += f"      }},\n"
        migration += f"      onUpdate: 'CASCADE',\n"
        migration += f"      onDelete: 'SET NULL'\n"
        migration += f"    }});\n"
        migration += f"  }},\n\n"
        migration += f"  async down(queryInterface) {{\n"
        migration += f"    await queryInterface.removeConstraint('{table_name}', '{fk_name}');\n"
        migration += f"  }}\n"
        migration += f"}};\n"
        return migration

    def generate_model_file(self, table_name: str, table_data: dict) -> str:
        """Generate model file content for a single table"""
        columns = table_data["columns"]
        foreign_keys = table_data["foreignKeys"]
        
        model_class_name = table_name[0].upper() + table_name[1:].lower()
        
        model = f"'use strict';\nconst {{\n"
        model += f"  Model\n"
        model += f"}} = require('sequelize');\n\n"
        model += f"module.exports = (sequelize, DataTypes) => {{\n"
        model += f"  class {model_class_name} extends Model {{\n"
        model += f"    static associate(models) {{\n"

        # Add associations for foreign keys (belongsTo) and suggest inverse (hasMany)
        for col_name, fk_info in foreign_keys.items():
            ref_model = fk_info['table'][0].upper() + fk_info['table'][1:].lower()
            # the model that has the FK belongsTo the referenced model
            model += f"      this.belongsTo(models.{ref_model}, {{ foreignKey: '{col_name}' }});\n"
            # suggest inverse relationship in the referenced model (commented)
            model += f"      // In models/{fk_info['table']}.js consider: this.hasMany(models.{model_class_name}, {{ foreignKey: '{col_name}' }});\n"

        model += f"    }}\n"
        model += f"  }}\n"
        model += f"  {model_class_name}.init({{\n"
        
        for col_name, col_info in columns.items():
            sequelize_type = self.get_sequelize_type(col_info["type"], col_info["size"])
            sequelize_type = sequelize_type.replace("Sequelize.", "DataTypes.")
            
            model += f"    {col_name}: {{\n"
            model += f"      type: {sequelize_type},\n"
            if col_name == list(columns.keys())[0]:  # First column as primary key
                model += f"      primaryKey: true,\n"
                if col_info["autoIncrement"]:
                    model += f"      autoIncrement: true\n"
            elif not col_info["nullable"]:
                model += f"      allowNull: false\n"
            else:
                model += f"      allowNull: true\n"
            model += f"    }},\n"
        
        # Add foreign keys only if column not already defined above
        for col_name, fk_info in foreign_keys.items():
            if col_name in columns:
                continue
            model += f"    {col_name}: {{\n"
            model += f"      type: DataTypes.INTEGER,\n"
            model += f"      references: {{\n"
            model += f"        model: '{fk_info['table']}',\n"
            model += f"        key: '{fk_info['column']}'\n"
            model += f"      }},\n"
            model += f"      allowNull: true\n"
            model += f"    }},\n"
        
        model += f"  }}, {{\n"
        model += f"    sequelize,\n"
        model += f"    modelName: '{model_class_name}',\n"
        model += f"    tableName: '{table_name}',\n"
        model += f"    timestamps: true\n"
        model += f"  }});\n"
        model += f"  return {model_class_name};\n"
        model += f"}};\n"
        
        return model

    def sql_to_sequelize(self, sql: str) -> str:
        """Parse SQL and generate migration & model files, then create ZIP"""
        sql = self.clean_sql(sql)
        
        # Regex for CREATE TABLE - only capture table creation lines
        # Using non-capturing group for ENGINE part to avoid extra unpacking
        table_pattern = re.compile(r"CREATE TABLE\s+`?(\w+)`?\s*\((.*?)\)\s*(?:ENGINE=.*?;|;)", re.S | re.I)
        
        matches = table_pattern.findall(sql)

        if not matches:
            messagebox.showerror("Error", "No CREATE TABLE statements found!")
            return None

        # Build initial table data from CREATE TABLE bodies
        tables = {}
        for table_name, body in matches:
            tables[table_name] = self.parse_create_table(body)

        # Parse ALTER TABLE statements to capture FK constraints, PKs, and AUTO_INCREMENT set via ALTER
        alter_pattern = re.compile(r"ALTER TABLE\s+`?(\w+)`?\s+(.*?);", re.S | re.I)
        for tbl, content in alter_pattern.findall(sql):
            content = content.strip()
            if tbl not in tables:
                # initialize an empty table entry if ALTER references table not in CREATEs
                tables.setdefault(tbl, {"columns": {}, "primaryKeys": [], "foreignKeys": {}})

            # Find FOREIGN KEY references inside ALTER content
            for fk_match in re.finditer(r"FOREIGN KEY\s*\((`?\w+`?)\)\s*REFERENCES\s*`?(\w+)`?\s*\((`?\w+`?)\)", content, re.I):
                col = fk_match.group(1).strip("`\"'")
                ref_table = fk_match.group(2).strip("`\"'")
                ref_col = fk_match.group(3).strip("`\"'")
                tables[tbl].setdefault('foreignKeys', {})[col] = {"table": ref_table, "column": ref_col}
                # if the FK column was not declared in the CREATE TABLE, add a default INT column entry
                if col not in tables[tbl].get('columns', {}):
                    tables[tbl].setdefault('columns', {})[col] = {"type": "INT", "size": None, "nullable": True, "autoIncrement": False}

            # Find MODIFY ... AUTO_INCREMENT occurrences
            for mod in re.finditer(r"MODIFY\s+`?(\w+)`?.*?AUTO_INCREMENT", content, re.I):
                col = mod.group(1)
                if col in tables[tbl].get('columns', {}):
                    tables[tbl]['columns'][col]['autoIncrement'] = True

            # Find ADD PRIMARY KEY (...) in ALTER
            pk_match = re.search(r"ADD PRIMARY KEY\s*\((.*?)\)", content, re.I)
            if pk_match:
                pks = [c.strip("` \"") for c in pk_match.group(1).split(',')]
                tables[tbl]['primaryKeys'] = pks

        # Create temporary directories
        temp_dir = "generated_sequelize"
        migrations_dir = os.path.join(temp_dir, "migrations")
        models_dir = os.path.join(temp_dir, "models")

        # Clean up if exists
        if os.path.exists(temp_dir):
            import shutil
            shutil.rmtree(temp_dir)

        os.makedirs(migrations_dir, exist_ok=True)
        os.makedirs(models_dir, exist_ok=True)

        # Generate files for each table
        for table_name, table_data in tables.items():
            
            # Generate migration file
            migration_content = self.generate_migration_file(table_name, table_data)
            migration_filename = f"{datetime.now().strftime('%Y%m%d%H%M%S')}-create-{table_name}.js"
            with open(os.path.join(migrations_dir, migration_filename), "w", encoding="utf-8") as f:
                f.write(migration_content)
            
            # Generate model file
            model_content = self.generate_model_file(table_name, table_data)
            model_filename = f"{table_name}.js"
            with open(os.path.join(models_dir, model_filename), "w", encoding="utf-8") as f:
                f.write(model_content)
            
            # Generate separate FK migrations (one per foreign key)
            for col_name, fk_info in table_data.get('foreignKeys', {}).items():
                fk_migration_content = self.generate_fk_migration(table_name, col_name, fk_info)
                fk_migration_filename = f"{datetime.now().strftime('%Y%m%d%H%M%S')}-add-fk-{table_name}-{col_name}.js"
                with open(os.path.join(migrations_dir, fk_migration_filename), "w", encoding="utf-8") as fkf:
                    fkf.write(fk_migration_content)
        
        # Create ZIP file
        zip_filename = f"sequelize-generated-{datetime.now().strftime('%Y%m%d_%H%M%S')}.zip"
        with zipfile.ZipFile(zip_filename, 'w', zipfile.ZIP_DEFLATED) as zipf:
            for root, dirs, files in os.walk(temp_dir):
                for file in files:
                    file_path = os.path.join(root, file)
                    arcname = os.path.relpath(file_path, temp_dir)
                    zipf.write(file_path, arcname)
        
        # Clean up temporary directory
        import shutil
        shutil.rmtree(temp_dir)
        
        return zip_filename


if __name__ == "__main__":
    import sys
    # Headless mode: pass a SQL file path as first argument to generate ZIP without GUI
    if len(sys.argv) > 1:
        sql_path = sys.argv[1]
        if not os.path.exists(sql_path):
            print(f"SQL file not found: {sql_path}")
            sys.exit(1)
        with open(sql_path, 'r', encoding='utf-8') as f:
            sql = f.read()
        # instantiate without running __init__ to avoid creating GUI
        app = SQLToSequelizeApp.__new__(SQLToSequelizeApp)
        zipfile_path = app.sql_to_sequelize(sql)
        if zipfile_path:
            print(f"Generated: {zipfile_path}")
            sys.exit(0)
        else:
            print("Generation failed.")
            sys.exit(2)
    else:
        root = tk.Tk()
        app = SQLToSequelizeApp(root)
        root.mainloop()
