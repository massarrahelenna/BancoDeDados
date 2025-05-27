import re
import pandas as pd

# Read the full SQL file content
with open("/home/massarrahelenna/BancoDeDados/AulaPratica-13/carros.sql", "r", encoding="utf-8") as file:
    full_sql_text = file.read()

# Extract all tuples of values from the SQL INSERT statements
all_data = re.findall(r"INSERT INTO mytable\(.*?\) VALUES\s*\((.*?)\);", full_sql_text)

# Split each tuple by comma, considering quoted strings or numeric values
parsed_all_data = [re.findall(r"'[^']*'|\d+", row) for row in all_data]

# Remove surrounding quotes from string values
cleaned_all_data = [[val.strip("'") for val in row] for row in parsed_all_data]

# Create the full DataFrame
columns = ['Brand', 'Model', 'Year', 'Engine_Size', 'Fuel_Type', 'Transmission', 'Mileage', 'Doors', 'Owner_Count', 'Price']
full_df = pd.DataFrame(cleaned_all_data, columns=columns)

# Convert numeric fields to appropriate types
full_df = full_df.astype({
    'Year': int,
    'Engine_Size': float,
    'Mileage': int,
    'Doors': int,
    'Owner_Count': int,
    'Price': int
})

# Save the full dataset to CSV
full_csv_path = "/home/massarrahelenna/BancoDeDados/AulaPratica-13/carros.csv"
full_df.to_csv(full_csv_path, index=False)

full_csv_path
