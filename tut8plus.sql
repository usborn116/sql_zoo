SELECT (A_STRONGLY_AGREE/(A_STRONGLY_AGREE + A_AGREE + A_NEUTRAL + A_DISAGREE + A_STRONGLY_DISAGREE)) * 100
FROM nss
WHERE question='Q01'
AND institution='Edinburgh Napier University'
AND subject='(8) Computer Science';

SELECT institution, subject
  FROM nss
 WHERE question='Q15'
   AND score >= 100

SELECT institution,score
  FROM nss
 WHERE question='Q15'
   AND subject='(8) Computer Science'
   AND score < 50

SELECT subject,SUM(response)
  FROM nss
 WHERE question='Q22'
   AND (subject='(8) Computer Science' OR subject='(H) Creative Arts and Design')
GROUP BY subject

SELECT subject,SUM(response*A_STRONGLY_AGREE)/100
  FROM nss
 WHERE question='Q22'
   AND (subject='(8) Computer Science' OR subject='(H) Creative Arts and Design')
GROUP BY subject

SELECT subject,ROUND(SUM(response*A_STRONGLY_AGREE)/SUM(response))
  FROM nss
 WHERE question='Q22'
   AND (subject='(8) Computer Science' OR subject='(H) Creative Arts and Design')
GROUP BY subject

SELECT institution,ROUND(SUM((score*response)/100)/SUM(response)*100)
  FROM nss
 WHERE question='Q22'
   AND (institution LIKE '%Manchester%')
GROUP BY institution

SELECT institution,SUM(sample),(SELECT sample FROM nss AS y
 WHERE question='Q01'
AND subject='(8) Computer Science'
AND y.institution = x.institution)
  FROM nss AS x
 WHERE question='Q01'
   AND (institution LIKE '%Manchester%')
GROUP BY institution