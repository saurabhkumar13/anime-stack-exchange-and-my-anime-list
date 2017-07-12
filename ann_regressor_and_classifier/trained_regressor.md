# Trained Regressor

A regressor was trained to predict the time in which any post from a user would get a reply, a reply in any form either a comment or a post.

The features that were used were all the features which are available before uploading a post, which were:
* Post related features
    * Title length
    * Body length
    * Time of upload from the start of the
        * day
        * week
        * month
        * year
* User related features
    * reputation
    * views
    * upvotes
    * downvotes
    * creation date

* This makes 11 features, but we also have tags which can be assigned to a post.
* The tags are not dynamically created but chosen from and there are a total of 1568 tags.
* So we end with a total of 11 continuous + 1568 discrete features i.e. 1579 features.

