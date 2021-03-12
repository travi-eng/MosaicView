//
//  MosaicViewController.swift
//  MosaicView
//
//  Created by travi on 3/12/21.
//

import UIKit

final class MosaicViewController: UICollectionViewController {
    
    enum Section: Int, CaseIterable {
        case tile
    }
    
    private static var sectionsData: [TileSectionData] = []
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Tile>? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(UINib(nibName:"TileCell", bundle:Bundle.main), forCellWithReuseIdentifier: TileCell.reuseIdentifier)
        
        self.collectionView.delegate = self
        self.collectionView.setCollectionViewLayout(layout(), animated: false)
        
        self.configureDataSource()
    }


    // MARK: UICollectionViewLayout
    
    public func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            var section: NSCollectionLayoutSection?
           
            let createGroup0 = { () -> NSCollectionLayoutGroup in
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2.0), heightDimension: .fractionalHeight(1.0)))
                item.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10)
                let subitem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)))
                subitem.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10)
                let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/2.0), heightDimension: .fractionalHeight(1.0))
                let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: [subitem])
                
                let rowSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(300))
                let row = NSCollectionLayoutGroup.horizontal(layoutSize: rowSize, subitems: [item, verticalGroup])
                return row;
            }
            let createGroup1 = { () -> NSCollectionLayoutGroup in
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/2.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10)
                let rowSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0/6.0))
                let row = NSCollectionLayoutGroup.horizontal(layoutSize: rowSize, subitems: [item])
                return row
            }
            let createGroup2 = { () -> NSCollectionLayoutGroup in
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/2.0), heightDimension: .fractionalHeight(1.0)))
                item.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10)
                let subitem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)))
                subitem.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10)
                let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/2.0), heightDimension: .fractionalHeight(1.0))
                let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: [subitem])
                
                let rowSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0/3.0))
                let row = NSCollectionLayoutGroup.horizontal(layoutSize: rowSize, subitems: [verticalGroup, item])
                return row;
            }
            
            let row0 = createGroup0()
            let row1 = createGroup1()
            let row2 = createGroup2()
            let row3 = createGroup1()
            
            let containerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(900))
            let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: containerGroupSize, subitems: [row0, row1, row2, row3])
            section = NSCollectionLayoutSection(group: containerGroup)
            section!.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 10, bottom: 10, trailing: 10)

            return section
        }
        
        return layout
    }
    
    // MARK: UICollectionViewDataSource
    
    func configureDataSource() {
        guard let cv = self.collectionView else { return }
        
        // data source
        let ds = UICollectionViewDiffableDataSource<Section, Tile>(collectionView: cv) { (cv: UICollectionView, indexPath: IndexPath, model: Tile) -> UICollectionViewCell? in
            var cell: TileCell
            
            if MosaicViewController.sectionsData[indexPath.section].identifier == .tile {
                cell = cv.dequeueReusableCell(withReuseIdentifier: TileCell.reuseIdentifier, for: indexPath) as! TileCell
            }

            else {
                fatalError()
            }
            
            cell.setModel(model: model)
            return cell
        }
       
        MosaicViewController.sectionsData = []
        dataSource = ds
        collectionView.dataSource = dataSource
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Tile>()
        
        snapshot.appendSections([.tile])
        let tiles: [Tile] = [Tile.init(title: "First tile"), Tile.init(title: "Second tile"), Tile.init(title: "Third tile"), Tile.init(title: "Fourth tile"), Tile.init(title: "Fifth tile"), Tile.init(title: "Sixth tile"), Tile.init(title: "Seventh tile"), Tile.init(title: "Eight tile"), Tile.init(title: "Nineth tile"), Tile.init(title: "Tenth tile")]
        MosaicViewController.sectionsData.append(TileSectionData.init(identifier: .tile, items: tiles))

        // Add items
        for i in 0..<MosaicViewController.sectionsData.count {
            snapshot.appendItems(MosaicViewController.sectionsData[i].items, toSection: MosaicViewController.sectionsData[i].identifier)
        }
        
        ds.apply(snapshot, animatingDifferences: false)
    }
}


private class TileSectionData {
    let identifier: MosaicViewController.Section
    var items: [Tile]
    
    init(identifier: MosaicViewController.Section, items: [Tile]) {
        self.identifier = identifier
        self.items = items
    }
}
