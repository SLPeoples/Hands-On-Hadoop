ratings = LOAD '/user/maria_dev/ml-100k/u.data' AS (userID:int,movieID:int,rating:int,ratingTime:int);
metadata = LOAD '/user/maria_dev/ml-100k/u.item' USING PigStorage('|')
	AS (movieID:int,movieTitle:chararray,releaseDate:chararray,videoRelease:chararray, imdbLink:chararray);
nameLookup = FOREACH metadata GENERATE movieID,movieTitle;
groupedRatings = GROUP ratings BY movieID;
avgRatings = FOREACH groupedRatings GENERATE group AS movieID, AVG(ratings.rating) AS avgRating,
	COUNT(ratings.rating) AS numRatings;
BadMovies = FILTER avgRatings BY avgRating < 2.0;
BadWithData = JOIN BadMovies BY movieID, nameLookup BY movieID;
results = FOREACH BadWithData GENERATE nameLookup::movieTitle AS movieName,
	badMovies::avgRatings AS avgRatings, BadMovies::numRatings AS numRatings;
resultsSort = ORDER results BY numRatings DESC;
DUMP resultsSort;