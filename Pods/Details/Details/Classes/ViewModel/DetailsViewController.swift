//
//  DetailsViewController.swift
//  Details
//
//  Created by Tabata Sabrina Sutili on 15/04/21.
//
import UIKit
import LucasCoinAPI


public class DetailsViewController: UIViewController {

    //MARK: IBOutlet
    
    @IBOutlet weak var siglaLabel: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var lastHour: UILabel!
    @IBOutlet weak var lastMonth: UILabel!
    @IBOutlet weak var lastYear: UILabel!
    
    
    //MARK: Vars
    
    var coinsResults = [Coin]()
    let list = "AAA|BTC|HHH|KKK"
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
        
        print(formatNumberToDecimal(value: 8989009090.090))
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (tap))
            tapGesture.numberOfTapsRequired = 1
            favButton.addGestureRecognizer(tapGesture)
    }
    
    func setTela(){
        
        let coin = coinsResults[0]
        let model = DetailsViewModel.init(coin: coin)
       
        let modelPrice = String(formatNumberToDecimal(value: model.price))
     
        
        siglaLabel.text = model.identifier
        //iconImage.image = model.icon
        priceLabel.text = modelPrice
        lastHour.text = model.lastHour
        lastMonth.text = model.lastMonth
        lastYear.text = model.lastYear
        
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
    
    
    @objc func tap() {
        botaoFavorito(favButton, list: list)
        viewDidLoad()
    }
    
    @IBAction func botaoFavorito(_ sender: UIButton, list: String) {
            
        let sigla: Substring = "AAA"
        
        var favorite = list.split(separator: "|")
        if favorite.contains(sigla){
            favButton.setTitle("REMOVER", for: .normal)
            favorite = Array(Set(favorite).subtracting([sigla]))
            print("remover")
         } else {
            favButton.setTitle("Adicionar", for: .normal)
            print("adicionar")
        }
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
