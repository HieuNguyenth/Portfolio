
Select *
From [Portfolio Project]..CovidDeaths
Order by 3,4

Select *
From [Portfolio Project]..CovidVaccination
Order by 3,4

--Select Data that we are going to be using

Select Location, date, total_cases, new_cases, total_deaths, population
From [Portfolio Project]..CovidDeaths
Order by 1,2


--looking at the total cases vs total deaths

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPct
From [Portfolio Project]..CovidDeaths
Where location like '%state%'
Order by 3,4

SELECT Location, date, total_cases, total_deaths, (CAST(total_deaths AS FLOAT)/CAST(total_cases AS FLOAT))*100 as DeathPct
FROM [Portfolio Project]..CovidDeaths
WHERE location LIKE '%state%'
ORDER BY 1,2

-- Looking at Total Cases vs Population
-- Shows what Percentage of Population got Covid

SELECT Location, date, total_cases, Population, (CAST(total_cases AS FLOAT)/CAST(population AS FLOAT))*100 as InfectionPct
FROM [Portfolio Project]..CovidDeaths
WHERE location LIKE '%state%'
ORDER BY 1,2


--looking at Countries with Highest Infection Rate compared to Population

SELECT Location, Population, Max(total_cases) as HighestInfectionCount, Max((CAST(total_cases AS FLOAT)/CAST(Population AS FLOAT))*100) as InfectionPct
FROM [Portfolio Project]..CovidDeaths
-- WHERE location Like '%state%'
Group by Location, Population
ORDER BY InfectionPct desc


-- Showing the Countries with the Highest Deaths Count per Population


SELECT Location, Max(Cast(Total_deaths as int)) as TotalDeathCount
FROM [Portfolio Project]..CovidDeaths
Where continent is not null 
Group by Location
ORDER BY TotalDeathCount desc

-- Break things down by continent

Select Location, Max(Cast(Total_deaths as int)) as TotalDeathCount
From [Portfolio Project]..CovidDeaths
where continent is null
Group by location
Order by TotalDeathCount desc


-- Showing continents with the highest death count per population
Select continent, Max(total_deaths) as TotalDeathCount
From [Portfolio Project]..CovidDeaths
where continent is not null
Group by continent
Order by  TotalDeathCount desc


-- GLOBAL NUMBERS
SELECT date, SUM(coalesce(new_cases, 0)) as Totalnewcases ,SUM(cast(coalesce(new_deaths,0) as int)) as Totalnewdeaths, SUM(cast(coalesce(new_deaths, 0) as int))/SUM(cast(coalesce(new_cases,0) as int)) as Deathrate
FROM [Portfolio Project]..CovidDeaths
-- WHERE location LIKE '%state%'
where continent is not null
group by date 
ORDER BY 1,2

SELECT date, SUM(COALESCE(new_cases,0)) as Totalnewcases, SUM(COALESCE(cast(new_deaths as int),0)) as Totalnewdeaths, 
    SUM(COALESCE(cast(new_deaths as int),0))/SUM(COALESCE(new_cases,0)) as Deathrate
FROM [Portfolio Project]..CovidDeaths
WHERE continent is not null
GROUP BY date 
ORDER BY 1,2

SELECT --date, 
    SUM(COALESCE(new_cases,0)) as Totalnewcases, 
    SUM(COALESCE(cast(new_deaths as int),0)) as Totalnewdeaths, 
    CASE 
        WHEN SUM(COALESCE(new_cases,0)) = 0 THEN NULL 
        ELSE SUM(COALESCE(cast(new_deaths as int),0))/SUM(COALESCE(new_cases,0))
    END as Deathrate
FROM [Portfolio Project]..CovidDeaths
WHERE continent is not null
--GROUP BY date 
ORDER BY 1,2

Select dea.continent, dea.location, dea.population, dea.date, vac.new_vaccinations
From [Portfolio Project]..CovidDeaths dea
Join [Portfolio Project]..CovidVaccination vac
     On dea.location = vac.location
	 and dea.date = vac.date
Order by 1,2,3





