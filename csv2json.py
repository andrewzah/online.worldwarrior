import csv
import json
import sys

input_file = sys.argv[1]
output_file = sys.argv[2]

try:
  with open(input_file, 'r', newline='') as csvfile:
    reader = csv.DictReader(csvfile)
    data = [row for row in reader if row["region_event"] != '']
except FileNotFoundError:
  print(f"Error: Input file '{input_file}' not found.")
  exit(1)
json_data = json.dumps(data, indent=4)

try:
  with open(output_file, 'w') as outfile:
    outfile.write(json_data)
except OSError:
  print(f"Error: Could not write to output file '{output_file}'.")
  exit(1)

print(f"Converted CSV file '{input_file}' to JSON file '{output_file}'.")
