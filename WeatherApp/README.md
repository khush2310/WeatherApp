#  Weather App 
###Design pattern
- It is developed in Swift using MVC architecture. 
    -The Model Folder has the model files used for the app.
    -The View Folder contains the Main.storyboard and also the Resuable view which is used to display weather data
    -The Controller folder has the View controller which will be responsible for business logic and UI handling.
### Networking
- The API used is open-meteo.com/ which will display 7-day forecast.
- The API calls are made using URLSession

### User Interface
-The App supports both Light and Dark modes and the text color, view background, background image will change accordingly.

###Unit testing
-Unit testing covers the Networking class with Mocking the URLSession.
-Unit testing is also done for the models.
-Code Coverage:78%




