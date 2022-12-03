--CREATE SCRIPTS
/* put your create scripts here - your script should not be commented out */
-- research group table
CREATE TABLE ResearchGroup (
    groupID VARCHAR(10),
    groupDetails VARCHAR(255),
    groupMoto VARCHAR(255),
    establishingDate DATE,
    CONSTRAINT pk_group PRIMARY KEY (groupID)

);
-- academic group table
CREATE TABLE Academic (
    academicID VARCHAR(10),
    academicQualification VARCHAR(255),
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

--SELECT SCRIPTS
/* put your select scripts here (with indication of which query is answered by each) - your
script should not be commented out */
--DROP SCRIPTS
/* put your drop scripts here (in the correct order) - your script should not be commented out
*/