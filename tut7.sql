SELECT id, title
 FROM movie
 WHERE yr=1962

SELECT yr
 FROM movie
 WHERE title='Citizen Kane'

SELECT id, title, yr
 FROM movie
 WHERE title LIKE '%Star Trek%'
ORDER BY yr

SELECT id
 FROM actor
 WHERE name = 'Glenn Close'

SELECT id
 FROM movie
 WHERE title='Casablanca'

SELECT actor.name
FROM actor JOIN casting ON actor.id=casting.actorid
JOIN movie ON casting.movieid=movie.id
WHERE movie.title = 'Casablanca'

SELECT actor.name
FROM actor JOIN casting ON actor.id=casting.actorid
JOIN movie ON casting.movieid=movie.id
WHERE movie.title = 'Alien'

SELECT movie.title
FROM movie JOIN casting ON movie.id=casting.movieid
JOIN actor ON casting.actorid=actor.id
WHERE actor.name = 'Harrison Ford'

SELECT movie.title
FROM movie JOIN casting ON movie.id=casting.movieid
JOIN actor ON casting.actorid=actor.id
WHERE actor.name = 'Harrison Ford'AND casting.ord <>1

SELECT movie.title, actor.name
FROM movie JOIN casting ON movie.id=casting.movieid
JOIN actor ON casting.actorid=actor.id
WHERE casting.ord = 1 AND movie.yr=1962

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

SELECT movie.title, actor.name
FROM movie JOIN casting ON (movie.id=casting.movieid)
JOIN actor ON casting.actorid=actor.id
WHERE ord=1 AND movie.id IN (
  SELECT movieid FROM casting
WHERE actorid IN (SELECT id FROM actor
  WHERE name='Julie Andrews'))

SELECT DISTINCT actor.name
FROM movie JOIN casting ON (movie.id=casting.movieid)
JOIN actor ON casting.actorid=actor.id
WHERE casting.ord = 1
GROUP BY actor.name
HAVING COUNT(*) >=15

SELECT DISTINCT movie.title, COUNT(actorid)
FROM movie JOIN casting ON (movie.id=casting.movieid)
JOIN actor ON casting.actorid=actor.id
WHERE movie.yr = 1978
GROUP BY movie.title
ORDER BY COUNT(actorid) DESC, title

SELECT DISTINCT actor.name
FROM movie JOIN casting ON (movie.id=casting.movieid)
JOIN actor ON casting.actorid=actor.id
WHERE movie.id IN (
  SELECT movieid FROM casting
WHERE actorid IN (SELECT id FROM actor
  WHERE name='Art Garfunkel'))
AND actor.name <> 'Art Garfunkel'