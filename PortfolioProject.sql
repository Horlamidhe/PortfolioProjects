select top 5 * from PortfolioProject..CovidDeaths order by 3,4
--select * from PortfolioProject..CovidVaccinations

-- Step 1 : Select the data that would be used

select location, date, total_cases,new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
order by 1,2

--Step 2 Alter the data type of total_cases and total_deaths from nvarchar to float to enable calculations with those colummns
alter table PortfolioProject..CovidDeaths alter column total_cases float
alter table PortfolioProject..CovidDeaths alter column total_deaths float

--Step 3 - Get the total_cases VS total_deaths (Total deaths per case percentage)
--shows the likelihood of dying if you get infected with Covid-19
select continent,location, date , total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
WHERE total_cases IS NOT NULL AND total_deaths IS NOT NULL AND location in ('Nigeria')
order by 1,2

--step 4 Get the total_cases per population
select continent,location, date , total_cases, population, (total_cases/population)*100 as TotalCasesPerPopulation
from PortfolioProject..CovidDeaths
WHERE total_cases IS NOT NULL AND location in ('Nigeria')
order by 1,2

--Step 5 Get the countries with highest infection rate per population
select continent,location, MAX(population) as Population,MAX(total_cases) as highestCases,(MAX(total_cases)/MAX(population))*100 as TotalCasesPerPopulation
from PortfolioProject..CovidDeaths
group by location,continent
order by TotalCasesPerPopulation DESC


-- Step 6 Get the countries with the highest death count per population
select continent,location, MAX(population) as Population,MAX(total_deaths) as highestDeaths,(MAX(total_deaths)/MAX(population))*100 as TotalDeathsPerPopulation
from PortfolioProject..CovidDeaths
group by location,continent
order by TotalDeathsPerPopulation DESC

-- Step 7 Get the number of deaths by continent
select continent, SUM(new_deaths) as TotalDeaths
from PortfolioProject..CovidDeaths
where continent is not null
group by continent


-- Step 8 GLOBAL totaldeaths per total cases for each day
select date, SUM(new_cases) as total_cases,SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)* 100 as totalDeathPercent
from PortfolioProject..CovidDeaths
where continent is not null
group by date
order by totalDeathPercent desc

--Step 9 total death percentage as of today
select SUM(new_cases) as total_cases,SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)* 100 as totalDeathPercent
from PortfolioProject..CovidDeaths
where continent is not null

-- Step 10 join the two tables together
select * 
from PortfolioProject..CovidDeaths as dea
join PortfolioProject..CovidVaccinations as vac
on dea.location = vac.location and dea.date = vac.date
where dea.continent is not null 
order by 3,4
-- and dea.location = 'World'

-- Step 11 Get total Population per country vs vaccinations in the world

select dea.location, MAX(dea.population) as population, SUM(CONVERT(float,vac.new_vaccinations)) as total_vax, 
SUM(CONVERT(float,vac.new_vaccinations))/MAX(dea.population) * 100 as percentVaxPerCountry

--MAX(CONVERT(float,vac.total_vaccinations)) as total_vax, MAX(CONVERT(float,vac.total_vaccinations))/MAX(dea.population) * 100 as percentVaxPerCountry
from PortfolioProject..CovidDeaths as dea
join PortfolioProject..CovidVaccinations as vac
on dea.location = vac.location and dea.date = vac.date
group by dea.location
order by dea.location

-- Do the same using CTEs
with CTE_RPV 
as 
(
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations, 
SUM(cast(vac.new_vaccinations as float)) OVER (Partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths as dea
join PortfolioProject..CovidVaccinations as vac
on dea.location = vac.location and dea.date = vac.date
where dea.continent is not null
)

select *, RollingPeopleVaccinated/population * 100 
from CTE_RPV
order by 2,3

-- Do same with temp table
DROP TABLE IF EXISTS #Temp_RPV

CREATE TABLE #Temp_RPV (
 continent nvarchar(225) null,
 location nvarchar(255) null,
 date datetime null,
 population float null,
 new_vaccinations float null,
 RollingPeopleVacccinated float null
)


INSERT INTO #Temp_RPV
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations, 
SUM(cast(vac.new_vaccinations as float)) OVER (Partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths as dea
join PortfolioProject..CovidVaccinations as vac
on dea.location = vac.location and dea.date = vac.date
where dea.continent is not null

select *, RollingPeopleVacccinated/population * 100 
from #Temp_RPV
order by 2,3

-- Create view for data visualization for later
Create View PercentPopulationVaccinated as 
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations, 
SUM(cast(vac.new_vaccinations as float)) OVER (Partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths as dea
join PortfolioProject..CovidVaccinations as vac
on dea.location = vac.location and dea.date = vac.date
where dea.continent is not null

Create View DeathsPerDay as 
select date, SUM(new_cases) as total_cases,SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)* 100 as totalDeathPercent
from PortfolioProject..CovidDeaths
where continent is not null
group by date

Create View DeathsPerContinent as 
select continent, SUM(new_deaths) as TotalDeaths
from PortfolioProject..CovidDeaths
where continent is not null
group by continent


select *
from PercentPopulationVaccinated