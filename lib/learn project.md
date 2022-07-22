# Lib
Main Source Code

# Project Structure
**MVVM**
## Model
Model folder contains all the data structures or classes. Including methods to covert json and get from json

## View 
- UI of the Application

## View Model
View model is used control the state of the application, basically using provider.

*for more information serach about MVVM pattern in google*

## Folder Structure
### Components
Used while building the screen, which are reusable

### Data
Data is used to fetch data from either API or Local db

### Fragements
It's just a part of UI/ Screen. Which are Tab components.

### Models
Models are data structure. These classes are used to directly communicate with backend API, In which all the data members name should be same as response json.

### Repository
Repository is used make data request, either by local db or API. In our case It's used to fetch data from API by using classes in Data folder.

### Routes
Used to control the location or URL and corresponding screen

### Screens
All the pages in the application.

### Store
Store is mainly used for theme of the application. leave it for now.

### Utils
Utilities like functions, some constants like, API URL, Colors, Assests URL, etc.

### View Model
View model used to handle the state in the UI, like set loading while API call, or make change to any variable which needs to be reflected in the UI.

### Widget
Custom Widget built to use in the application.

