//
//  ViewModel.swift
//  Studio Ghibli API
//
//  Created by fmustafa on 2/5/22.
//  Copyright © 2022 Farhana Mustafa. All rights reserved.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    var apiManager: APIManager?
    @Published var movies: [StudioGhibliMovie] = []

    init() {
        self.apiManager = APIManager()
    }

    func fetchMovies() {
        apiManager?.getMovies(successHandler: { [weak self] (movies) in
            self?.movies = movies
        }) { (error) in
            print("Error occurred: ", error)
        }
    }

}
