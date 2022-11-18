//
//  ViewController.swift
//  Movie App
//
//  Created by Zain Cheema on 10/7/22.
//

import UIKit

class ViewController: UIViewController {
    var movieToSearch: String = ""
    var isButtonSelected = false
    var emptyArray: [String] = [String]()
    var pictures: [UIImage] = [UIImage]()
    
    @IBOutlet weak var searchMovie: UITextField!
    @IBOutlet weak var displayMoviePoster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var yearReleased: UILabel!
    @IBOutlet weak var genreOfMovie: UILabel!
    @IBOutlet weak var plot: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBAction func likedMovie(_ sender: UIButton) {
        if isButtonSelected == true{
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            isButtonSelected = false
        }else{
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            emptyArray.append(movieName.text!)
            pictures.append(displayMoviePoster.image!)
            isButtonSelected = true
        }
    }
    @IBAction func favoriteMovie(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FavoriteViewController") as! FavoriteViewController
        vc.dataReceiver = emptyArray
        vc.receiver = pictures
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func searchButton(_ sender: UIButton) {
        if isButtonSelected == true{
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            isButtonSelected = false
        }
        let search = searchMovie.text!
        let replaced = search.replacingOccurrences(of: " ", with: "+")
        let urlMovie = "https://www.omdbapi.com/?t=\(replaced)&apikey=be0733df"
        performURl(urlString: urlMovie)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func performURl(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, err in
                if let error = err{
                    print(error.localizedDescription)
                }
                if let safeData = data{
                    do{
                        let decodeData = try JSONDecoder().decode(Movies.self, from: safeData)
                        let url = decodeData.Poster
                        let data = try Data(contentsOf: URL(string: url)!)
                        DispatchQueue.main.async {
                            self.displayMoviePoster.image =  UIImage(data: data)
                            self.movieName.text = decodeData.Title
                            self.yearReleased.text = decodeData.Year
                            self.genreOfMovie.text = decodeData.Genre
                            self.plot.text = decodeData.Plot
                        }
                    }catch{
                        print("decoding failed")
                        print(String(describing: error))
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Could not find: \(self.searchMovie.text!)", message: "Please check the spelling and try again", preferredStyle: .alert)
                            let dismiss = UIAlertAction(title: "Dismiss", style: .default)
                            alert.addAction(dismiss)
                            self.present(alert, animated: true)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
