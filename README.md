Swifty Companion

Aim of the project is to build an application that will retrieve the information of a 42 student using the 42 API.

https://api.intra.42.fr

To use the app you need to install the necessary pods accomanied by a Podfile on the repo.
We used two, namely Alamofire and SwiftyJSON, allowing us to swiftly make an api call and manage the returne payload effortlessly.

The call only requires to display the User's information, skills, and projects doing with their grades.

We make the call and send the neccessary data to the respective Controllers, of which is recommended to use two controllers. On the second one an embeded one was used to neatly organise the objects.

All this information is passed by JSON and converted to the respective datatype when displayed.
