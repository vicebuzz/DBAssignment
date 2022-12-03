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
INSERT INTO Academic VALUES ('A01','Dr. Sheldon Cooper','Physics PhD',TO_DATE('','dd-mm-yyyy'),'G01');
INSERT INTO Academic VALUES ('A02','Dr. Leonard Hofstadter','Physics PhD',TO_DATE('','dd-mm-yyyy'),'G02');
INSERT INTO Academic VALUES ('A03','Dr. Rajesh Koothrappali','Physics PhD',TO_DATE('','dd-mm-yyyy'),'G04');
INSERT INTO Academic VALUES ('A04','Howard Wolowitz','Master of Engineering',TO_DATE('','dd-mm-yyyy'),'G03');
INSERT INTO Academic VALUES ('A05','Dr. Bernadette Rostenkowski-Wolowitz','PhD Microbiology',TO_DATE('','dd-mm-yyyy'),'G02');
INSERT INTO Academic VALUES ('A06','Dr. Amy Farrah Fowler','PhD Neuroscience',TO_DATE('','dd-mm-yyyy'),'G01');
INSERT INTO Academic VALUES ('A07','Dr. Barry Kripke','PhD Physics',TO_DATE('','dd-mm-yyyy'),'G03');
INSERT INTO Academic VALUES ('A08','Dr. Bert Kibbler','PhD Geology',TO_DATE('','dd-mm-yyyy'),'G04');
--SELECT SCRIPTS
/* put your select scripts here (with indication of which query is answered by each) - your
script should not be commented out */
--DROP SCRIPTS
/* put your drop scripts here (in the correct order) - your script should not be commented out
*/