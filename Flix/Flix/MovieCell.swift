//
//  MovieCell.swift
//  Flix
//
//  Created by apple on 1/12/19.
//  Copyright © 2019 utexas. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    
    @IBOutlet weak var contentLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
