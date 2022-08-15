select distinct custProjectStatus from ProjectCustomTabFields



Select  WBS1 , ProjectName ,  isnull(CustDateInactivated,0) as CustDateInactivated , project.ProjectStatus ,  custProjectStatus as ProjectProgress , 
case when (convert(decimal,(datediff(DAY , isnull(CustDateInactivated,0) , convert(varchar,getdate(),101)))))/30 < 3.1 then 'Less than 3 months go'
when (convert(decimal,(datediff(DAY , isnull(CustDateInactivated,0) , convert(varchar,getdate(),101)))))/30 >= 3.1 then 'More or just than 3 months ago' else 'Not Inactived'   end as Inactivated 
from ProjectCustomTabFields
inner join vma.regproj
on regproj.Project = ProjectCustomTabFields.WBS1
left join vma.project
on project.project = ProjectCustomTabFields.WBS1
left join vma.org
on org.Org = project.org
Where project.ProjectStatus = 'I' 
and WBS2 = ' '
and custProjectStatus in ('Dead','Dead – Unbilled')
and CustBdgtApprovedbyAccounting = 'Y' 
and CustDateInactivated between '2021-01-01'  and '2022-12-31'
order by ProjectCustomTabFields.CustDateInactivated