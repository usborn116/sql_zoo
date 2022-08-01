SELECT lastName, party, votes
  FROM ge
 WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY votes DESC

SELECT party, RANK() OVER (ORDER BY votes DESC) as posn
FROM ge
WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY party;

SELECT yr,party, votes,
      RANK() OVER (PARTITION BY yr ORDER BY votes DESC) as posn
  FROM ge
 WHERE constituency = 'S14000021'
ORDER BY yr,posn,party

SELECT constituency, party, votes, RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) as posn
FROM ge
WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
AND yr  = 2017
ORDER BY posn, constituency ASC;

SELECT constituency,party from (SELECT constituency,party, votes,RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) as r
  FROM ge
 WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
   AND yr  = 2017
ORDER BY r
) AS x
WHERE x.r=1

SELECT party, COUNT(party) from (SELECT constituency,party, votes,RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) as r
  FROM ge
 WHERE constituency LIKE 'S%'
   AND yr  = 2017
ORDER BY r
) AS x
WHERE x.r=1
GROUP BY party