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
        self.eventHandlet?(.loading)
        APIManager.shared.request(
            modelType: [Product].self,
            type: EndPointsItem.product) { response in
                self.eventHandlet?(.stoploading)
                switch response {
                case .success(let product):
                    self.products = product
                    self.eventHandlet?(.dataloaded)
                case .failure(let error):
                    self.eventHandlet?(.error(error))
                }
            }
    }
    
    func addProduct(parameters: AddProduct) {
        APIManager.shared.request(
            modelType: AddProduct.self,
            type: EndPointsItem.addProduct(product: parameters)) { response in
                switch response {
                case .success(let product):
                    self.eventHandlet?(.newProduct(product: product))
                case .failure(let error):
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
