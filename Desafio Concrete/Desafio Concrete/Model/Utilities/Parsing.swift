//
//  Parsing.swift
//  Desafio Concrete
//
//  Created by Rene on 11/12/19.
//  Copyright © 2019 Rene. All rights reserved.
//

import Foundation
import Combine
import UIKit

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, NetworkError> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            .invalidData
        }
        .eraseToAnyPublisher()
}
