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
    
    //MARK: Var
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var dayLabel: UILabel!
    
    var coinsResults: [Coin] = []
    var list: String
    
    
    //MARK: Init
  
    public init(list: String){
        self.list = list
        
        super.init(nibName: "FavoriteCollectionViewController", bundle: Bundle(for: FavoriteCollectionViewController.self))
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Func

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        guard let returnValue: [NSString]? = UserDefaults.standard.object(forKey: "selectedCoinAssetID") as? [NSString] else {return}
//       let defaults = UserDefaults.standard
//       let array = defaults.object(forKey:"selectedCoinAssetID") as? [String]
//        print("--------ARRAY-----------------\(returnValue)------------ARRAY------------")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        collection?.reloadData()
        setupCollectionView()
        collection?.reloadData()
        setData()
        }
    
    func setupCollectionView() {
        collection?.dataSource = self
        collection?.delegate = self
        
        let nibCell = UINib(nibName: "FavoriteCollectionViewCell", bundle: Bundle(for: FavoriteCollectionViewController.self))
        collection?.register(nibCell, forCellWithReuseIdentifier: "FavoriteCollectionViewCell")
    }
    
    func setData() {
        let now = Date()

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "pt_br")

        let datetime = formatter.string(from: now)
        dayLabel.text = datetime
    }
    
}
//MARK: Collection View

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
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
       
        
        let arrayIds = Utilities.decode(idListString: list)
        let favCoin = arrayIds[indexPath.row]
        
        let coinsResult = API.requestCoinList(on: self, assetId: favCoin)
        coinsResults = coinsResult
        let coin = coinsResults[0]
        let model = CellsViewModel.init(coin: coin)
        
        cell.nameCoin.text = model.name
        cell.siglaCoin.text = model.identifier
        cell.priceCoin.text = Utilities.formatCoin(coinAmount: model.price)
        
        
        let urlModel = model.icon
        let newUrl = urlModel.replacingOccurrences(of: "-", with: "")
        let urlStr = "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_128/\(newUrl).png"
        
        if let url = URL(string: urlStr ) {
            cell.imageCoin.af.setImage(withURL: url)
        }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let arrayIds = Utilities.decode(idListString: list)
        let favCoin = arrayIds[indexPath.row]
        
        let detailsVC = DetailsViewController(id: favCoin)
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
   
    
    
}
