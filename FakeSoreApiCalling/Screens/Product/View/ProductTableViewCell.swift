//
//  ProductTableViewCell.swift
//  FakeSoreApiCalling
//
//  Created by Quick tech  on 12/09/24.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var rateBtn: UIButton!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productCategoryLbl: UILabel!
    @IBOutlet weak var productDescriptionLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    
    var product: Product? {
        didSet {
            productDetailConfiguaration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func productDetailConfiguaration() {
        guard let product else { return }
        productTitle.text = product.title
        productDescriptionLbl.text = product.description
        productCategoryLbl.text = product.category
        productPriceLbl.text = "$\(product.rating.count)"
        rateBtn.setTitle("\(product.rating.rate)", for: .normal)
    }
}
