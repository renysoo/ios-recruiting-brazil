//
//  Requests.swift
//  Desafio Concrete
//
//  Created by Rene on 11/12/19.
//  Copyright © 2019 Rene. All rights reserved.
//

import Foundation

enum Requests {
    case searchMovie
    case movieCredits(identifier: Int)
    case popular

    var path: String {
        switch self {
        case .searchMovie:
            return "/search/movie"
        case .movieCredits(let identifier):
            return "/movie/\(identifier)/credits"
        case .popular:
            return "/movie/popular"
        }
    }
}
