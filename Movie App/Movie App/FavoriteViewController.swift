//
//  FavoriteViewController.swift
//  Movie App
//
//  Created by Zain Cheema on 10/7/22.
//

import UIKit

class FavoriteViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var dataReceiver: [String]?
    var receiver: [UIImage]?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataReceiver!.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as! MoviesCollectionViewCell
        cell.movieName.text = dataReceiver![indexPath.row]
        cell.movieDisplay.image = receiver![indexPath.row]
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
