//
//  EndPointType.swift
//  FakeSoreApiCalling
//
//  Created by Quick tech  on 08/10/24.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

protocol EndPointType {
    var path: String { get }
    var baseURl: String { get }
    var url: URL? { get }
    var methods: HTTPMethods { get }
    var body: Encodable? { get }
    var headers: [String: String]? { get }
}

enum EndPointsItem {
    case product
    case addProduct(product: AddProduct)
}

extension EndPointsItem: EndPointType {
    
    var path: String {
        switch self {
        case .product :
            return "products"
        case .addProduct:
            return "add"
        }
    }
    var baseURl: String {
        switch self {
        case .product:
            return "https://fakestoreapi.com/"
        case .addProduct:
            return "https://dummyjson.com/products/"
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseURl)\(path)")
    }
    
    var methods: HTTPMethods {
        switch self {
        case .product:
            return .get
        case .addProduct:
            return .post
        }
    }
    
    var body: (any Encodable)? {
        switch self {
        case .product:
            return nil
        case .addProduct(let product):
            return product
        }
    }
    
    var headers: [String : String]? {
        return APIManager.commonHeaders
    }
}
