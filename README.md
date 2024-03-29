![Movie Still from https://www.ghibli.jp/works/chihiro/](https://res.cloudinary.com/farheezyx3/image/upload/v1703883996/Studio%20Ghibli%20iOS%20App%20Screenshots/chihiro031.jpg)

# Studio Ghibli Movies
iOS application that displays Studio Ghibli movies.

## Technical Notes
This application uses the free [Studio Ghibli API](https://ghibliapi.herokuapp.com). The [Combine framework](https://developer.apple.com/documentation/combine) is used for data binding.

### Architecture

```
├── Studio Ghibli Application 
│ ├── Models 
│ │ ├── APIManager.swift 
│ │ └── Movie.swift 
│ ├── View
│ │ ├── MovieTableCell.swift 
│ │ └── ViewController.swift 
│ ├── ViewModel 
│ │ └── ViewModel.swift 
│ └── other files 
└── README.md
```

More in-depth details about this project's architecture are found in this blog post, ["Using the MVVM Architectural Design Pattern in iOS"](https://medium.com/dev-genius/using-the-mvvm-architectural-design-pattern-in-ios-c70e16352be5)

## Screenshots

- When the user first launches the application, they will see the entire list of released Studio Ghibli movies, with the title of the movie along with its director.
![Screenshot of the iOS Application showing data from Open Source Studio Ghibli API in a UITableView](https://res.cloudinary.com/farheezyx3/image/upload/v1644104663/Studio%20Ghibli%20iOS%20App%20Screenshots/Movie_Titles_and_Director.png)

- When the user selects a movie, the tableview cell will expand to show the description of the selected movie.
![Screenshot of the iOS Application showing the movie description of the selected cell](https://res.cloudinary.com/farheezyx3/image/upload/v1644104674/Studio%20Ghibli%20iOS%20App%20Screenshots/Movie_Descriptions.png)
