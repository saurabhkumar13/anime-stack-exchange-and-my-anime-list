# Improvements

If you took a look at the last three list of recommendations you might have noticed some problems.

Like the list of recommendations for Gintama were all filled with Gintama OVAs, Specials and someone looking for someone looking for something to watch after Gintama would likely not be satisfied with the list.

## Problem

* So, the problem as one might have noticed with the Gintama list was that all Gintama offshoots had exactly the same list of genre.

## Solution

* A simple solution now would be to give weights to features.
We could have very different kind of recommendation systems which focus on
    * popular nodes
    * highly rated nodes
    * time at which they were released i.e. having anime which were released together closer (could be done using anime_id)
* The best way of course would be some combination of weights for all the attributes but grading the system could be a pain since such systems would only be used by humans and only they would be the best judges.

### Applying weights

We can simply multiply any attribute with some weight to give it more preference, the higher the weight more the preference.

```sql
update MAL_X_COO set DATA = DATA * :weight where ATT = 3;
```

The results would still be queried in the same way since we updated the table.
After giving more preference to popularity and ratings lets take a look at what Gintama recommendations look like now.

