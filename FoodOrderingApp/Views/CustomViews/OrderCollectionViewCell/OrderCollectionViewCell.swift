//
//  OrderCollectionViewCell.swift
//  FoodOrderingApp
//
//  Created by Huseyn Valiyev on 22.08.2021.
//

import UIKit

class OrderCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OrderCollectionViewCell.self)
    
    @IBOutlet weak var orderMealImage: UIImageView!
    @IBOutlet weak var orderMealNameLabel: UILabel!
    @IBOutlet weak var orderMealQuantityLabel: UILabel!
    
    func setup(order: Order) {
        orderMealImage.kf.setImage(with: URL(string: order.meal.image ?? ""))
        orderMealNameLabel.text = order.meal.name
        orderMealQuantityLabel.text = "Quantity: \(order.quantity)"
    }
    
}
