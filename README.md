# WeatherGoat
A simple weather app using the OpenWeatherMap API.

## Description
This app is a demonstration of my understanding of MVC (Model View Controller) architecture as well as an attempt to utilize principles from DCI (Data Context and Interaction) architecture. This utilization of DCI will focus on creating distinct use cases that are triggered by user actions. Each use case should contain functionality that maps to the user's mental model of the use case and expectations for the app.

## Development Steps

### Define Requirements
* As a user, I should be able to get the weather forecast for my current location.
* As a user, for each date and days of the week, I should see a weather icon, min temperature, and max temperature.
* As a user, when I tap on a specific day, I should be able to see a weather description.

### Determine Basic App Architecture

```
Model
// Contains the data and data transformation functionality the app needs.
- Data Model
    - weatherIcon
    - day
    - minTemp
    - maxTemp
    - description
- View
// Contains all of the UI configuration for the app.
    - UINavigationController
        - rightBarButtonItem
        - UITableView
            - Display daily forecast
    - UITableViewCell
        - Display daily weather info
    - DetailView
        - Display weather description
- Controller
// Contains functionality for displaying model data in the views and the use cases that are triggered by user actions.
    - GetWeather
    // Gets the weather at the current location
        - Needs to check authorization for Location 
        - Refresh weather data 
    - Display Weather Details
    // Display the weather description in a detail view
- Service
// An additional layer that serves as an interface between the API and the data model. Allows for isolated updating if breaking changes are introduced to the API and for dependency injection for tests.
    - URLSession
    - JSON decoding
```

### Milestones
Sketch out the major development milestones to aid in planning, goal tracking, and setting expectations for stakeholders. 
1. Weather Info Service
    * Successfully connect to the API
    * Successfully decode JSON data
1. Data Modeling and Display
    * Successfully consume and display weather data
1. UI Construction
    * Successfully display the data in the app UI
1. Feature Testing
    * Ensure that the app fulfills all the requirements
    * Look for any remaining bugs (QA testing should happen regularly during development)
1. Tech Debt
    * Pay back tech debt accumulated during development

