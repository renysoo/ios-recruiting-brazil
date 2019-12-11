//
//  Network.swift
//  Desafio Concrete
//
//  Created by Rene on 10/12/19.
//  Copyright © 2019 Rene. All rights reserved.
//

import Foundation
import Combine

class Network {
    // APIkey: 50489ee2cb35e2d8fd42a8756ab7aa1e
    // MARK: - Constants

    let session = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?

    struct MovieDBAPI {
      static let scheme = "https"
      static let host = "api.themoviedb.org"
      static let path = "/3"
      static let key = "50489ee2cb35e2d8fd42a8756ab7aa1e"
    }

    // MARK: - API Components Request

    func makeSearchMoviesComponents (searchTerm: String, page: Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = MovieDBAPI.scheme
        components.host = MovieDBAPI.host
        components.path = MovieDBAPI.path + Requests.searchMovie.path

        components.queryItems = [
            URLQueryItem(name: "api_key", value: MovieDBAPI.key),
            URLQueryItem(name: "query", value: searchTerm),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "include_adult", value: "false")
        ]

        return components
    }

//    private func makeImageComponents (path: String) -> URLComponents {
//        var components = URLComponents()
//        components.scheme = MovieDBAPI.scheme
//        components.host = "image.tmdb.org"
//        components.path = "/t/p/original" + path
//
//        return components
//    }
    
    //private
    func makePopularComponents (page: Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = MovieDBAPI.scheme
        components.host = MovieDBAPI.host
        components.path = MovieDBAPI.path + Requests.popular.path

        components.queryItems = [
            URLQueryItem(name: "api_key", value: MovieDBAPI.key),
            URLQueryItem(name: "page", value: String(page))
        ]

        return components
    }

    // MARK: - Search Request Functions

    func searchMovie(
      search movie: String
    ) -> AnyPublisher<MovieResult, NetworkError> {
        return makeRequest(with: makeSearchMoviesComponents(searchTerm: movie, page: 1))
    }

//    func getImage(from path: String, completion: @escaping (Data) -> () ) {
//        makeImageTask(from: path) { data, response, error in
//            guard let data = data, error == nil else { return }
//            print("Download Finished")
//            DispatchQueue.main.async() {
//                completion(data)
//            }
//        }
//    }

    func getPopular(page: Int) -> AnyPublisher<MovieResult, NetworkError> {
        return makeRequest(with: makePopularComponents(page: page))
    }

    // MARK: - Make Request

    private func makeRequest <T> (with components: URLComponents) -> AnyPublisher<T, NetworkError> where T: Decodable {
        guard let url = components.url else {
            let error = NetworkError.requestFailed
            return Fail(error: error).eraseToAnyPublisher()
          }

        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                .networkProblem
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
    
//    private func makeImageTask(from url: String, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//        URLSession.shared.dataTask(with:
    //URLRequest(url: makeImageComponents(path: url).url ?? URL(fileURLWithPath:
    //"https://image.tmdb.org/t/p/original//rzRwTcFvttcN1ZpX2xv4j3tSdJu.jpg")), completionHandler: completion).resume()
//    }
    
}
