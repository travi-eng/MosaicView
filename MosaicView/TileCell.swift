//
//  TileCell.swift
//  MosaicView
//
//  Created by travi on 3/12/21.
//

import UIKit

class TileCell: UICollectionViewCell {
    
    static let reuseIdentifier = "TileCell"
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    var model: Tile?

    public func setModel(model: Tile) {
        self.model = model
        
        self.titleLabel.text = model.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
