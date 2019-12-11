//
//  MovieResult.swift
//  Desafio Concrete
//
//  Created by Rene on 11/12/19.
//  Copyright © 2019 Rene. All rights reserved.
//

import Foundation

struct MovieResult: Decodable, Paginable {
    let results: [Movie]
    var currentPage: Int
    var totalPages: Int
    
    private enum CodingKeys: String, CodingKey {
        case results = "results"
        case currentPage = "page"
        case totalPages = "total_pages"
    }
    
}
