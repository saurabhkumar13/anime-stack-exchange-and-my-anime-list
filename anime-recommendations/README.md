# Nearest Neighbour Recommendations

Using the My Anime List (MAL) database, we would like to design a recommendation system which queries a list of top 10 recommendations based on a certain anime the user likes.

We'll start with a simple design then start tweaking it to get more interesting results.

I'll present how to work with the data, assuming it is already in the below format, `d` being the number of attributes.

| columnName | Type |
| -- | -- |
| ID | INT |
| c1 | FLOAT |
| c2 | FLOAT |
| ... | FLOAT |
| c`d` | FLOAT |

Using a pattern for column names allows us to do some things programmatically which would have been troublesome otherwise.

We would use three tables.

1. `MAL_ANIME` : The original table with raw values.
1. `MAL_X_NORM` : This table will contain normalized values for each attribute.
1. `MAL_X_COO` : This table will contain the data in Coordinate Format (COO).

DDL for MAL_ANIME
```sql
create table MAL_ANIME
(
	ANIME_ID NUMBER not null
		primary key,
	NAME VARCHAR2(200),
	GENRE VARCHAR2(500),
	TYPE VARCHAR2(100),
	EPISODE NUMBER,
	RATING FLOAT,
	MEMBERS NUMBER
)
```
> some random records:

| ANIME_ID | NAME | GENRE | TYPE | EPISODE | RATING | MEMBERS
| -- | -- | -- | -- | -- |
|186|Initial D Second Stage|Action, Cars, Drama, Seinen, Sports|TV|13|8.12|45825|
|10080|Kami nomi zo Shiru Sekai II|Comedy, Harem, Romance, Shounen, Supernatural|TV|12|8.12|194300|
|30885|Noragami Aragoto OVA|Action, Adventure, Shounen|OVA|2|8.12|58075|
|21469|Stand By Me Doraemon|Comedy, Kids, Sci-Fi, Shounen|Movie|1|8.12|5712|
|9941|Tiger &amp; Bunny|Action, Comedy, Mystery, Super Power|TV|25|8.12|104075|

DDL (shortened) for MAL_X_NORM
```sql
create table MAL_X_NORM
(
	ID NUMBER not null,
	C1 FLOAT,
	C2 FLOAT,
	C2 FLOAT,
	...
	C51 FLOAT,
	C52 FLOAT
)
```

DDL for MAL_X_COO
```sql
create table MAL_X_COO
(
	ID NUMBER,
	ATT NUMBER,
	DATA FLOAT
)
```

> Just some points to note at this point

* We have a total of 43 `GENRE` types. They were descritized to get 43 different attributes with values 1 for present and 0 for not.
* Same was done for `TYPE` to get 6 more attributes.
* Rest are numeric types, they were taken as is, i.e. 3 more attributes
* This gets us to the 52 attributes we are currently using
* You would have realized that we are not using `name` in our feature vector at all.
    * This is partially due to my personal bias that Anime names are mostly random and have a very little relation to the actual content/ feel of the anime and including them would only pollute our feature space.
        * Naruto (a type of fishcake)
        * Bleach (hair bleach)
        * Gintama (silver soul)
        * Ore, Twintail ni Narimasu (Gonna be the Twin-Tail)
    * Although if we wanted we could always use a bag of words model to directly use the names as feature.
    * Or a good approach could be to use the sentiment of the name as a feature, like certain anime names give a strong, exciting feel (Shingeki no Kyojin, Shingeki no Bahamut, Nanatsu no Taizai) others very laid-back and chill feel (Nichijou, Himouto! Umaru-chan) but this still would be very redundant since the `genre` gives this information very clearly.
* We can also have the ID as a feature since it very closely related to the release date of the Anime, id increments as the anime are added to the database and anime are added to the database as they are released.
