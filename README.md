# Project Title

Data structures and Algorithms Matcher

# Simple overview of use/purpose.

Building a search engine that matches the problem with the suitable algorithm/ data structures to be used.

## Description

To grasp a bit of the concepts used in search engines, I've chosen this idea to be the purpose of creating a website. 
The finished website should contain the following:

# Version 0.1

1. As a user I can create/update/delete an account.
2. As a user I can sign in.
3. As a user I can create a post
4. As a User I can comment on a post 
5. As a user I can search for a DataStructure based on its name or description. 
6. As a User I can view posts. 
7. As a User I can view comments. 
8. As a User I can favourite/unfavourite posts.
9. As a User I can view my own favourite posts.
10. As a User I can search for an Algorithm/Data Structure and see the results based on that. 



## Getting Started

### Dependencies

* Describe any prerequisites, libraries, OS version, etc., needed before installing program.
1. A code editor (ruby mine or VScode).
2. Ruby installed on the machine version version 2.7.0
3. Rails version 5.2.7.1
4. postgresql installed locally

### Installing

* How/where to download your program
* Any modifications needed to be made to files/folders

# To Trigger the Crawler 

It gets triggered on the first time of running the server

### Executing program

* How to run the program
* Step-by-step bullets
1. ensure that postgres is installed locally 
2. Clone the repository
3. Change the username in the development environment in the database.yml file under config then run rails db:migrate
4. Run bundle install command from terminal 
5. start the server using rails s command

* The Website Link for heroku: https://algo-ds-search-engine.herokuapp.com/
```

## Version History

* 0.2

   * Optimize the crawler 
   * Make the crawler run indenfinetely. 
   * Optimize extracting Data from HTML (Instead of extracting data from HTML find other alternatives like extracting data from Databases instead). 
   * Add an Admin role to approve posts. 
   * Add feature to favourite comments.
   * Add replying feature to comments. 
   * Allow users to upload their pictures
* 0.1
    * Initial Release

