//
//  HearderView.swift
//  Commons
//
//  Created by Tabata Sabrina Sutili on 14/04/21.
//
import Foundation
import UIKit



public class HearderView: UIView {
    
    @IBOutlet weak var titleHeader: UILabel!
    @IBOutlet weak var dataHeader: UILabel!
    
    var view: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        //xibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension HearderView {
    
    public static var bundleUI: Bundle {
        var bundle: Bundle
        if let b = Bundle(identifier: "org.cocoapods.Commons") {
            bundle = b
        } else {
            bundle = Bundle(for: self)
        }
        return bundle
    }
    
    public class func fromNib() -> Self {
        return fromNib(viewType: self)
    }
    
    public class func fromNib<T: UIView>(viewType: T.Type) -> T {
        if let nib = bundleUI.loadNibNamed(
            String(describing: viewType), owner: nil, options: nil)?.first as? T {
            return nib
        }
        return T()
    }
}

extension HearderView {
    public func setupLabels(title: String, data: String) {
        self.titleHeader.text = title
        self.dataHeader.text = data
        
    }
}
