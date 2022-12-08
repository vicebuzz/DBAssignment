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