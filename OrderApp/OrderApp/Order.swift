//
//  Order.swift
//  OrderApp
//
//  Created by Дмитрий Имаев on 13.05.2023.
//

import Foundation


struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []){
        self.menuItems = menuItems
    }
}
