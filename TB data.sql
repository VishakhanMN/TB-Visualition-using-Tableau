/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Country_or_territory_name]
      ,[ISO_3_character_country_territory_code]
      ,[Region]
      ,[Year]
      ,[Estimated_total_population_number]
      ,[Estimated_prevalence_of_TB_all_forms_per_100_000_population]
      ,[Estimated_prevalence_of_TB_all_forms]
      ,[Method_to_derive_prevalence_estimates]
      ,[Estimated_mortality_of_TB_cases_all_forms_excluding_HIV_per_100_000_population]
      ,[Estimated_number_of_deaths_from_TB_all_forms_excluding_HIV]
      ,[Estimated_mortality_of_TB_cases_who_are_HIV_positive_per_100_000_population]
      ,[Estimated_number_of_deaths_from_TB_in_people_who_are_HIV_positive]
      ,[Method_to_derive_mortality_estimates]
      ,[Estimated_incidence_all_forms_per_100_000_population]
      ,[Estimated_number_of_incident_cases_all_forms]
      ,[Estimated_HIV_in_incident_TB_percent]
      ,[Estimated_incidence_of_TB_cases_who_are_HIV_positive_per_100_000_population]
      ,[Estimated_incidence_of_TB_cases_who_are_HIV_positive]
      ,[Method_to_derive_TBHIV_estimates]
      ,[Case_detection_rate_all_forms_percent]
  FROM [TB Database].[dbo].[TB_Updated];


  -- Creating new table to insert mortality rates only--
  Select Country_or_territory_name, SUM(Estimated_mortality_of_TB_cases_all_forms_excluding_HIV_per_100_000_population) as Test1,SUM(Estimated_mortality_of_TB_cases_who_are_HIV_positive_per_100_000_population) as Test2
  into TB_Final1
  from TB_Updated
  Group By Country_or_territory_name;

  -- Taking top 3 countries from each region--
  Select (Test1+Test2),b.Country_or_territory_name
  from TB_Final1 a
  Inner join TB_Updated b
  ON a.Country_or_territory_name = b.Country_or_territory_name
  Where b.Region ='WPR'
  Order by (Test1+Test2) desc;

  Select (Test1+Test2),Country_or_territory_name from TB_Final 
  where Region = 'EUR'
  ORder by (Test1+Test2) desc;

  Select * from TB_Updated;

  Delete TB_Final
  
  Select *
  into TB_Final
  from TB_Updated
  where Country_or_territory_name IN ('Djibouti','Pakistan','Somalia','Swaziland','Namibia','Lesotho','Haiti','Peru','Guyana','Kazakhstan','Turkmenistan','Ukraine','Myanmar','Bhutan','India','Cambodia','Papua New Guinea','Tuvalu')
  
  Select * from TB_Final

 ALTER TABLE TB_Final
DROP COLUMN Method_to_derive_TBHIV_estimates;

--Null check--
Select * from TB_Final Where [Case_detection_rate_all_forms_percent] is Null;

-- deleted as 3 columns are null--
Delete from TB_Final where Country_or_territory_name IN ('Turkmenistan','Tuvalu');  

--Deleting unwanted column --
 ALTER TABLE TB_Updated
DROP COLUMN Method_to_derive_TBHIV_estimates;


--Updating table with new countries--
Insert into TB_Final
Select * from TB_Updated
where Country_or_territory_name IN ('Russian Federation','Philippines');

-- Updating Null values with legal values--

Select distinct Country_or_territory_name from TB_Final Where [Case_detection_rate_all_forms_percent] is Null;


Select * from TB_Final where Country_or_territory_name = 'Djibouti'

-- Finding Average value ----
Select AVG(Case_detection_rate_all_forms_percent) from TB_Final where Country_or_territory_name = 'Ukraine'

--Updating table with Median Values---
Update TB_Final
Set Case_detection_rate_all_forms_percent = 68
where Country_or_territory_name = 'Ukraine' and Case_detection_rate_all_forms_percent is Null;

