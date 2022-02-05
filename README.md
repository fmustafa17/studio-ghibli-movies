# Studio Ghibli Movies
iOS application that displays Studio Ghibli movies using the Studio Ghibli API.

## Technical Notes
This application uses the free [Studio Ghibli API](https://ghibliapi.herokuapp.com). The [Combine framework](https://developer.apple.com/documentation/combine) is used for data binding.

## Screenshots

- When the user first launches the application, they will see the entire list of released Studio Ghibli movies, with the title of the movie along with its director.
![Screenshot of the iOS Application showing data from Open Source Studio Ghibli API in a UITableView](https://res.cloudinary.com/farheezyx3/image/upload/v1644104663/Studio%20Ghibli%20iOS%20App%20Screenshots/Movie_Titles_and_Director.png)

- When the user selects a movie, the tableview cell will expand to show the description of the selected movie.
![Screenshot of the iOS Application showing the movie description of the selected cell](https://res.cloudinary.com/farheezyx3/image/upload/v1644104674/Studio%20Ghibli%20iOS%20App%20Screenshots/Movie_Descriptions.png)
