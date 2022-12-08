--CREATE SCRIPTS
/* put your create scripts here - your script should not be commented out */
-- research group table
CREATE TABLE ResearchGroup (
    groupID VARCHAR(10),
    groupName VARCHAR(255),
    groupMoto VARCHAR(255),
    establishingDate DATE,
    CONSTRAINT pk_group PRIMARY KEY (groupID)

);
-- academic group table
CREATE TABLE Academic (
    academicID VARCHAR(10),
    academicName VARCHAR(50),
    academicQualification VARCHAR(20),
    employmentDate DATE,
    groupID VARCHAR(10),
    CONSTRAINT pk_academic PRIMARY KEY (academicID),
    CONSTRAINT fk_academic_group FOREIGN KEY (groupID) REFERENCES ResearchGroup(groupID)
);
-- academic's publications table
CREATE TABLE Publication (
    publicationID VARCHAR(10),
    publicationName VARCHAR(100),
    publicationDescription VARCHAR(255),
    CONSTRAINT pk_publication PRIMARY KEY (publicationID)
);
-- link table between academics and publications
CREATE TABLE AcademicToPublication (
    linkID INTEGER,
    academicID VARCHAR(10),
    publicationID VARCHAR(10),
    CONSTRAINT pk_link PRIMARY KEY (linkID),
    CONSTRAINT fk_academic_link FOREIGN KEY (academicID) REFERENCES Academic(academicID),
    CONSTRAINT fk_publication_link FOREIGN KEY (publicationID) REFERENCES Publication(publicationID)
);
-- commit the changes
COMMIT;
--INSERT SCRIPTS
/* put your insert scripts here - your script should not be commented out */
-- inserting research groups
INSERT INTO ResearchGroup VALUES ('G01','AI Group','People get things they dont deserve all the time. Like me with this group.',TO_DATE('04-05-2010', 'dd-mm-yyyy'));
INSERT INTO ResearchGroup VALUES ('G02','IoT Group','Dont feel attached to another object by an inclined plane wrapped helically around an axis!',TO_DATE('20-04-2012', 'dd-mm-yyyy'));
INSERT INTO ResearchGroup VALUES ('G03','Software Engineering Group','Engineering. Where the noble semiskilled laborers execute the vision of those who think and dream. Truly, the Oompa-Loompas of science.',TO_DATE('24-08-2009', 'dd-mm-yyyy'));
INSERT INTO ResearchGroup VALUES ('G04','Cyber Group','Not Knowing Is Part Of The Fun.',TO_DATE('16-04-2011', 'dd-mm-yyyy'));
-- inserting academics
INSERT INTO Academic VALUES ('A01','Dr. Sheldon Cooper','Physics PhD',TO_DATE('02-12-2009','dd-mm-yyyy'),'G01');
INSERT INTO Academic VALUES ('A02','Dr. Leonard Hofstadter','Physics PhD',TO_DATE('11-11-2009','dd-mm-yyyy'),'G02');
INSERT INTO Academic VALUES ('A03','Dr. Rajesh Koothrappali','Physics PhD',TO_DATE('01-09-2010','dd-mm-yyyy'),'G04');
INSERT INTO Academic VALUES ('A04','Howard Wolowitz','Engineering MSc',TO_DATE('14-07-2009','dd-mm-yyyy'),'G03');
INSERT INTO Academic VALUES ('A05','Dr. Bernadette Rostenkowski-Wolowitz','Microbiology PhD',TO_DATE('01-02-2012','dd-mm-yyyy'),'G02');
INSERT INTO Academic VALUES ('A06','Dr. Amy Farrah Fowler','Neuroscience PhD',TO_DATE('08-03-2010','dd-mm-yyyy'),'G01');
INSERT INTO Academic VALUES ('A07','Dr. Barry Kripke','Physics PhD',TO_DATE('03-09-2008','dd-mm-yyyy'),'G03');
INSERT INTO Academic VALUES ('A08','Dr. Bert Kibbler','Geology PhD',TO_DATE('02-05-2009','dd-mm-yyyy'),'G04');
-- inserting publications
INSERT INTO Publication VALUES ('P01','Differential equation scanner software','Mobile app aimed at recognising various differential equations and solve them.');
INSERT INTO Publication VALUES ('P02','Superfluid vacuum theory','Superfluid vacuum theory (SVT) is an approach in theoretical physics and quantum mechanics where the fundamental physical vacuum (non-removable background) is viewed as superfluid or as a Bose-Einstein condensate (BEC).');
INSERT INTO Publication VALUES ('P03','Quantum Guidance System project','Based on the Superfluid Vacuum theory, published by Dr. Cooper and Dr. Holfstader');
INSERT INTO Publication VALUES ('P04','Paradoxical Moment-of-Inertia Changes Due to Putative Super-Solids','Physics research paper, reflecting on the discovery of the previously unknown state of matter following Dr. Hofstadter experiment, based on dr. Cooper theory.');
INSERT INTO Publication VALUES ('P05','Geological perspective on the lifes on other planets','Revolutionary research by Dr. Kibbler, earning him the MacArthur Genuis grant, which explains gological perspective about the life on other planets.');
INSERT INTO Publication VALUES ('P06','Methods for controlling robotic limbs with brain waves','By incorporating engineering and neuroscience research, scientists and physicians have found a way to make robotic pieces function “naturally” like any limb on the human body.');
INSERT INTO Publication VALUES ('P07','Concept of super-assymetry','The concept of super-asymmetry is related to super-symmetry string theory, developed by Dr, Cooper and Dr. Fowler completely revolutionise the way we look at the universe.');
--insering links between academics and publications
INSERT INTO AcademicToPublication VALUES (1,'A01','P01');
INSERT INTO AcademicToPublication VALUES (2,'A02','P01');
INSERT INTO AcademicToPublication VALUES (3,'A03','P01');
INSERT INTO AcademicToPublication VALUES (4,'A04','P01');
INSERT INTO AcademicToPublication VALUES (5,'A01','P02');
INSERT INTO AcademicToPublication VALUES (6,'A02','P02');
INSERT INTO AcademicToPublication VALUES (7,'A01','P03');
INSERT INTO AcademicToPublication VALUES (8,'A02','P03');
INSERT INTO AcademicToPublication VALUES (9,'A04','P03');
INSERT INTO AcademicToPublication VALUES (10,'A01','P04');
INSERT INTO AcademicToPublication VALUES (11,'A02','P04');
INSERT INTO AcademicToPublication VALUES (12,'A08','P05');
INSERT INTO AcademicToPublication VALUES (13,'A04','P06');
INSERT INTO AcademicToPublication VALUES (14,'A06','P06');
INSERT INTO AcademicToPublication VALUES (15,'A01','P07');
INSERT INTO AcademicToPublication VALUES (16,'A06','P07');
--commit the changes
COMMIT;
--SELECT SCRIPTS
/* put your select scripts here (with indication of which query is answered by each) - your
script should not be commented out */
-- report list item 1
SELECT AcademicName, AcademicQualification, EmploymentDate 
FROM Academic;
--report list item 2
SELECT Academic.AcademicName, Academic.AcademicQualification, Academic.EmploymentDate, ResearchGroup.GroupName, ResearchGroup.GroupMoto, ResearchGroup.EstablishingDate
FROM Academic
INNER JOIN ResearchGroup ON Academic.GroupID = ResearchGroup.GroupID;
--report list item 3
SELECT * 
FROM
(
    SELECT  Academic.AcademicName, 
            Academic.AcademicQualification, 
            Academic.EmploymentDate, 
            ResearchGroup.groupName, 
            ResearchGroup.GroupMoto, 
            ResearchGroup.EstablishingDate, 
            COUNT(*)NumberOfCollaborations
    FROM AcademicToPublication
    INNER JOIN Academic ON AcademicToPublication.academicID = Academic.academicID
    INNER JOIN ResearchGroup ON Academic.groupID = ResearchGroup.groupID
    WHERE AcademicToPublication.publicationID IN (
        SELECT publicationID 
        FROM (
            SELECT COUNT(*) NumberOfOccurances, publicationID
            FROM AcademicToPublication
            GROUP BY publicationID
        )
        WHERE NumberOfOccurances > 1
    )
    GROUP BY Academic.AcademicName, 
            Academic.AcademicQualification, 
            Academic.EmploymentDate, 
            ResearchGroup.groupName, 
            ResearchGroup.GroupMoto, 
            ResearchGroup.EstablishingDate
)
--report list item 4
SELECT *
FROM
(
    SELECT groupName, SUM(NumberOfCollaborations)NumberOfCollaborationsInGroup
    FROM
    (
        SELECT Academic.AcademicName, ResearchGroup.groupName, COUNT(*)NumberOfCollaborations
        FROM AcademicToPublication
        INNER JOIN Academic ON AcademicToPublication.academicID = Academic.academicID
        INNER JOIN ResearchGroup ON Academic.groupID = ResearchGroup.groupID
        WHERE AcademicToPublication.publicationID IN (
            SELECT publicationID 
            FROM (
                SELECT COUNT(*) NumberOfOccurances, publicationID
                FROM AcademicToPublication
                GROUP BY publicationID
            )
            WHERE NumberOfOccurances > 1
        )
        GROUP BY academic.academicname, ResearchGroup.groupName
    )
    GROUP BY groupName
    ORDER BY NumberOfCollaborationsInGroup DESC
)
WHERE rownum <= 2;
--DROP SCRIPTS
/* put your drop scripts here (in the correct order) - your script should not be commented out
*/
DROP TABLE AcademicToPublication;
DROP TABLE Academic;
DROP TABLE Publication;
DROP TABLE ResearchGroup;
--commit the changes
COMMIT;