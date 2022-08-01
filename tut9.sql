SELECT COUNT(id) FROM stops

SELECT id FROM stops WHERE name = 'Craiglockhart'

SELECT stops.id, stops.name FROM stops
JOIN route ON stops.id = route.stop
WHERE route.num = 4
AND route.company = 'LRT'
ORDER BY pos

SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) = 2

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 
AND b.stop = 149

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='London Road'

SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Haymarket' AND stopb.name='Leith'

SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='Tollcross'

SELECT DISTINCT stopb.name, a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND a.company = 'LRT'

SELECT DISTINCT first_train.num, first_train.company, my_stop.name, second_train.num, second_train.company
FROM
(
	SELECT a.num, a.company, b.stop
	FROM route a
	JOIN route b ON (a.num = b.num AND a.company = b.company)
	WHERE a.stop = (
	SELECT id
	FROM stops
	WHERE name = 'Craiglockhart') 
) AS first_train
JOIN
(
	SELECT a.num, a.company, b.stop
	FROM route a
	JOIN route b ON (a.num = b.num AND a.company = b.company)
	WHERE a.stop = (
	SELECT id
	FROM stops
	WHERE name = 'Lochend') 
) AS second_train ON (first_train.stop = second_train.stop)
JOIN stops AS my_stop ON (first_train.stop = my_stop.id)
ORDER BY first_train.num, my_stop.name, second_train.num;