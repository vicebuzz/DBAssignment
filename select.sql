-- report list item 1
SELECT AcademicName, AcademicQualification, EmploymentDate 
FROM Academic;
--report list item 2
SELECT Academic.AcademicName, Academic.AcademicQualification, Academic.EmploymentDate, ResearchGroup.GroupName, ResearchGroup.GroupMoto, ResearchGroup.EstablishingDate
FROM Academic
INNER JOIN ResearchGroup ON Academic.GroupID = ResearchGroup.GroupID;
--report list item 3
SELECT 
    Academic.AcademicName, 
    Academic.AcademicQualification, 
    Academic.EmploymentDate, 
    ResearchGroup.GroupName, 
    ResearchGroup.GroupMoto, 
    ResearchGroup.EstablishingDate, 
    (
        SELECT COUNT(*)
        FROM AcademicToPublication
        INNER JOIN Academic ON AcademicToPublication.academicID = Academic.academicID
        WHERE Academic.academicName = 'Dr. Bert Kibbler' --'Dr. Bert Kibbler' has one collabaration, 'Dr. Barry Kripke' and 'Dr. Bernadette Rostenkowski-Wolowitz' have none, rest of the academics have multiple
    ) NumberOfCollaborations
FROM Academic
INNER JOIN ResearchGroup ON Academic.GroupID = ResearchGroup.GroupID
WHERE Academic.academicName = 'Dr. Bert Kibbler'; --'Dr. Bert Kibbler' has one collabaration, 'Dr. Barry Kripke' and 'Dr. Bernadette Rostenkowski-Wolowitz' have none, rest of the academics have multiple
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
        GROUP BY academic.academicname, ResearchGroup.groupName
    )
    GROUP BY groupName
    ORDER BY NumberOfCollaborationsInGroup DESC
)
WHERE rownum <= 2;