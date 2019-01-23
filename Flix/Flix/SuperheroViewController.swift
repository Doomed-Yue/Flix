//
//  SuperheroViewController.swift
//  Flix
//
//  Created by apple on 1/20/19.
//  Copyright © 2019 utexas. All rights reserved.
//

import UIKit
import AlamofireImage

class SuperheroViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    
    
    @IBOutlet var superherCollectionView: UICollectionView!
    
    var movies = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        superherCollectionView.dataSource = self
        superherCollectionView.delegate = self
        
        let layout = superherCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        let width = (view.frame.size.width - layout.minimumLineSpacing) / 2
        
        layout.itemSize = CGSize(width: width, height: width * 8 / 5)
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.movies = dataDictionary["results"] as! [[String: Any]]
                self.superherCollectionView.reloadData()
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
            }
        }
        task.resume()

        // Do any additional setup after loading the view.
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = superherCollectionView.dequeueReusableCell(withReuseIdentifier: "SuperheroViewCell", for: indexPath) as! SuperheroViewCell
        
        let movie = movies[indexPath.item]
        
        if let posterPath = movie["poster_path"] as? String {
            let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
            let posterUrl = URL(string: posterBaseUrl + posterPath)
            cell.superheroImage.af_setImage(withURL: posterUrl!)
        }
        else {
            cell.superheroImage.image = nil
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! SuperheroViewCell
        let index = superherCollectionView.indexPath(for: cell)
        
        if let movieDetail = segue.destination as? MovieDetailsViewController {
            movieDetail.movie = movies[index!.item]
        }
        
    }
    

}
