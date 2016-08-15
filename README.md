# angular-copter
An example Angular project creating a front end for a MySQL database. 

The database is intended to represenet a non-trivial application normalizend to BNF-3NF. It is inteneded ot both capture a catalog of elements, but also at least two classes of transactions on those elements. In this case the collection is a set of model aircraft being maintained and developed. The transactions repreesent both records of flight informaition and of repairs and modifications made to the aircraft. The flight report data is intended ultimately for data-miining to capture information corelating variations and performance. The repair data is for analysis of cost and maintenance.

The front end is an AngularJS implementation. It is intended to permit editing of some catalog features and all tranactional features of the DB. It is intended to capture a non-trivial web frontend using the most current possible version of "best practices" tools (where appropriate).

The AppServer is Tomcat, but should be platform agnostic. Current implementation is on a RaspberryPi 3 Model B. RESTful web services are provided by a PHP page using an *old* version of the "Slim" framework. In this case providing the support functionality of the framework would be less work than upgrading or changing frameworks. Most importatly it is not a current roadblock, and would take minimual effort to replace if needed.

Configuration issues outside of scope are noted in the comments.

The "src" folder has all the current code. The SQL file will set up the DB populated with a basic set of data. The "angular-copter" folder is what is deployed to the web server "as-is".

-W
