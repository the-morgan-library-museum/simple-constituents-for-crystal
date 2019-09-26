USE [TMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[MLM_BI_ConXrefs] AS
		
SELECT CX.ConXrefID
    ,CX.ID
    ,CX.TableID
    ,CX.RoleTypeID
    ,CX.RoleID
    ,R.Role
    ,CXDU.Prefix AS UnmaskedPrefix
    ,CANU.DisplayName AS UnmaskedName
    ,CXDU.Suffix AS UnmaskedSuffix
    ,CDBU.DisplayBio AS UnmaskedLifeDates
    ,CANM.DisplayName AS MaskedName
    ,CX.DisplayOrder
    ,CX.Displayed
    ,CX.Active
    ,CXDU.DepartmentID
FROM ConXrefs CX
INNER JOIN Roles R ON CX.RoleID = R.RoleID
INNER JOIN ConXrefDetails CXDU ON CX.ConXrefID = CXDU.ConXrefID AND CXDU.UnMasked = 1
INNER JOIN ConAltNames CANU ON CXDU.NameID = CANU.AltNameId
INNER JOIN ConDisplayBios CDBU ON CXDU.DisplayBioID = CDBU.ConDisplayBioID
INNER JOIN ConXrefDetails CXDM ON CX.ConXrefID = CXDM.ConXrefID AND CXDM.UnMasked = 0
INNER JOIN ConAltNames CANM ON CXDM.NameID = CANM.AltNameId
INNER JOIN ConDisplayBios CDBM ON CXDM.DisplayBioID = CDBM.ConDisplayBioID

GO

GRANT SELECT ON [dbo].[MLM_BI_ConXrefs] TO TMSUSERS
