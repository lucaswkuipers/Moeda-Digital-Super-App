//
//  FavoriteCollectionViewController.swift
//  Moeda Digital Super App
//
//  Created by Tabata Sabrina Sutili on 19/04/21.
//

import UIKit
import AlamofireImage
import API
import Commons
import Utilities
import Details


class FavoriteCollectionViewController: UIViewController {
    
  
    @IBOutlet weak var collection: UICollectionView!
    

    var list: String
    
    
    //MARK: Init
  
    public init(list: String){
        self.list = list
        
        super.init(nibName: "FavoriteCollectionViewController", bundle: Bundle(for: FavoriteCollectionViewController.self))
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let defaults = UserDefaults.standard
//        let array = defaults.object(forKey:"selectedCoinAssetID") as? [String]
//        print("--------ARRAY-----------------\(array)------------ARRAY------------")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        collection?.reloadData()
        setupCollectionView()
        collection?.reloadData()
        }
    
    func setupCollectionView() {
        collection?.dataSource = self
        collection?.delegate = self
        
        let nibCell = UINib(nibName: "FavoriteCollectionViewCell", bundle: Bundle(for: FavoriteCollectionViewController.self))
        collection?.register(nibCell, forCellWithReuseIdentifier: "FavoriteCollectionViewCell")
    }
    
}

extension FavoriteCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let arrayIds = Utilities.decode(idListString: list)
        return arrayIds.count 
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/2 - 20, height: collectionView.bounds.height/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
        
        let arrayIds = Utilities.decode(idListString: list)
        
        let favCoins = arrayIds[indexPath.row]
        
        cell.nameCoin.text = favCoins
        
        
        return cell
    }
    
   
    
    
}
