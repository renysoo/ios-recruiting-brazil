//
//  NetworkTests.swift
//  Desafio ConcreteTests
//
//  Created by Rene on 11/12/19.
//  Copyright © 2019 Rene. All rights reserved.
//

import XCTest
@testable import Desafio_Concrete

class NetworkTests: XCTestCase {
    let sut = Network()
    override func setUp() {
    }

    override func tearDown() {
    }
    func testMakePopularComponents() {
        let url = sut.makePopularComponents(page: 1)
        let expectedUrl = URLComponents(string: "https://api.themoviedb.org/3/movie/popular?api_key=50489ee2cb35e2d8fd42a8756ab7aa1e&page=1")
        XCTAssertEqual(url, expectedUrl)
    }

    func testMakeSearchMovieComponents() {
        let url = sut.makeSearchMoviesComponents(searchTerm: "frozen", page: 1)
        let expectedUrl = URLComponents(string: "https://api.themoviedb.org/3/search/movie?api_key=50489ee2cb35e2d8fd42a8756ab7aa1e&query=frozen&page=1&include_adult=false")
        XCTAssertEqual(url, expectedUrl)
    }
}
