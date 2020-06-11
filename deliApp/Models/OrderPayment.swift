//
//  OrderPayment.swift
//  deliApp
//
//  Created by iJPe on 7/30/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation

// MARK: - OrderPayment
class OrderPayment: NSObject, Codable {
    var id, adminCurrencyCode: String?
    var adminProfitModeOnDelivery, adminProfitModeOnStore, adminProfitValueOnDelivery, adminProfitValueOnStore: Int?
    var cardPayment: Double?
    var cartID: String?
    var cashPayment: Double?
    var cityID, countryID, createdAt, currencyCode: String?
    var currentRate: Double?
    var deliveredAt: String?
    var deliveryPrice: Double?
    var invoiceNumber: String?
    var isCancellationFee, isDistanceUnitMile, isOrderPaymentRefund, isOrderPaymentStatusSetByStore: Bool?
    var isOrderPricePaidByStore, isPaidFromWallet, isPaymentModeCash, isPaymentPaid: Bool?
    var isPendingPayment, isPromoForDeliveryService, isProviderIncomeSetInWallet, isStoreIncomeSetInWallet: Bool?
    var isStorePayDeliveryFees, isTransfered, isUserPickUpOrder: Bool?
    var itemTax: Double?
    var model: String?
    var orderCancellationCharge: Int?
    var orderCurrencyCode, orderID: String?
    var orderPrice, orderToAdminCurrentRate, orderUniqueID: Int?
    var payToProvider: Double?
    var payToStore: Double?
    var paymentID: String?
    var promoID: String?
    var promoPayment: Double?
    var providerHaveCashPayment: Int?
    var providerID: String?
    var providerIncomeSetInWallet, providerPaidOrderPayment: Int?
    var refundAmount: Double?
    var remainingPayment: Double?
    var serviceTax, storeHaveOrderPayment: Double?
    var storeHaveServicePayment: Int?
    var storeId: String?
    var storeIncomeSetInWallet: Int?
    var total, totalAdminProfitOnDelivery: Double?
    var totalAdminProfitOnStore: Double?
    var totalAdminTaxPrice, totalAfterWalletPayment, totalCartPrice: Double?
    var totalDeliveryPrice, totalDistance: Double?
    var totalItemCount, totalOrderPrice, totalProviderHavePayment: Double?
    var totalProviderIncome, totalServicePrice: Double?
    var totalStoreIncome: Double?
    var totalStoreHavePayment, totalStoreTaxPrice, totalTime: Double?
    var uniqueId: Int?
    var updatedAt, userID: String?
    var walletPayment: Double?
    var walletToAdminCurrentRate, walletToOrderCurrentRate: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case adminCurrencyCode = "admin_currency_code"
        case adminProfitModeOnDelivery = "admin_profit_mode_on_delivery"
        case adminProfitModeOnStore = "admin_profit_mode_on_store"
        case adminProfitValueOnDelivery = "admin_profit_value_on_delivery"
        case adminProfitValueOnStore = "admin_profit_value_on_store"
        case cardPayment = "card_payment"
        case cartID = "cart_id"
        case cashPayment = "cash_payment"
        case cityID = "city_id"
        case countryID = "country_id"
        case createdAt = "created_at"
        case currencyCode = "currency_code"
        case currentRate = "current_rate"
        case deliveredAt = "delivered_at"
        case deliveryPrice = "delivery_price"
        case invoiceNumber = "invoice_number"
        case isCancellationFee = "is_cancellation_fee"
        case isDistanceUnitMile = "is_distance_unit_mile"
        case isOrderPaymentRefund = "is_order_payment_refund"
        case isOrderPaymentStatusSetByStore = "is_order_payment_status_set_by_store"
        case isOrderPricePaidByStore = "is_order_price_paid_by_store"
        case isPaidFromWallet = "is_paid_from_wallet"
        case isPaymentModeCash = "is_payment_mode_cash"
        case isPaymentPaid = "is_payment_paid"
        case isPendingPayment = "is_pending_payment"
        case isPromoForDeliveryService = "is_promo_for_delivery_service"
        case isProviderIncomeSetInWallet = "is_provider_income_set_in_wallet"
        case isStoreIncomeSetInWallet = "is_store_income_set_in_wallet"
        case isStorePayDeliveryFees = "is_store_pay_delivery_fees"
        case isTransfered = "is_transfered"
        case isUserPickUpOrder = "is_user_pick_up_order"
        case itemTax = "item_tax"
        case model
        case orderCancellationCharge = "order_cancellation_charge"
        case orderCurrencyCode = "order_currency_code"
        case orderID = "order_id"
        case orderPrice = "order_price"
        case orderToAdminCurrentRate = "order_to_admin_current_rate"
        case orderUniqueID = "order_unique_id"
        case payToProvider = "pay_to_provider"
        case payToStore = "pay_to_store"
        case paymentID = "payment_id"
        case promoID = "promo_id"
        case promoPayment = "promo_payment"
        case providerHaveCashPayment = "provider_have_cash_payment"
        case providerID = "provider_id"
        case providerIncomeSetInWallet = "provider_income_set_in_wallet"
        case providerPaidOrderPayment = "provider_paid_order_payment"
        case refundAmount = "refund_amount"
        case remainingPayment = "remaining_payment"
        case serviceTax = "service_tax"
        case storeHaveOrderPayment = "store_have_order_payment"
        case storeHaveServicePayment = "store_have_service_payment"
        case storeId = "store_id"
        case storeIncomeSetInWallet = "store_income_set_in_wallet"
        case total
        case totalAdminProfitOnDelivery = "total_admin_profit_on_delivery"
        case totalAdminProfitOnStore = "total_admin_profit_on_store"
        case totalAdminTaxPrice = "total_admin_tax_price"
        case totalAfterWalletPayment = "total_after_wallet_payment"
        case totalCartPrice = "total_cart_price"
        case totalDeliveryPrice = "total_delivery_price"
        case totalDistance = "total_distance"
        case totalItemCount = "total_item_count"
        case totalOrderPrice = "total_order_price"
        case totalProviderHavePayment = "total_provider_have_payment"
        case totalProviderIncome = "total_provider_income"
        case totalServicePrice = "total_service_price"
        case totalStoreHavePayment = "total_store_have_payment"
        case totalStoreIncome = "total_store_income"
        case totalStoreTaxPrice = "total_store_tax_price"
        case totalTime = "total_time"
        case uniqueId = "unique_id"
        case updatedAt = "updated_at"
        case userID = "user_id"
        case walletPayment = "wallet_payment"
        case walletToAdminCurrentRate = "wallet_to_admin_current_rate"
        case walletToOrderCurrentRate = "wallet_to_order_current_rate"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let id = try container.decodeIfPresent(String.self, forKey: .id) {
            self.id = id
        }
        if let adminCurrencyCode = try container.decodeIfPresent(String.self, forKey: .adminCurrencyCode) {
            self.adminCurrencyCode = adminCurrencyCode
        }
        if let adminProfitModeOnDelivery = try container.decodeIfPresent(Int.self, forKey: .adminProfitModeOnDelivery) {
            self.adminProfitModeOnDelivery = adminProfitModeOnDelivery
        }
        if let adminProfitModeOnStore = try container.decodeIfPresent(Int.self, forKey: .adminProfitModeOnStore) {
            self.adminProfitModeOnStore = adminProfitModeOnStore
        }
        if let adminProfitValueOnDelivery = try container.decodeIfPresent(Int.self, forKey: .adminProfitValueOnDelivery) {
            self.adminProfitValueOnDelivery = adminProfitValueOnDelivery
        }
        if let adminProfitValueOnStore = try container.decodeIfPresent(Int.self, forKey: .adminProfitValueOnStore) {
            self.adminProfitValueOnStore = adminProfitValueOnStore
        }
        if let cardPayment = try container.decodeIfPresent(Double.self, forKey: .cardPayment) {
            self.cardPayment = cardPayment
        }
        if let cartID = try container.decodeIfPresent(String.self, forKey: .cartID) {
            self.cartID = cartID
        }
        if let cashPayment = try container.decodeIfPresent(Double.self, forKey: .cashPayment) {
            self.cashPayment = cashPayment
        }
        if let cityID = try container.decodeIfPresent(String.self, forKey: .cityID) {
            self.cityID = cityID
        }
        if let countryID = try container.decodeIfPresent(String.self, forKey: .countryID) {
            self.countryID = countryID
        }
        if let createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) {
            self.createdAt = createdAt
        }
        if let currencyCode = try container.decodeIfPresent(String.self, forKey: .currencyCode) {
            self.currencyCode = currencyCode
        }
        if let currentRate = try container.decodeIfPresent(Double.self, forKey: .currentRate) {
            self.currentRate = currentRate
        }
        if let deliveredAt = try container.decodeIfPresent(String.self, forKey: .deliveredAt) {
            self.deliveredAt = deliveredAt
        }
        if let deliveryPrice = try container.decodeIfPresent(Double.self, forKey: .deliveryPrice) {
            self.deliveryPrice = deliveryPrice
        }
        if let invoiceNumber = try container.decodeIfPresent(String.self, forKey: .invoiceNumber) {
            self.invoiceNumber = invoiceNumber
        }
        if let isCancellationFee = try container.decodeIfPresent(Bool.self, forKey: .isCancellationFee) {
            self.isCancellationFee = isCancellationFee
        }
        if let isDistanceUnitMile = try container.decodeIfPresent(Bool.self, forKey: .isDistanceUnitMile) {
            self.isDistanceUnitMile = isDistanceUnitMile
        }
        if let isOrderPaymentRefund = try container.decodeIfPresent(Bool.self, forKey: .isOrderPaymentRefund) {
            self.isOrderPaymentRefund = isOrderPaymentRefund
        }
        if let isOrderPaymentStatusSetByStore = try container.decodeIfPresent(Bool.self, forKey: .isOrderPaymentStatusSetByStore) {
            self.isOrderPaymentStatusSetByStore = isOrderPaymentStatusSetByStore
        }
        if let isOrderPricePaidByStore = try container.decodeIfPresent(Bool.self, forKey: .isOrderPricePaidByStore) {
            self.isOrderPricePaidByStore = isOrderPricePaidByStore
        }
        if let isPaidFromWallet = try container.decodeIfPresent(Bool.self, forKey: .isPaidFromWallet) {
            self.isPaidFromWallet = isPaidFromWallet
        }
        if let isPaymentModeCash = try container.decodeIfPresent(Bool.self, forKey: .isPaymentModeCash) {
            self.isPaymentModeCash = isPaymentModeCash
        }
        if let isPaymentPaid = try container.decodeIfPresent(Bool.self, forKey: .isPaymentPaid) {
            self.isPaymentPaid = isPaymentPaid
        }
        if let isPendingPayment = try container.decodeIfPresent(Bool.self, forKey: .isPendingPayment) {
            self.isPendingPayment = isPendingPayment
        }
        if let isPromoForDeliveryService = try container.decodeIfPresent(Bool.self, forKey: .isPromoForDeliveryService) {
            self.isPromoForDeliveryService = isPromoForDeliveryService
        }
        if let isProviderIncomeSetInWallet = try container.decodeIfPresent(Bool.self, forKey: .isProviderIncomeSetInWallet) {
            self.isProviderIncomeSetInWallet = isProviderIncomeSetInWallet
        }
        if let isStoreIncomeSetInWallet = try container.decodeIfPresent(Bool.self, forKey: .isStoreIncomeSetInWallet) {
            self.isStoreIncomeSetInWallet = isStoreIncomeSetInWallet
        }
        if let isStorePayDeliveryFees = try container.decodeIfPresent(Bool.self, forKey: .isStorePayDeliveryFees) {
            self.isStorePayDeliveryFees = isStorePayDeliveryFees
        }
        if let isTransfered = try container.decodeIfPresent(Bool.self, forKey: .isTransfered) {
            self.isTransfered = isTransfered
        }
        if let isUserPickUpOrder = try container.decodeIfPresent(Bool.self, forKey: .isUserPickUpOrder) {
            self.isUserPickUpOrder = isUserPickUpOrder
        }
        if let itemTax = try container.decodeIfPresent(Double.self, forKey: .itemTax) {
            self.itemTax = itemTax
        }
        if let model = try container.decodeIfPresent(String.self, forKey: .model) {
            self.model = model
        }
        if let orderCancellationCharge = try container.decodeIfPresent(Int.self, forKey: .orderCancellationCharge) {
            self.orderCancellationCharge = orderCancellationCharge
        }
        if let orderCurrencyCode = try container.decodeIfPresent(String.self, forKey: .orderCurrencyCode) {
            self.orderCurrencyCode = orderCurrencyCode
        }
        if let orderID = try container.decodeIfPresent(String.self, forKey: .orderID) {
            self.orderID = orderID
        }
        if let orderPrice = try container.decodeIfPresent(Int.self, forKey: .orderPrice) {
            self.orderPrice = orderPrice
        }
        if let orderToAdminCurrentRate = try container.decodeIfPresent(Int.self, forKey: .orderToAdminCurrentRate) {
            self.orderToAdminCurrentRate = orderToAdminCurrentRate
        }
        if let orderUniqueID = try container.decodeIfPresent(Int.self, forKey: .orderUniqueID) {
            self.orderUniqueID = orderUniqueID
        }
        if let payToProvider = try container.decodeIfPresent(Double.self, forKey: .payToProvider) {
            self.payToProvider = payToProvider
        }
        if let payToStore = try container.decodeIfPresent(Double.self, forKey: .payToStore) {
            self.payToStore = payToStore
        }
        if let paymentID = try container.decodeIfPresent(String.self, forKey: .paymentID) {
            self.paymentID = paymentID
        }
        if let promoID = try container.decodeIfPresent(String.self, forKey: .promoID) {
            self.promoID = promoID
        }
        if let promoPayment = try container.decodeIfPresent(Double.self, forKey: .promoPayment) {
            self.promoPayment = promoPayment
        }
        if let providerHaveCashPayment = try container.decodeIfPresent(Int.self, forKey: .providerHaveCashPayment) {
            self.providerHaveCashPayment = providerHaveCashPayment
        }
        if let providerID = try container.decodeIfPresent(String.self, forKey: .providerID) {
            self.providerID = providerID
        }
        if let providerIncomeSetInWallet = try container.decodeIfPresent(Int.self, forKey: .providerIncomeSetInWallet) {
            self.providerIncomeSetInWallet = providerIncomeSetInWallet
        }
        if let providerPaidOrderPayment = try container.decodeIfPresent(Int.self, forKey: .providerPaidOrderPayment) {
            self.providerPaidOrderPayment = providerPaidOrderPayment
        }
        if let refundAmount = try container.decodeIfPresent(Double.self, forKey: .refundAmount) {
            self.refundAmount = refundAmount
        }
        if let remainingPayment = try container.decodeIfPresent(Double.self, forKey: .remainingPayment) {
            self.remainingPayment = remainingPayment
        }
        if let serviceTax = try container.decodeIfPresent(Double.self, forKey: .serviceTax) {
            self.serviceTax = serviceTax
        }
        if let storeHaveOrderPayment = try container.decodeIfPresent(Double.self, forKey: .storeHaveOrderPayment) {
            self.storeHaveOrderPayment = storeHaveOrderPayment
        }
        if let storeHaveServicePayment = try container.decodeIfPresent(Int.self, forKey: .storeHaveServicePayment) {
            self.storeHaveServicePayment = storeHaveServicePayment
        }
        if let storeId = try container.decodeIfPresent(String.self, forKey: .storeId) {
            self.storeId = storeId
        }
        if let storeIncomeSetInWallet = try container.decodeIfPresent(Int.self, forKey: .storeIncomeSetInWallet) {
            self.storeIncomeSetInWallet = storeIncomeSetInWallet
        }
        if let total = try container.decodeIfPresent(Double.self, forKey: .total) {
            self.total = total
        }
        if let totalAdminProfitOnDelivery = try container.decodeIfPresent(Double.self, forKey: .totalAdminProfitOnDelivery) {
            self.totalAdminProfitOnDelivery = totalAdminProfitOnDelivery
        }
        if let totalAdminProfitOnStore = try container.decodeIfPresent(Double.self, forKey: .totalAdminProfitOnStore) {
            self.totalAdminProfitOnStore = totalAdminProfitOnStore
        }
        if let totalAdminTaxPrice = try container.decodeIfPresent(Double.self, forKey: .totalAdminTaxPrice) {
            self.totalAdminTaxPrice = totalAdminTaxPrice
        }
        if let totalAfterWalletPayment = try container.decodeIfPresent(Double.self, forKey: .totalAfterWalletPayment) {
            self.totalAfterWalletPayment = totalAfterWalletPayment
        }
        if let totalCartPrice = try container.decodeIfPresent(Double.self, forKey: .totalCartPrice) {
            self.totalCartPrice = totalCartPrice
        }
        if let totalDeliveryPrice = try container.decodeIfPresent(Double.self, forKey: .totalDeliveryPrice) {
            self.totalDeliveryPrice = totalDeliveryPrice
        }
        if let totalDistance = try container.decodeIfPresent(Double.self, forKey: .totalDistance) {
            self.totalDistance = totalDistance
        }
        if let totalItemCount = try container.decodeIfPresent(Double.self, forKey: .totalItemCount) {
            self.totalItemCount = totalItemCount
        }
        if let totalOrderPrice = try container.decodeIfPresent(Double.self, forKey: .totalOrderPrice) {
            self.totalOrderPrice = totalOrderPrice
        }
        if let totalProviderHavePayment = try container.decodeIfPresent(Double.self, forKey: .totalProviderHavePayment) {
            self.totalProviderHavePayment = totalProviderHavePayment
        }
        if let totalProviderIncome = try container.decodeIfPresent(Double.self, forKey: .totalProviderIncome) {
            self.totalProviderIncome = totalProviderIncome
        }
        if let totalServicePrice = try container.decodeIfPresent(Double.self, forKey: .totalServicePrice) {
            self.totalServicePrice = totalServicePrice
        }
        if let totalStoreHavePayment = try container.decodeIfPresent(Double.self, forKey: .totalStoreHavePayment) {
            self.totalStoreHavePayment = totalStoreHavePayment
        }
        if let totalStoreIncome = try container.decodeIfPresent(Double.self, forKey: .totalStoreIncome) {
            self.totalStoreIncome = totalStoreIncome
        }
        if let totalStoreTaxPrice = try container.decodeIfPresent(Double.self, forKey: .totalStoreTaxPrice) {
            self.totalStoreTaxPrice = totalStoreTaxPrice
        }
        if let totalTime = try container.decodeIfPresent(Double.self, forKey: .totalTime) {
            self.totalTime = totalTime
        }
        if let uniqueId = try container.decodeIfPresent(Int.self, forKey: .uniqueId) {
            self.uniqueId = uniqueId
        }
        if let updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt) {
            self.updatedAt = updatedAt
        }
        if let userID = try container.decodeIfPresent(String.self, forKey: .userID) {
            self.userID = userID
        }
        if let walletPayment = try container.decodeIfPresent(Double.self, forKey: .walletPayment) {
            self.walletPayment = walletPayment
        }
        if let walletToAdminCurrentRate = try container.decodeIfPresent(Int.self, forKey: .walletToAdminCurrentRate) {
            self.walletToAdminCurrentRate = walletToAdminCurrentRate
        }
        if let walletToOrderCurrentRate = try container.decodeIfPresent(Int.self, forKey: .walletToOrderCurrentRate) {
            self.walletToOrderCurrentRate = walletToOrderCurrentRate
        }
    }
    
    init(id: String?, adminCurrencyCode: String?, adminProfitModeOnDelivery: Int?, adminProfitModeOnStore: Int?, adminProfitValueOnDelivery: Int?, adminProfitValueOnStore: Int?, cardPayment: Double?, cartID: String?, cashPayment: Double?, cityID: String?, countryID: String?, createdAt: String?, currencyCode: String?, currentRate: Double?, deliveredAt: String?, deliveryPrice: Double?, invoiceNumber: String?, isCancellationFee: Bool?, isDistanceUnitMile: Bool?, isOrderPaymentRefund: Bool?, isOrderPaymentStatusSetByStore: Bool?, isOrderPricePaidByStore: Bool?, isPaidFromWallet: Bool?, isPaymentModeCash: Bool?, isPaymentPaid: Bool?, isPendingPayment: Bool?, isPromoForDeliveryService: Bool?, isProviderIncomeSetInWallet: Bool?, isStoreIncomeSetInWallet: Bool?, isStorePayDeliveryFees: Bool?, isTransfered: Bool?, isUserPickUpOrder: Bool?, itemTax: Double?, model: String?, orderCancellationCharge: Int?, orderCurrencyCode: String?, orderID: String?, orderPrice: Int?, orderToAdminCurrentRate: Int?, orderUniqueID: Int?, payToProvider: Double?, payToStore: Double?, paymentID: String?, promoID: String?, promoPayment: Double?, providerHaveCashPayment: Int?, providerID: String?, providerIncomeSetInWallet: Int?, providerPaidOrderPayment: Int?, refundAmount: Double?, remainingPayment: Double?, serviceTax: Double?, storeHaveOrderPayment: Double?, storeHaveServicePayment: Int?, storeId: String?, storeIncomeSetInWallet: Int?, total: Double?, totalAdminProfitOnDelivery: Double?, totalAdminProfitOnStore: Double?, totalAdminTaxPrice: Double?, totalAfterWalletPayment: Double?, totalCartPrice: Double?, totalDeliveryPrice: Double?, totalDistance: Double?, totalItemCount: Double?, totalOrderPrice: Double?, totalProviderHavePayment: Double?, totalProviderIncome: Double?, totalServicePrice: Double?, totalStoreHavePayment: Double?, totalStoreIncome: Double?, totalStoreTaxPrice: Double?, totalTime: Double?, uniqueId: Int?, updatedAt: String?, userID: String?, walletPayment: Double?, walletToAdminCurrentRate: Int?, walletToOrderCurrentRate: Int?) {
        self.id = id
        self.adminCurrencyCode = adminCurrencyCode
        self.adminProfitModeOnDelivery = adminProfitModeOnDelivery
        self.adminProfitModeOnStore = adminProfitModeOnStore
        self.adminProfitValueOnDelivery = adminProfitValueOnDelivery
        self.adminProfitValueOnStore = adminProfitValueOnStore
        self.cardPayment = cardPayment
        self.cartID = cartID
        self.cashPayment = cashPayment
        self.cityID = cityID
        self.countryID = countryID
        self.createdAt = createdAt
        self.currencyCode = currencyCode
        self.currentRate = currentRate
        self.deliveredAt = deliveredAt
        self.deliveryPrice = deliveryPrice
        self.invoiceNumber = invoiceNumber
        self.isCancellationFee = isCancellationFee
        self.isDistanceUnitMile = isDistanceUnitMile
        self.isOrderPaymentRefund = isOrderPaymentRefund
        self.isOrderPaymentStatusSetByStore = isOrderPaymentStatusSetByStore
        self.isOrderPricePaidByStore = isOrderPricePaidByStore
        self.isPaidFromWallet = isPaidFromWallet
        self.isPaymentModeCash = isPaymentModeCash
        self.isPaymentPaid = isPaymentPaid
        self.isPendingPayment = isPendingPayment
        self.isPromoForDeliveryService = isPromoForDeliveryService
        self.isProviderIncomeSetInWallet = isProviderIncomeSetInWallet
        self.isStoreIncomeSetInWallet = isStoreIncomeSetInWallet
        self.isStorePayDeliveryFees = isStorePayDeliveryFees
        self.isTransfered = isTransfered
        self.isUserPickUpOrder = isUserPickUpOrder
        self.itemTax = itemTax
        self.model = model
        self.orderCancellationCharge = orderCancellationCharge
        self.orderCurrencyCode = orderCurrencyCode
        self.orderID = orderID
        self.orderPrice = orderPrice
        self.orderToAdminCurrentRate = orderToAdminCurrentRate
        self.orderUniqueID = orderUniqueID
        self.payToProvider = payToProvider
        self.payToStore = payToStore
        self.paymentID = paymentID
        self.promoID = promoID
        self.promoPayment = promoPayment
        self.providerHaveCashPayment = providerHaveCashPayment
        self.providerID = providerID
        self.providerIncomeSetInWallet = providerIncomeSetInWallet
        self.providerPaidOrderPayment = providerPaidOrderPayment
        self.refundAmount = refundAmount
        self.remainingPayment = remainingPayment
        self.serviceTax = serviceTax
        self.storeHaveOrderPayment = storeHaveOrderPayment
        self.storeHaveServicePayment = storeHaveServicePayment
        self.storeId = storeId
        self.storeIncomeSetInWallet = storeIncomeSetInWallet
        self.total = total
        self.totalAdminProfitOnDelivery = totalAdminProfitOnDelivery
        self.totalAdminProfitOnStore = totalAdminProfitOnStore
        self.totalAdminTaxPrice = totalAdminTaxPrice
        self.totalAfterWalletPayment = totalAfterWalletPayment
        self.totalCartPrice = totalCartPrice
        self.totalDeliveryPrice = totalDeliveryPrice
        self.totalDistance = totalDistance
        self.totalItemCount = totalItemCount
        self.totalOrderPrice = totalOrderPrice
        self.totalProviderHavePayment = totalProviderHavePayment
        self.totalProviderIncome = totalProviderIncome
        self.totalServicePrice = totalServicePrice
        self.totalStoreHavePayment = totalStoreHavePayment
        self.totalStoreIncome = totalStoreIncome
        self.totalStoreTaxPrice = totalStoreTaxPrice
        self.totalTime = totalTime
        self.uniqueId = uniqueId
        self.updatedAt = updatedAt
        self.userID = userID
        self.walletPayment = walletPayment
        self.walletToAdminCurrentRate = walletToAdminCurrentRate
        self.walletToOrderCurrentRate = walletToOrderCurrentRate
    }
}
