# generate .csv file for etl process
import csv
from datetime import date
import holidays


years = list(range(2022, 2100))

pl_holidays = holidays.PL(years=years)

with open('excel/holidays.csv', 'w', encoding='utf8', newline='') as f:
    writer = csv.writer(f)
    writer.writerow(['data'])
    for day in pl_holidays.items():
        writer.writerow([day[0]])
