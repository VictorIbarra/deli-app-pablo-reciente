//
//  DataRequest+Extension.swift
//  MoviesJP
//
//  Created by iJPe on 2/26/19.
//  Copyright © 2019 jp. All rights reserved.
//

import Foundation
import Alamofire

extension DataRequest {
    @discardableResult
    func responseAddressList(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<AddressListResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseSuccess(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<SuccessResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseDeliveryCost(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<DeliveryCostResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseSignUp(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<SignUpResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseConfirmPhone(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<ConfirmPhoneResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseLogin(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<LoginResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseUserInformation(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<UserInformationResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseCart(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<CartResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }

    @discardableResult
    func responseOrder(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<OrderResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseOrders(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<OrdersResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseStores(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<StoresResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseStoresAround(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<DeliveriesResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseStore(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<StoreResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
    
    @discardableResult
    func responsePaymentMethod(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<PaymentMethodResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseCards(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<CardsResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseAds(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<AdsResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseProducts(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<ProductsResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseItem(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<ItemResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseCreateOrder(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<CreateOrderResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

