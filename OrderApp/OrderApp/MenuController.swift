//
//  MenuController.swift
//  OrderApp
//
//  Created by Дмитрий Имаев on 13.05.2023.
//

import Foundation

class MenuController {
    
    static let shared = MenuController()
    static let orderUpdateNotification = Notification.Name("MenuController.orderUpdated")
    
    
    let baseURL = URL(string: "http://localhost:8080/")!
    
    var order = Order() {
        didSet {
            NotificationCenter.default.post(name: MenuController.orderUpdateNotification, object: nil)
        }
    }
    
    enum MenuControllerError: Error, LocalizedError {
        case categoriesNotFound
        case menuItemsNotFound
        case orderRequestFailed
    }
    
    
    func fetchCategories() async throws -> [String] {
        let categoryURL = baseURL.appendingPathComponent("categories")
        let (data, response) = try await URLSession.shared.data(from: categoryURL)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw MenuControllerError.categoriesNotFound}
        
        let decoder = JSONDecoder()
        let categoriesResponse = try decoder.decode(CategoryResponse.self, from: data)
        
        return categoriesResponse.categories
    }
    
    func fetchMenutems(forCategory categoryName: String) async throws -> [MenuItem] {
        let baseMenuUrl = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: baseMenuUrl, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        let (data,response) = try await URLSession.shared.data(from: menuURL)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw MenuControllerError.menuItemsNotFound
        }
        
        let decoder = JSONDecoder()
        let menuResponse = try decoder.decode(MenuResponse.self, from: data)
        
        return menuResponse.items
    }
    
    typealias MinutesToPrepare = Int
    
    func sumbitOrder(forMenuIDs menuIDs: [Int]) async throws -> MinutesToPrepare {
        let orderURL = baseURL.appendingPathComponent("order")
        
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let menuIdsDict = [ "menuIds": menuIDs]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(menuIdsDict)
        request.httpBody = jsonData
        
        let (data,response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw MenuControllerError.orderRequestFailed
        }
        
        let decoder = JSONDecoder()
        let orderResponse = try decoder.decode(OrderResponse.self, from: data)
        
        return orderResponse.prepTime
    }
    
}

