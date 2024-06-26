//
//  APIManager.swift
//  Studio Ghibli API
//
//  Created by Farhana Mustafa on 2/3/20.
//  Copyright © 2020 Farhana Mustafa. All rights reserved.
//

import Foundation

struct APIManager {

    static var jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .useDefaultKeys
        return jsonDecoder
    }()
    
    func getMovies(successHandler: @escaping (StudioGhibliMovies) -> Void, errorHandler: @escaping (Error) -> Void) {
        
        let urlRequest = URLRequest(url: URL(string: "https://ghibliapi.vercel.app/films/")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print(error ?? "Error occurred")
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    errorHandler(NSError(domain: "", code: 0, userInfo: nil))
                }
                return
            }

            do {
                let movies = try APIManager.jsonDecoder.decode(StudioGhibliMovies.self, from: data)
                
                DispatchQueue.main.async {
                    successHandler(movies)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
}
