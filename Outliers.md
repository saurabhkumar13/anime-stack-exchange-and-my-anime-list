# Outlier Detection

Using clustering with only the below given features and data of 12291 anime, 42 outliers were found.
Lets analyze some of them

| Anime | Type | Episodes | Rating | Members |
| -- | -- | -- | -- | -- |
| Naruto	| TV	| 220	| 7.81 | 683297 |
| Mononoke Hime	| Movie	| 1	| 8.81 | 339556 |
| Sen to Chihiro no Kamikakushi	| Movie	| 1	| 8.93 | 466254 |
| Dragon Ball	| TV	| 153	| 8.16 | 316102 |
| FLCL	| OVA	| 6	| 8.06 | 305165 |
| InuYasha	| TV	| 167	| 7.89 | 281632 |
| Bleach	| TV	| 366	| 7.95 | 624055 |
| Yu☆Gi☆Oh! Duel Monsters	| TV	| 224	| 7.57 | 132099 |
| Pokemon	| TV	| 276	| 7.43 | 229157 |
| Hellsing Ultimate	| OVA	| 10	| 8.59 | 297454 |
| Dragon Ball Z	| TV	| 291	| 8.32 | 375662 |
| Ginga Eiyuu Densetsu	| OVA	| 110	| 9.11 | 80679 |
| Gintama	| TV	| 201	| 9.04 | 336376 |
| D.Gray-man	| TV	| 103	| 8.2	|34399 |
| Death Note	| TV	| 37	| 8.71 | 1013917 |
| Code Geass: Hangyaku no Lelouch	| TV	| 25	| 8.83 | 715151 |
| Katekyo Hitman Reborn!	| TV	| 203	| 8.37 | 258103 |
| Doraemon (1979)	| TV	| 1787	| 7.76 | 14233 |
| Ninja Hattori-kun	| TV	| 694	| 6.92 | 2116 |
| Hetalia Axis Powers	| ONA	| 52	| 7.76 | 144898 |
| Fullmetal Alchemist: Brotherhood	| TV	| 64	| 9.26 | 793665 |
| Manga Nippon Mukashibanashi (1976)	| TV	| 1471	| 6.48 | 406 |
| Angel Beats!	| TV	| 13	| 8.39 | 717796 |
| Fairy Tail	| TV	| 175	| 8.22 | 584590 |
| Obake no Q-tarou (1985)	| TV	| 510	| 6.54 | 161 |
| Hoka Hoka Kazoku	| TV	| 1428	| 6.05 | 194 |
| Shima Shima Tora no Shimajirou	| TV	| 726	| 6.25 | 237 |
| Sekai Monoshiri Ryoko	| TV	| 1006	| 5.92 | 153 |
| Hunter x Hunter (2011)	| TV	| 148	| 9.13 | 425855 |
| Perman (1983)	| TV	| 526	| 6.34 | 447 |
| Sword Art Online	| TV	| 25	| 7.83 | 893100 |
| Oyako Club	| TV	| 1818	| 6.18 | 160 |
| Shingeki no Kyojin	| TV	| 25	| 8.54 | 896229 |
| Kotowaza House	| TV	| 773	| 5.63 | 110 |
| Fairy Tail (2014)	| TV	| 102	| 8.25 | 255076 |
| Monoshiri Daigaku: Ashita no Calendar	| TV	|1274	| 6.8	 |12 |
| Manga Jinbutsushi	| TV	| 365	| 6.91 | 71 |
| Kirin Monoshiri Yakata	| TV	| 1565	| 5.56 | 116 |
| Goman-hiki	| Movie	| 100	| 7	 | 56 |
| Ninja-tai Gatchaman ZIP!	| TV|	475	| 5.5	 |46 |
| Kirin Ashita no Calendar	| TV	| 1306	| 6.43 | 59 |
| Shelter	| Music	| 1	| 8.38 | 71136 |


## Some observations

* Naruto is the only TV series with more than 200 episodes and 650k members.

* There are many naruto like anime with great number of episodes and also a great number of fans like Bleach, Dragon Ball Z, Pokemon

* There are also anime with a great number of episodes yet few members like Doraemon, Ninja Hattori

* You might see where I am going with this.

* How about we try clustering these outliers.

# Clustering Outliers

