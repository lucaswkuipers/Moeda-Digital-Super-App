//
//  DetailsViewController.swift
//  Details
//
//  Created by Tabata Sabrina Sutili on 15/04/21.
//
import UIKit
import LucasCoinAPI
import LucasUtilities
import AlamofireImage


public class DetailsViewController: UIViewController {

    //MARK: IBOutlet
    
    @IBOutlet weak var siglaLabel: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var lastHour: UILabel!
    @IBOutlet weak var lastMonth: UILabel!
    @IBOutlet weak var lastDay: UILabel!

    
    //MARK: Variables
    

	var favoriteList = [String]()
    var coin: Coin
    var id: String
    
    
    //MARK: Init
    
    public init(coin: Coin){
        self.coin = coin
        
        id = coin.assetID
        super.init(nibName:"DetailsViewController", bundle: Bundle(for: DetailsViewController.self))
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
				
		retrieveFavoriteList()
        accessibilityDetails()
        setupUI()
        
    }
	
	// MARK: - IBActions
	
	@IBAction func toggleFavorite(_ sender: Any) {
		print("Clicked toggle favorite button")

		if isFavorite(id: self.id) {
			removeFromFavorite(id)
		} else {
			addToFavorite(id)
		}
		favoriteList = getDecodedFavoriteList()
		setupDynamicUI()
	}
	
	// MARK: - Functions
	func removeFromFavorite(_ id: String) {
		let modifiedFavoriteList = getDecodedFavoriteList().filter { $0 != id }
		let encodedModifiedFavoriteList = Utilities.encode(idList: modifiedFavoriteList)
		setFavoriteList(to: encodedModifiedFavoriteList)
	}
	
	func addToFavorite(_ id: String) {
		var modifiedFavoriteList = getDecodedFavoriteList()
		modifiedFavoriteList.append(id)
		let encodedModifiedFavoriteList = Utilities.encode(idList: modifiedFavoriteList)
		setFavoriteList(to: encodedModifiedFavoriteList)
	}
	
	func setFavoriteList(to encodedList: String) {
		UserDefaults.standard.set(encodedList, forKey: "favoriteList")
	}
	
	
	func getDecodedFavoriteList() -> [String] {
		guard let favoriteListStr = UserDefaults.standard.value(forKey: "favoriteList") as? String else {
			return [""]
		}
		let decodedFavoriteList = Utilities.decode(idListString: favoriteListStr)
		return decodedFavoriteList
	}
	
	func retrieveFavoriteList() {
		favoriteList = getDecodedFavoriteList()
	}
	
	func isFavorite(id: String) -> Bool {
		return favoriteList.contains(id)
	}
	
	func setButtonLabel(buttonTitle: String) {
		favButton.setTitle(buttonTitle, for: .normal)
	}
	
	func setupButtonBorder() {
		favButton.layer.cornerRadius = 8.0
		favButton.layer.borderWidth = 0.8
		favButton.layer.borderColor = (UIColor( red: 255, green: 255, blue:255, alpha: 255 )).cgColor
	}
	
	func getCoin() -> DetailsViewModel {
		let coins = coin
        let coinViewModel = DetailsViewModel(coin: coins)
		return coinViewModel
	}
	
	func setCoinLabels(for coinViewModel: DetailsViewModel) {
        
		siglaLabel.text = coinViewModel.identifier
		priceLabel.text = Utilities.formatCoin(coinAmount: coinViewModel.price)
		lastHour.text = Utilities.formatCoin(coinAmount: coinViewModel.lastHour)
		lastMonth.text = Utilities.formatCoin(coinAmount: coinViewModel.lastMonth)
		lastDay.text = Utilities.formatCoin(coinAmount: coinViewModel.lastDay)
	}
    
    func accessibilityDetails(){
        
        siglaLabel.isAccessibilityElement = true
        siglaLabel.accessibilityHint = "Sigla da moeda"
        
        priceLabel.isAccessibilityElement = true
        priceLabel.accessibilityHint = "Preço da moeda"
        
        lastHour.isAccessibilityElement = true
        lastHour.accessibilityHint = "Volume negociado na última hora"
        
        lastDay.isAccessibilityElement = true
        lastMonth.accessibilityHint = "Volume negociado no último dia"
  
        lastMonth.isAccessibilityElement = true
        lastMonth.accessibilityHint = "Volume negociado no último ano"
        
        favButton.isAccessibilityElement = true
        favButton.accessibilityHint = "Clique no botão para dicionar ou remover a moeda dos favoritos"
    }
	
	func setCoinIcon(for coinViewModel: DetailsViewModel) {
		
		let coinIconID = coinViewModel.icon
		let iconID = coinIconID.replacingOccurrences(of: "-", with: "")
		let urlStr = "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_128/\(iconID).png"
		if let url = URL(string: urlStr ) {
			iconImage.af.setImage(withURL: url)
		}
	}
	
	func setCoinStar(for coinID: String) {
		if isFavorite(id: coinID) {
			starImage.image = UIImage(named: "star")
		} else {
			starImage.image = UIImage()
		}
	}
		
	func setupCoinInfo() {
		
		let coinViewModel = getCoin()
		
		setCoinLabels(for: coinViewModel)
		setCoinIcon(for: coinViewModel)
		}
	
	func setupStaticUI() {
		
		setupButtonBorder()
		setupCoinInfo()
	}
	
	func setupDynamicUI() {
		let buttonTitle = isFavorite(id: self.id) ? "REMOVER" : "ADICIONAR"
		setButtonLabel(buttonTitle: buttonTitle)
		setCoinStar(for: self.id)
	}
	
	func setupUI() {
		
		setupStaticUI()
		setupDynamicUI()

	}
}
