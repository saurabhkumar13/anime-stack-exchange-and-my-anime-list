# Brief Analysis of two datasets with PLSQL

## Dataset 1

* The first dataset was taken from *MyAnimeList*.
* It is a table of 12,291 records
* Each record had 7 attributes.
* DDL for MAL_ANIME
```sql
create table MAL_ANIME
(
	ANIME_ID NUMBER not null
		primary key,
	NAME VARCHAR2(200), -- Name of anime
	GENRE VARCHAR2(500), -- a list of comma separated genre
	TYPE VARCHAR2(100), -- one of the 6 types (Special/ONA/OVA/TV/Movie/Music)
	EPISODE NUMBER, -- number of episodes
	RATING FLOAT, -- aggregated rating
	MEMBERS NUMBER -- number of users associated
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


## Dataset 2

* The second dataset was taken from Anime Stack Exchange [[source]](archive.org/download/stackexchange)

| Table | Record Count|
| -- |
|Users |15,000|
|Posts |20,427|
|Post History| 72,946|
|Post Links |2,111|
|Votes| 1,40,011|
|Tags| 1,128|
|Badges| 31,356|

This is the complete dataset for Anime Stack Exchange.
Anime Stack Exchange works exactly like other Stack Exchange subdomains, like Stack Overflow

* Here is how it looks on the front end

![Anime Stack Exchange Frontend](/assets/stackexchange.png)

* Here is the ER diagram for the schema

![ERD Stack Exchange](/assets/erd.png)

