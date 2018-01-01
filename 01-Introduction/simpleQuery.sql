SELECT movie_id, count(movie_id) as ratingCount
FROM ratings
GROUP BY movie_id
ORDER BY ratingCount
DESC;

SELECT name
FROM movie_names
WHERE movie_id = 50;
# Star Wars;