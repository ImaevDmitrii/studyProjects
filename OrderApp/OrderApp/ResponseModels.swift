//
//  ResponseModels.swift
//  OrderApp
//
//  Created by Дмитрий Имаев on 13.05.2023.
//

import Foundation

struct MenuResponse: Codable {
    let items: [MenuItem]
}


struct CategoryResponse: Codable {
    let categories: [String]
}


struct OrderResponse: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "prepararion_time"
    }
}
