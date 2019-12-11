//
//  Paginable.swift
//  Desafio Concrete
//
//  Created by Rene on 11/12/19.
//  Copyright © 2019 Rene. All rights reserved.
//

import Foundation

protocol Paginable {
    
    var currentPage: Int { get set }
    var totalPages: Int { get set }
    
}

extension Paginable {
    
    var hasMorePages: Bool {
        return currentPage < totalPages
    }
    
    var nextPage: Int {
        return hasMorePages ? currentPage + 1 : currentPage
    }
    
}
