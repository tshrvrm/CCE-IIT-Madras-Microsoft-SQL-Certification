--1. Find out the average selling cost for packages developed in Pascal.

SELECT AVG(SCOST) FROM SOFTWARE
WHERE DEVELOPIN = 'PASCAL';

--2. Display the names and ages of all programmers.

SELECT PNAME, DATEPART(year, GETDATE()) - DATEPART(year, DOB) as 'PAGE' FROM PROGRAMMER;

--3. Display the names of those who have done the DAP Course.

SELECT PNAME FROM STUDIES
WHERE COURSE = 'DAP';

--4. Display the names and date of birth of all programmers born in January.

SELECT PNAME, DOB FROM PROGRAMMER
WHERE DATEPART(month, DOB) = 1;

--5. Display the details of the software developed by Ramesh.

SELECT * FROM SOFTWARE
WHERE PNAME = 'RAMESH';

--6. Display the details of packages for which development costs have been recovered.

SELECT * FROM SOFTWARE
WHERE (SCOST*SOLD) >= DCOST;

--7. Display the details of the programmers knowing C.

SELECT * FROM PROGRAMMER
WHERE PROF1 = 'C' or PROF2 = 'C';

--8. What are the languages studied by male programmers?

SELECT PROF1 FROM PROGRAMMER WHERE GENDER = 'M'
UNION
SELECT PROF2 FROM PROGRAMMER WHERE GENDER = 'M';

--9. Display the details of the programmers who joined before 1990.

SELECT * FROM PROGRAMMER
WHERE DATEPART(year, DOJ) < 1990;

--10. Who are the authors of the packages which have recovered more than double the development cost?

SELECT PNAME FROM SOFTWARE
WHERE (SCOST*SOLD) > 2*DCOST;