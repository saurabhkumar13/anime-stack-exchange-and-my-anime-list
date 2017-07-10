# Further work
> Improving recommendations

* A simple way to improve recommendations would be to add more features to the data. Some obvious one include
    * Studio
    * Author
    * Music director
    * Rating (R-17+/PG-13/..)

> Publish it online

* This system could be published as a web service for anyone actually wanting to get some recommendations for watching anime

> Group Nearest Neighbor Queries

* Given a **list** of anime a user likes, we could query a list of recommendations using all of them.
* We could use a simple critieria like sum of euclidean distances of a node from all given nodes in a query.

> Improving the algorithm for computing the nearest neighbours

* Currently this method uses brute force to calculate the nearest neighbours and this is probably the best way to query for SQL.
* Since it works with disk memory and if we start storing trees in disk, the more we query the trees and store them, the more the computation slows down.
* The brute force method gets the result without using many intermediate structures.
* But there still might be a window for improvement even with SQL.
