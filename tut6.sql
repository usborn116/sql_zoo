SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'

SELECT id,stadium,team1,team2
  FROM game WHERE id = 1012

SELECT player,teamid,stadium, mdate
  FROM game JOIN goal ON (game.id=goal.matchid) WHERE teamid = 'GER'

SELECT team1, team2, player
  FROM game JOIN goal ON (game.id=goal.matchid) WHERE player LIKE 'Mario%'

SELECT player, teamid, eteam.coach, gtime
  FROM goal JOIN eteam on teamid=id
 WHERE gtime<=10

 SELECT game.mdate, eteam.teamname
  FROM game JOIN eteam on team1=eteam.id
 WHERE eteam.coach = 'Fernando Santos'

 SELECT goal.player
  FROM goal JOIN game ON goal.matchid=game.id
 WHERE stadium =  'National Stadium, Warsaw'

 SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id 
    WHERE (team1='GER' OR team2='GER') AND teamid != 'GER';

SELECT teamname, COUNT(*)
  FROM eteam JOIN goal ON id=teamid
GROUP BY teamname

SELECT stadium, COUNT(*)
  FROM game JOIN goal ON id=matchid
GROUP BY stadium

SELECT game.id, game.mdate, COUNT(*)
FROM game JOIN goal ON game.id = goal.matchid
WHERE (game.team1 = 'POL' OR game.team2 = 'POL')
GROUP BY game.id, game.mdate

SELECT game.id, game.mdate, COUNT(*)
FROM game JOIN goal ON game.id = goal.matchid
WHERE (game.team1 = 'GER' OR game.team2 = 'GER') AND goal.teamid = 'GER'
GROUP BY game.id, game.mdate

SELECT mdate, team1,
SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1, team2, SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
FROM game JOIN goal ON matchid = id
GROUP BY mdate,matchid,team1,team2
ORDER BY mdate,matchid,team1,team2;