//
//  OrderViewController.swift
//  FoodOrderingApp
//
//  Created by Huseyn Valiyev on 21.08.2021.
//

import UIKit
import ProgressHUD

class OrderViewController: UIViewController {
    
    var orders: [Order] = [
        .init(id: "1", meal: .init(id: "52843", name: "Lamb Tagine", image: "https://www.themealdb.com/images/media/meals/yuwtuu1511295751.jpg", country: "Moroccan", category: "Lamb", instruction: ""), quantity: 2),
        .init(id: "2", meal: .init(id: "52769", name: "Kapsalon", image: "https://www.themealdb.com/images/media/meals/sxysrt1468240488.jpg", country: "Dutch", category: "Lamb", instruction: ""), quantity: 3),
        .init(id: "3", meal: .init(id: "52968", name: "Mbuzi Choma (Roasted Goat)", image: "https://www.themealdb.com/images/media/meals/cuio7s1555492979.jpg", country: "Kenyan", category: "Goat", instruction: ""), quantity: 1),
        .init(id: "4", meal: .init(id: "52827", name: "Massaman Beef curry", image: "https://www.themealdb.com/images/media/meals/tvttqv1504640475.jpg", country: "Thai", category: "Beef", instruction: ""), quantity: 2)
    ]
    
    @IBOutlet weak var orderCollectionView: UICollectionView!
    @IBOutlet weak var checkOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkOutButton.layer.cornerRadius = 8
        registerCell()
    }
    
    private func registerCell() {
        orderCollectionView.register(UINib(nibName: OrderCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: OrderCollectionViewCell.identifier)
    }
    
    @IBAction func checkOutButtonTapped(_ sender: Any) {
        ProgressHUD.showSuccess("Your order has ben recived 👨🏻‍🍳")
    }
    
    
}

extension OrderViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = orderCollectionView.dequeueReusableCell(withReuseIdentifier: OrderCollectionViewCell.identifier, for: indexPath) as! OrderCollectionViewCell
        cell.setup(order: orders[indexPath.item])
        return cell
    }
}
