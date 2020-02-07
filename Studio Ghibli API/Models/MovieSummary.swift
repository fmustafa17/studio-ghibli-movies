//
//  MovieSummary.swift
//  Studio Ghibli API
//
//  Created by Farhana Mustafa on 2/3/20.
//  Copyright © 2020 Farhana Mustafa. All rights reserved.
//

import Foundation

struct MovieSummary: Codable {
  let count: Int?
  let results: [Movie]?
}
