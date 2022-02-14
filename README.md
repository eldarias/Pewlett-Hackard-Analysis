# Pewlett-Hackard Analysis

## Project Overview
The purpose of this project was to determine the ***number of retiring employees per title*** and identify ***employees who are eligible to participate in a mentorship program***.  For this project, the data already existed on **PostgreSQL** database/tables, which was completed (db and tables created, data imported) earlier in the module.  **pgAdmin** was used to connect to the database and tables.  Also, via **pgAdmin**, SQL queries/statements were executed to query tables, analyze the output and save the required data into new tables.  Finally, the new tables were exported from **PostgreSQL** tables in a CSV format and uploaded to the GitHub repository for this project.

## Results
The results from the analysis for each deliverable are as follows:

### Deliverable 1: The Number of Retiring Employees by Title
Below are the results for the Number of Retiring Employees by Title:
* <image src="./Data/Deliverable1_RetiringTable_Results.PNG"><b></b>
    * There is a total of 72,458 of retiring employees
    * Most of the individuals retiring have the titles of __Senior Engineers__ and __Senior Staff__.
    * There are only two individuals with the title of __Manager__ that will be retiring.  

### Deliverable 2: The Employees Eligible for the Mentorship Program
Below are the results for the Employees Eligible for the Mentorship Program:
* <image src="./Data/Deliverable2_mentorship_eligibility_Results.PNG"><b></b>
    * The above results are for currently employees whose birth dates are between January 1 1965 to December 12 1965
    * There is a total of 1,549 employees who are eligible to participate in a mentorship program.

## Summary
In summary, there are 72,458 employees that could potentially begin retiring, with two departments being significantly impacted compared to the others.  The number of employees eligible to participate in a mentorship program is 1,549, which is a low number compared to the possible retirees.  The following tables and queries may provide more insight into the impact and ways to better understand the impact:
* Query the __mentorship_eligibility__ table to get the total number of employees eligible for mentorship by department compare to retiring employees per department.
* Analyze and compare the total percentage of employees retiring vs not retiring for each department.  This will also help understand the staffing impact.