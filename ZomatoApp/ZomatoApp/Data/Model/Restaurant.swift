//
//  Restaurant.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 10/3/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

struct Restaurant: Codable {
    let result: Result?
    let apikey: String?
    let id: String?
    let name: String?
    let url: String?
    let location: Location?
    let switchToOrderMenu: Int?
    let cuisines: String?
    let averageCostForTwo: Int?
    let priceRange: Int?
    let currency: String?
    let offers: [String]?
    let opentableSupport: Int?
    let isZomatoBookRes: Int?
    let mezzoProvider: String?
    let isBookFormWebView: Int?
    let bookFormWebViewUrl: String?
    let bookAgainUrl: String?
    let thumb: String?
    let userRating: UserRating?
    let photosUrl: String?
    let menuUrl: String?
    let featuredImage: String?
    let hasOnlineDelivery: Int?
    let isDeliveringNow: Int?
    let includeBogoOffers: Bool?
    let deeplink: String?
    let isTableReservationSupported: Int?
    let hasTableBooking: Int?
    let eventsUrl: String?

    enum CodingKeys: String, CodingKey {
        case result = "R"
        case apikey = "apikey"
        case id = "id"
        case name = "name"
        case url = "url"
        case location = "location"
        case switchToOrderMenu = "switch_to_order_menu"
        case cuisines = "cuisines"
        case averageCostForTwo = "average_cost_for_two"
        case priceRange = "price_range"
        case currency = "currency"
        case offers = "offers"
        case opentableSupport = "opentable_support"
        case isZomatoBookRes = "is_zomato_book_res"
        case mezzoProvider = "mezzo_provider"
        case isBookFormWebView = "is_book_form_web_view"
        case bookFormWebViewUrl = "book_form_web_view_url"
        case bookAgainUrl = "book_again_url"
        case thumb = "thumb"
        case userRating = "user_rating"
        case photosUrl = "photos_url"
        case menuUrl = "menu_url"
        case featuredImage = "featured_image"
        case hasOnlineDelivery = "has_online_delivery"
        case isDeliveringNow = "is_delivering_now"
        case includeBogoOffers = "include_bogo_offers"
        case deeplink = "deeplink"
        case isTableReservationSupported = "is_table_reservation_supported"
        case hasTableBooking = "has_table_booking"
        case eventsUrl = "events_url"
    }
}
