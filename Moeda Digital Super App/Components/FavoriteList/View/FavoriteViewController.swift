//
//  FavoriteViewController.swift
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

class FavoriteViewController: UIViewController {
    
    //MARK: Var
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tituloLabel: UILabel!
    
    var coinsResults: [Coin] = []

    let defaults = UserDefaults.standard
    let favoritesDefaults: String
    let arrayIds: [String]
    
  
    //MARK: Init
  
    public init(){
        
        let defaults = UserDefaults.standard
        self.favoritesDefaults = defaults.object(forKey: "favoriteList") as! String
        self.arrayIds = Utilities.decode(idListString: favoritesDefaults)
        
        super.init(nibName: "FavoriteViewController", bundle: Bundle(for: FavoriteViewController.self))
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Func

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        collection?.reloadData()
        setupCollectionView()
        collection?.reloadData()
        setData()
        accessibility()
        }
    
    func setupCollectionView() {
        collection?.dataSource = self
        collection?.delegate = self
        
        let nibCell = UINib(nibName: "FavoritesCollectionViewCell", bundle: Bundle(for: FavoritesCollectionViewCell.self))
        collection?.register(nibCell, forCellWithReuseIdentifier: "FavoritesCollectionViewCell")
        
    }
  
    
    func setData() -> String{
        let now = Date()

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "pt_br")

        let datetime = formatter.string(from: now)
        dayLabel.text = datetime
        
        return datetime
    }
    
    func request(id: String) -> CellsViewModel{
        
        let coinsResult = API.requestCoinList(on: self, assetId: id)
        let coin = coinsResult[0]
        let model = CellsViewModel.init(coin: coin)
        
        return model
    }
    
    func accessibility() {
     
        dayLabel.isAccessibilityElement = true
        dayLabel.accessibilityTraits = .staticText
        dayLabel.accessibilityLabel = "\(setData())"
        
        tituloLabel.isAccessibilityElement = true
        tituloLabel.accessibilityTraits = .image
        tituloLabel.accessibilityLabel = "Moeda Digital"
        
    }
}


//MARK: Collection View

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayIds.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/2 - 20, height: collectionView.bounds.height/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCollectionViewCell", for: indexPath) as! FavoritesCollectionViewCell
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
  
        let favCoin = arrayIds[indexPath.row]
        let model = request(id: favCoin)
        
        cell.nameCoin.text = model.name
        cell.siglaCoin.text = model.identifier
        cell.priceCoin.text = Utilities.formatCoin(coinAmount: model.price)
        
        let urlModel = model.icon
        let newUrl = urlModel.replacingOccurrences(of: "-", with: "")
        let urlStr = "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_128/\(newUrl).png"
        
        if let url = URL(string: urlStr ) {
            cell.imageIcon.af.setImage(withURL: url)
        }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let favCoin = arrayIds[indexPath.row]
        
        let detailsVC = DetailsViewController(id: favCoin)
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
   
    
    
}
