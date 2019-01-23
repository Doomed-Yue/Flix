//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by apple on 1/17/19.
//  Copyright © 2019 utexas. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
   // @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var backDropImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    
    var movie: [String: Any]!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let title = movie["title"] as! String
        let content = movie["overview"] as! String
        let releaseDate = movie["release_date"] as! String
        
        titleLabel?.text = title
        titleLabel.sizeToFit()
        contentLabel?.text = content
        contentLabel.sizeToFit()
        releaseDateLabel?.text = releaseDate
        releaseDateLabel.sizeToFit()
        
        
        if let posterPath = movie["poster_path"] as? String {
            let posterBaseUrl = "http://image.tmdb.org/t/p/w185"
            let posterUrl = URL(string: posterBaseUrl + posterPath)
            posterImage.af_setImage(withURL: posterUrl!)
        }
        else {
            posterImage.image = nil
        }
        
        if let posterPath = movie["backdrop_path"] as? String {
            let posterBaseUrl = "http://image.tmdb.org/t/p/w780"
            let posterUrl = URL(string: posterBaseUrl + posterPath)
            backDropImage.af_setImage(withURL: posterUrl!)
        }
        else {
            backDropImage.image = nil
        }
        
       // scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: contentLabel.bottomAnchor).isActive = true
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
