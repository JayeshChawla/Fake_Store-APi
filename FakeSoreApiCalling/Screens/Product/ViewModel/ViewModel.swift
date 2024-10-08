//
//  ViewModel.swift
//  FakeSoreApiCalling
//
//  Created by Quick tech  on 12/09/24.
//

import Foundation

final class productViewModel {
    
    var products: [Product] = []
    var eventHandlet: ((_ event: Event) -> Void)?
    
    
    func fetchProducts() {
        Task {
            self.eventHandlet?(.loading)
            do {
                let products = try await APIManager.shared.request(modelType: [Product].self, type: EndPointsItem.product)
                self.products = products
                self.eventHandlet?(.stoploading)
                self.eventHandlet?(.dataloaded)
            } catch {
                self.eventHandlet?(.error(error))
            }
        }
    }
    
    func addProduct(parameters: AddProduct) {
        Task {
            do {
                let newProduct = try await APIManager.shared.request(modelType: AddProduct.self, type: EndPointsItem.addProduct(product: parameters))
                self.eventHandlet?(.newProduct(product: newProduct))
            } catch {
                self.eventHandlet?(.error(error))
            }
        }
    }
}

extension productViewModel {
    enum Event {
        case loading
        case stoploading
        case dataloaded
        case error(Error?)
        case newProduct(product: AddProduct)
    }
}
