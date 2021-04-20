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


public struct CellViewModel{
	
	public var icon: String
	public var name: String
	public var identifier: String
	public var price: Double
	
	
	public init(coin: Coin) {
		self.icon = String(coin.idIcon ?? " ")
		self.name = coin.name ?? "indisponivel"
		self.identifier = coin.assetID
		self.price = coin.priceUsd ?? 00
		
	}
}

class FavoriteViewController: UIViewController {
    
    //MARK: Var
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tituloLabel: UILabel!
    
    var allCoins = [Coin]()
    var favoriteCoins = [Coin]()
	var favoriteList = [String]()
    
  
    //MARK: Init
  
    public init(){
        super.init(nibName: "FavoriteViewController", bundle: Bundle(for: FavoriteViewController.self))
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	// MARK: - Functions
	func setAccessibility() {
		dayLabel.isAccessibilityElement = true
		dayLabel.accessibilityTraits = .staticText
		dayLabel.accessibilityLabel = "\(setDate())"
		
		tituloLabel.isAccessibilityElement = true
		tituloLabel.accessibilityTraits = .image
		tituloLabel.accessibilityLabel = "Moeda Digital"
	}
	
	func getDecodedFavoriteList() -> [String] {
        
        var favoriteList = UserDefaults.standard.value(forKey: "favoriteList")
        
        if favoriteList == nil {
            favoriteList = "BTC" 
        }
        
        let decodedFavoriteList = Utilities.decode(idListString: favoriteList as! String)
		
		return decodedFavoriteList
	}
	
	func setLocalFavoriteList() {
		favoriteList = getDecodedFavoriteList()
	}
	
	func setLocalFavoriteCoins() {
		setLocalFavoriteList()
		favoriteCoins = allCoins.filter { favoriteList.contains($0.assetID) }
	}
	
	func fetchData() {
		allCoins = API.requestCoinList(on: self)
	}
	
	func setupUI() {
		setDate()
		setLocalFavoriteCoins()

	}
	
	
	func setupCollectionView() {
		collection?.dataSource = self
		collection?.delegate = self
		
		let nibCell = UINib(nibName: "FavoritesCollectionViewCell", bundle: Bundle(for: FavoritesCollectionViewCell.self))
		collection?.register(nibCell, forCellWithReuseIdentifier: "FavoritesCollectionViewCell")
		
	}
  
	
	func setDate() {
		let now = Date()

		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		formatter.locale = Locale(identifier: "pt_br")

		let datetime = formatter.string(from: now)
		dayLabel.text = datetime
	}
    
    func accessibilityFavorites(){
            
            dayLabel.isAccessibilityElement = true
            dayLabel.accessibilityHint = "Data de hoje"
            
            tituloLabel.isAccessibilityElement = true
            tituloLabel.accessibilityHint = "Moeda digital - Titulo da pagina"
            
        }
	

    //MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
		
		fetchData()
		setupUI()
        accessibilityFavorites()
    }
    
    public override func viewWillAppear(_ animated: Bool) {

		setupCollectionView()
        setAccessibility()
		setLocalFavoriteCoins()
		collection.reloadData()
        }
}


//MARK: Collection View

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return favoriteCoins.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/2 - 20, height: collectionView.bounds.height/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCollectionViewCell", for: indexPath) as! FavoritesCollectionViewCell
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
  
        let favoriteCoin = favoriteCoins[indexPath.row]
        let favoriteCoinViewModel = CellViewModel(coin: favoriteCoin)
        
        cell.nameCoin.text = favoriteCoinViewModel.name
        cell.siglaCoin.text = favoriteCoinViewModel.identifier
        cell.priceCoin.text = Utilities.formatCoin(coinAmount: favoriteCoinViewModel.price)
        
        let urlModel = favoriteCoinViewModel.icon
        let newUrl = urlModel.replacingOccurrences(of: "-", with: "")
        let urlStr = "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_128/\(newUrl).png"
        
        if let url = URL(string: urlStr ) {
            cell.imageIcon.af.setImage(withURL: url)
        }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let favoriteCoin = favoriteCoins[indexPath.row]
        
		let detailsVC = DetailsViewController(id: favoriteCoin.assetID)
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
