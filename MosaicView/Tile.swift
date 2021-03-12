//
//  Tile.swift
//  MosaicView
//
//  Created by travi on 3/12/21.
//

import Foundation

class Tile: Hashable {
    
    var identifier: String {
        return title
    }
    
    var title: String!
    
    init(title: String) {
        self.title = title
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    public static func == (lhs: Tile, rhs: Tile) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
