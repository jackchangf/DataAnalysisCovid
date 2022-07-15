select * From tblCovid
where continent is not null
order by 2,3,4

--get date from datetime
alter table tblcovid
add dateOnly as date

update tblcovid
set dateOnly = convert(date,[date])

--check for duplicates
with t1 as 
(
	select * ,
	ROW_NUMBER() over (partition by continent,location,date,total_cases,total_deaths,new_cases,new_deaths order by continent,location,date,total_cases,total_deaths,new_cases,new_deaths) as rn
	from tblcovid
)
select * from t1 where rn > 1

--data by country
select location,max(total_cases) totalCases,max(new_cases) newCases,max(total_deaths) totalDeaths,max(new_deaths) newDeaths from tblCovid
where continent is not null
group by location
order by 1,2

--total covid cases in the world
select sum(new_cases) as totalCases,
sum(cast(new_deaths as int)) as totalDeaths,
(sum(cast(new_deaths as int))/sum(new_cases)*100) as fatalityRate
From tblCovid
where continent is not null

--total deaths of each continent
select continent,sum(cast(new_deaths as int)) as totalDeaths From tblCovid
where continent is not null
group by continent



