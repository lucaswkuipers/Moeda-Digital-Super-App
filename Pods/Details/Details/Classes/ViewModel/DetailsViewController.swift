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
    
 
    
    //MARK: Vars
    
    var coinsResults = [Coin]()
    var favoriteList  = "AAA|BTC|HHH|KKK"
    var id: String
    
    //MARK: Init
    
    public init(id: String){
        self.id = id
        
        super.init(nibName:"DetailsViewController", bundle: Bundle(for: DetailsViewController.self))
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let coinsResult = API.requestCoinList(assetId: id)
        coinsResults = coinsResult
        setTela()
        setBorderButton()
        //print(coinsResult[0].assetID)
        
        setTitleButton(list: favoriteList, id: id)
        
        
        print(formatNumberToDecimal(value: 8989009090.090))
 
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (tap))
            tapGesture.numberOfTapsRequired = 1
            favButton.addGestureRecognizer(tapGesture)
    }
    
    func setTela(){
        
        let coin = coinsResults[0]
        let model = DetailsViewModel.init(coin: coin)
        
        let urlModel = model.icon
        let newUrl = urlModel.replacingOccurrences(of: "-", with: "")
        guard let url = URL(string: "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_32/\(newUrl).png") else { return }
        iconImage.af_setImage(withURL: url)
       
        let modelPrice = String(formatNumberToDecimal(value: model.price))
        let modelHour = String(formatNumberToDecimal(value: model.lastHour))
        let modelMonth = String(formatNumberToDecimal(value: model.lastMonth))
        let modelday = String(formatNumberToDecimal(value: model.lastDay))
     
        
        siglaLabel.text = model.identifier
        //iconImage.image = imageData
        priceLabel.text = modelPrice
        lastHour.text = modelHour
        lastDay.text = modelday
        lastMonth.text = modelMonth
        
        
        print(coinsResults[0])
    }
}
//MARK: Extension - Button
extension DetailsViewController {
    
    func setBorderButton(){
        favButton.layer.cornerRadius = 8.0
        favButton.layer.borderWidth = 0.8
        favButton.layer.borderColor = (UIColor( red: 255, green: 255, blue:255, alpha: 255 )).cgColor
    }
    func setTitleButton(list: String, id: String) {

        if list.contains(id){
            favButton.setTitle("REMOVER", for: .normal)
         } else {
            favButton.setTitle("ADICIONAR", for: .normal)
        }
    }
    
    
    @objc func tap() {
           botaoFavorito(favButton, list: favoriteList)
       }
    
 @IBAction func botaoFavorito(_ sender: UIButton, list: String) {
//
        let sigla = "BTC"

    var favorite = Utilities.decode(idListString: list)
        if favorite.contains(id){
            favButton.setTitle("REMOVER", for: .normal)
            favorite = Array(Set(favorite).subtracting([id]))
            print("remover")
            print(favorite)

         } else {
            favButton.setTitle("ADICIONA", for: .normal)
            print("adicionar")
        }
    let newList = Utilities.encode(idList: favorite)
        favoriteList = newList
        print(favorite)
    
    }
    
    
}

//MARK: Extension - Formatter

extension DetailsViewController {
    
    func formatNumberToDecimal(value:Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.minimumFractionDigits = 2
        formatter.numberStyle = .decimal

        return formatter.string(from: NSNumber(value:value)) ?? " "
    }
}
