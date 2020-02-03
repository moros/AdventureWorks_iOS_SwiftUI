# AdventureWorks_iOS_SwiftUI
App using AdventureWorks data (sqlserver), rendering different stuff in SwiftUI.

This is a complete example, using a ASP.NET Core API to fetch a small
amount of data from the AdventureWorks database. Only exposing department data at 
the moment.

##References:

### location of where AdventureWorks database can be downloaded from
https://github.com/Microsoft/sql-server-samples/tree/master/samples/databases/adventure-works

### Info on how to restore database (linux or docker [such as on Mac])
https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-migrate-restore-database?view=sql-server-ver15

### Need to copy database files to docker instance
https://database.guide/how-to-restore-a-sql-server-database-on-a-mac-using-sql-operations-studio/

### Good article on creating a list in SwiftUI
https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation

### Trust localhost cert
https://asp.net-hacker.rocks/2018/07/05/aspnetcore-ssl.html

### Easy way to install localhost cert on simulator
https://github.com/yageek/iostrust