| Anime | Type | Episodes | Rating | Members | Cluster |
| -- | -- | -- | -- | -- | -- |
| Naruto	| TV	| 220	| 7.81 | 683297 | 1 |
| Mononoke Hime	| Movie	| 1	| 8.81 | 339556 | 3 |
| Sen to Chihiro no Kamikakushi	| Movie	| 1	| 8.93 | 466254 | 3 |
| Dragon Ball	| TV	| 153	| 8.16 | 316102 | 2 |
| FLCL	| OVA	| 6	| 8.06 | 305165 | 5 |
| InuYasha	| TV	| 167	| 7.89 | 281632 | 2 |
| Bleach	| TV	| 366	| 7.95 | 624055 | 1 |
| Yu☆Gi☆Oh! Duel Monsters	| TV	| 224	| 7.57 | 132099 | 2 |
| Pokemon	| TV	| 276	| 7.43 | 229157 | 2 |
| Hellsing Ultimate	| OVA	| 10	| 8.59 | 297454 | 5 |
| Dragon Ball Z	| TV	| 291	| 8.32 | 375662 | 2 |
| Ginga Eiyuu Densetsu	| OVA	| 110	| 9.11 | 80679 | -- |
| Gintama	| TV	| 201	| 9.04 | 336376 | 2 |
| D.Gray-man	| TV	| 103	| 8.2	|34399 | 2 |
| Death Note	| TV	| 37	| 8.71 | 1013917 | 1 |
| Code Geass: Hangyaku no Lelouch	| TV	| 25	| 8.83 | 715151 | 1 |
| Katekyo Hitman Reborn!	| TV	| 203	| 8.37 | 258103 | 2 |
| Doraemon (1979)	| TV	| 1787	| 7.76 | 14233 | 4 |
| Ninja Hattori-kun	| TV	| 694	| 6.92 | 2116 | 0 |
| Hetalia Axis Powers	| ONA	| 52	| 7.76 | 144898 | -- |
| Fullmetal Alchemist: Brotherhood	| TV	| 64	| 9.26 | 793665 | 1 |
| Manga Nippon Mukashibanashi (1976)	| TV	| 1471	| 6.48 | 406 | 4 |
| Angel Beats!	| TV	| 13	| 8.39 | 717796 | 1 |
| Fairy Tail	| TV	| 175	| 8.22 | 584590 | 1 |
| Obake no Q-tarou (1985)	| TV	| 510	| 6.54 | 161 | 0 |
| Hoka Hoka Kazoku	| TV	| 1428	| 6.05 | 194 | 4 |
| Shima Shima Tora no Shimajirou	| TV	| 726	| 6.25 | 237 | 0 |
| Sekai Monoshiri Ryoko	| TV	| 1006	| 5.92 | 153 | -0 |
| Hunter x Hunter (2011)	| TV	| 148	| 9.13 | 425855 | 2 |
| Perman (1983)	| TV	| 526	| 6.34 | 447 | 0 |
| Sword Art Online	| TV	| 25	| 7.83 | 893100 | 1 |
| Oyako Club	| TV	| 1818	| 6.18 | 160 | 4 |
| Shingeki no Kyojin	| TV	| 25	| 8.54 | 896229 | 1 |
| Kotowaza House	| TV	| 773	| 5.63 | 110 | 0 |
| Fairy Tail (2014)	| TV	| 102	| 8.25 | 255076 | 2 |
| Monoshiri Daigaku: Ashita no Calendar	| TV	|1274	| 6.8	 |12 | 4 |
| Manga Jinbutsushi	| TV	| 365	| 6.91 | 71 | 0 |
| Kirin Monoshiri Yakata	| TV	| 1565	| 5.56 | 116 | 4 |
| Goman-hiki	| Movie	| 100	| 7	 | 56 | -- |
| Ninja-tai Gatchaman ZIP!	| TV|	475	| 5.5	 |46 | 0 |
| Kirin Ashita no Calendar	| TV	| 1306	| 6.43 | 59 | 4 |
| Shelter	| Music	| 1	| 8.38 | 71136 | -- |

## Clusters data

|Cluster|0|1|2|3|4|5|
| -- | --| -- | --| -- | --| -- |
|members|7|9|10|2|7|2|
* Now it should be clear what I was trying to say.

* Outlier anime belonging with cluster 1, are most famous with the 'gaijin' world. Naruto, Bleach, Code Geass, FMA these are long running anime with a great number of fan following.

* Cluster 2 is also close to cluster 1 but with less members like Gintama, Dragon Ball

* Cluster 4,0 has long running anime with little fan following. These anime, since they are long running must be famous but have no members in this online community. We could say that these are the old anime not really famous among the online community, like Doraemon, Ninja Hattori which are targeted for children.

* Cluster 4,0 were further divided because of the sheer number of episodes cluster 4 has, almost double of cluster 0


