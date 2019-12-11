//
//  FirstViewController.swift
//  Desafio Concrete
//
//  Created by Rene on 10/12/19.
//  Copyright © 2019 Rene. All rights reserved.
//

import UIKit
import Combine

class CollectionViewController: UIViewController {

    weak var collectionView: UICollectionView!
    @Published var movieDataSource: [Movie] = []
    let fetcher = Network()
    private var disposables = Set<AnyCancellable>()

    override func loadView() {
        super.loadView()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        self.collectionView = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .white
        self.collectionView.dataSource = self as UICollectionViewDataSource
        self.collectionView.delegate = self as UICollectionViewDelegate
        self.collectionView.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: "PopularCollectionViewCell")
        self.fetchPopular()
    }

    func fetchPopular() {
        fetcher.getPopular(page: 1)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: errorHandler(value:), receiveValue: { [weak self] movieResult in
                guard let self = self else { return }
                self.movieDataSource = movieResult.results
                print(movieResult.results)
            })
            .store(in: &disposables)
    }

    func errorHandler(value: Subscribers.Completion<NetworkError>) {
        switch value {
        case .failure(.networkProblem):
                print(NetworkError.networkProblem.description)
        case .finished:
                break
        case .failure(.notAuthenticated):
                print(NetworkError.notAuthenticated.description)
        case .failure(.notFound):
                print(NetworkError.notFound.description)
        case .failure(.badRequest):
                print(NetworkError.badRequest.description)
        case .failure(.requestFailed):
                print(NetworkError.requestFailed.description)
        case .failure(.invalidData):
                print(NetworkError.invalidData.description)
        case .failure(.unknown(_)):
                print("unknown error")
        }
    }
}

extension CollectionViewController: UICollectionViewDataSource {

            func numberOfSections(in collectionView: UICollectionView) -> Int {
                return 1
            }
            
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return 10
            }

            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as? PopularCollectionViewCell
                if movieDataSource.isEmpty == false {
                    cell!.textLabel.text = movieDataSource[indexPath.row].title

                } else {
                    cell!.textLabel.text = "carregando"
                }
                return cell!
            }
        }

        extension CollectionViewController: UICollectionViewDelegate {

            func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                //aqui vai ser implementado o
                print(indexPath.row + 1)
            }
        }

        extension CollectionViewController: UICollectionViewDelegateFlowLayout {

            func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAt indexPath: IndexPath) -> CGSize {

                return CGSize(width: (collectionView.bounds.size.width - 40)/2, height: 250)
            }
            func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 5
            }

            func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                return 5
            }

            func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                insetForSectionAt section: Int) -> UIEdgeInsets {
                return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
            }
        }
