//
//  ComicTableViewCell.swift
//  MarvelEssentials
//
//  Created by Nigel Mestach on 25/11/2018.
//  Copyright © 2018 Nigel Mestach. All rights reserved.
//

import UIKit

class ComicTableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var savedButton: UIButton!
    @IBOutlet weak var comicLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
