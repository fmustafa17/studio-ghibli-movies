//
//  NetworkManager.swift
//  Studio Ghibli API
//
//  Created by Farhana Mustafa on 2/3/20.
//  Copyright © 2020 Farhana Mustafa. All rights reserved.
//

import Foundation

struct NetworkLayer {
    
    static var shared = NetworkLayer()
    private init(){}
    
    static var jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    func fetchMovies(successHandler: @escaping ([Movie]) -> Void, errorHandler: @escaping (Error) -> Void) {
        
        let urlRequest = URLRequest(url: URL(string: "https://ghibliapi.herokuapp.com/films")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    errorHandler(NSError(domain: "", code: 0, userInfo: nil))
                }
                return
            }
            
           //print(data)
            
            do {
                let movies = try NetworkLayer.jsonDecoder.decode([Movie].self, from: data)
                
                DispatchQueue.main.async {
                    successHandler(movies)
                }
            } catch {
                
            }
        }
        task.resume()
    }
    
}
