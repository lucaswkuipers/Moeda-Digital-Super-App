//
//  DetailsViewController.swift
//  Details
//
//  Created by Tabata Sabrina Sutili on 15/04/21.
//
import UIKit

public class DetailsViewController: UIViewController {

    @IBOutlet weak var siglaLabel: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var lastHour: UILabel!
    @IBOutlet weak var lastMonth: UILabel!
    @IBOutlet weak var lastYear: UILabel!
    
    private var sigla: String
    private var icon: String
    private var star: String
    private var price: String
    private var favorite: String
    private var volumeHour: String
    private var volumeMoth: String
    private var volumeYear: String
    
    public init(sigla: String, price: String){
        self.sigla = sigla
        self.price = price
        
        super.init(nibName:"DetailsViewController", bundle: Bundle(for: DetailsViewController.self))
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setBorderButton()
    }
    
    func setBorderButton(){
        favButton.layer.cornerRadius = 8.0
        favButton.layer.borderWidth = 0.8
        favButton.layer.borderColor = (UIColor( red: 255, green: 255, blue:255, alpha: 255 )).cgColor
    }
    


}
