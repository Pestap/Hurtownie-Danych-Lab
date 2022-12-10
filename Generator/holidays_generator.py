# generate .csv file for etl process


from datetime import date
import holidays


pl_holidays = holidays.PL();

for i in pl_holidays:
    print(i)
