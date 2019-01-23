//
//  ViewController.swift
//  Flix
//
//  Created by apple on 1/12/19.
//  Copyright © 2019 utexas. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var moviesTableViews: UITableView!
    
    var Movies = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableViews.dataSource = self
        moviesTableViews.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                self.Movies = dataDictionary["results"] as! [[String: Any]]
                self.moviesTableViews.reloadData()
            }
        }
        task.resume()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTableViews.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = Movies[indexPath.row]
        
        let title = movie["title"] as! String
        let content = movie["overview"] as! String
        
        cell.titleLabel?.text = title
        cell.contentLabel?.text = content
        
        if let posterPath = movie["poster_path"] as? String {
            let posterBaseUrl = "http://image.tmdb.org/t/p/w185"
            let posterUrl = URL(string: posterBaseUrl + posterPath)
            cell.movieImage.af_setImage(withURL: posterUrl!)
        }
        else {
            cell.movieImage.image = nil
        }
    
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let movieSelected = sender as! MovieCell
        let indexPath = moviesTableViews.indexPath(for: movieSelected)
        if let detailsViewController = segue.destination as? MovieDetailsViewController {
            detailsViewController.movie = Movies[(indexPath?.row)!]
            print("Pass Successful")
        }
        moviesTableViews.deselectRow(at: indexPath!, animated: true)
    }
}

