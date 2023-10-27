--UNION OF TABLES BEACAUSE OF SQL LITE LIMITATION OF 4 GB--
CREATE TABLE appleStore_description AS

SELECT * FROM appleStore_description1

UNION ALL 

SELECT * FROM appleStore_description2

UNION ALL

SELECT * FROM appleStore_description3

UNION ALL

SELECT * FROM appleStore_description4

--EXPLORATORY ANALYSIS--
--check for missings--
SELECT COUNT(*) AS MissingValues 
FROM AppleStore
WHERE track_name ISNULL OR user_rating IS NULL OR prime_genre ISNULL

SELECT COUNT(*) AS MissingValues 
FROM appleStore_description
WHERE track_name ISNULL OR app_desc ISNULL
--COUNT AMOUNT OF REGISTER ON SAME APP--
SELECT COUNT(DISTINCT id) AS UniqueAppId
FROM AppleStore

SELECT COUNT(DISTINCT id) AS UniqueAppDescription
FROM appleStore_description
--Genre Count--

SELECT prime_genre, COUNT(*) AS GenreCount
FROM AppleStore
GROUP BY prime_genre
ORDER BY GenreCount DESC

--Rating-- 
SELECT min(user_rating) AS MinRating,
	   max(user_rating) AS MaxRating,
       avg(user_rating) as AvgRating
FROM AppleStore

--Price--

SELECT min(price) AS MinPrice,
	   max(price) AS MaxPrice,
       avg(price) as AvgPrice
FROM AppleStore

--Insights--
--IF PRICE OF THE APP IS RELATED WITH RATING--
SELECT CASE
    WHEN price > 0 THEN 'PAID'
    ELSE 'FREE'
  END AS Price_Class,
  avg(user_rating) as Avg_Rating
FROM AppleStore
GROUP BY Price_Class
ORDER BY Avg_Rating DESC
-- IF THERE IS A RELATION BETWEEN LANGUAGE AND RATING--AppleStore
SELECT CASE
	WHEN lang_num < 10 THEN 'LESS THAN 10 LANG'
    WHEN lang_num BETWEEN 10 and 30 THEN 'BETWEEN 10 AND 30 LANG'
    ELSE 'MORE THAN 30 LANG'
 END AS Lang_Count,
 avg(user_rating) AS Avg_Rating
FROM AppleStore
GROUP BY Lang_Count
ORDER BY Avg_Rating DESC
--CHECK GENRES WITH LOW RATING--
SELECT prime_genre,
	   avg(user_rating) AS Avg_Rating
FROM AppleStore
GROUP BY prime_genre
ORDER BY Avg_Rating DESC
LIMIT 10
--RELATION BETWEEN DESCRIPTION AND RATING--
SELECT CASE
	WHEN length(b.app_desc) < 500 THEN 'Short'
    WHEN length(b.app_desc) BETWEEN 500 AND 1000 THEN 'Medium'
    ELSE 'Long'
  END AS Description_count,
  avg(user_rating) AS Avg_Rating
FROM 
	AppleStore AS a
JOIN 
	appleStore_description AS b 
ON 
	a.id = b.id
GROUP BY Description_count
ORDER BY Avg_Rating DESC
--Top Rated apps by Genre-- 
SELECT prime_genre,
	   track_name,
       user_rating
FROM (
  SELECT prime_genre,
	     track_name,
         user_rating,
  RANK() OVER(PARTITION BY prime_genre ORDER BY user_rating DESC, rating_count_tot DESC) AS rank
  from AppleStore
  ) as a
WHERE a.rank = 1
 