CREATE DATABASE football_analytics;
USE football_analytics;

CREATE DATABASE IF NOT EXISTS football_analytics;

USE football_analytics;

CREATE TABLE IF NOT EXISTS players (
    Player_Name VARCHAR(150),
    Nationality VARCHAR(50),
    Position VARCHAR(50),
    Club VARCHAR(150),
    Competition VARCHAR(150),
    Age VARCHAR(20),
    Matches_Played INT,
    Matches_Started INT,
    Minutes_Played INT,
    Goals INT,
    Assists INT,
    Expected_Goals DECIMAL(10,2),
    Shots INT,
    Shots_On_Target INT,
    Pass_Completion_Pct DECIMAL(6,2),
    Tackles INT,
    Interceptions INT
);


LOAD DATA LOCAL INFILE
'D:/Football analysis project/Dataset/football_players_sql_utf8.csv'
INTO TABLE players
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SET GLOBAL local_infile = ON;

SHOW GLOBAL VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 1;

SHOW GLOBAL VARIABLES LIKE 'local_infile';

USE football_analytics;

SELECT COUNT(*) AS Total_Records
FROM players;

SELECT * FROM players
LIMIT 10;

USE football_analytics;


SELECT
    Player_Name,
    Club,
    Goals
FROM players
ORDER BY Goals DESC
LIMIT 10;

SELECT
    Player_Name,
    Club,
    Assists
FROM players
ORDER BY Assists DESC
LIMIT 10;

SELECT
    Player_Name,
    Club,
    Goals,
    Assists,
    (Goals + Assists) AS Goal_Contributions
FROM players
ORDER BY Goal_Contributions DESC
LIMIT 10;

SELECT
    Club,
    SUM(Goals) AS Total_Goals
FROM players
GROUP BY Club
ORDER BY Total_Goals DESC
LIMIT 10;

SELECT
    Position,
    ROUND(AVG(Minutes_Played), 2) AS Average_Minutes
FROM players
GROUP BY Position
ORDER BY Average_Minutes DESC;

SELECT
    Player_Name,
    Club,
    Goals,
    Assists,
    (Goals + Assists) AS Goal_Contributions,
    CASE
        WHEN (Goals + Assists) >= 20 THEN 'Excellent'
        WHEN (Goals + Assists) >= 10 THEN 'Good'
        WHEN (Goals + Assists) >= 5 THEN 'Average'
        ELSE 'Needs Improvement'
    END AS Performance_Level
FROM players
ORDER BY Goal_Contributions DESC;

SELECT
    Player_Name,
    Club,
    Goals
FROM players
WHERE Goals > (
    SELECT AVG(Goals)
    FROM players
)
ORDER BY Goals DESC;

WITH Player_Performance AS (
    SELECT
        Player_Name,
        Club,
        Goals,
        Assists,
        (Goals + Assists) AS Goal_Contributions
    FROM players
)
SELECT *
FROM Player_Performance
ORDER BY Goal_Contributions DESC
LIMIT 10;

SELECT
    Player_Name,
    Club,
    Goals,
    RANK() OVER (ORDER BY Goals DESC) AS Goal_Rank
FROM players;

SELECT
    Player_Name,
    Club,
    Position,
    Goals,
    RANK() OVER (
        PARTITION BY Position
        ORDER BY Goals DESC
    ) AS Position_Rank
FROM players;

