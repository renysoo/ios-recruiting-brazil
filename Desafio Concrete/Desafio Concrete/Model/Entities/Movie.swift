//
//  Movie.swift
//  Desafio Concrete
//
//  Created by Rene on 10/12/19.
//  Copyright © 2019 Rene. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let identifier: Int
    let title: String
    let genres: [Int]
    let overview: String
    let posterPath: String?
    let releaseDate: String
}
