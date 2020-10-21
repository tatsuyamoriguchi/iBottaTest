//
//  OfferData.swift
//  iBottaTest
//
//  Created by Tatsuya Moriguchi on 10/20/20.
//  Copyright © 2020 Tatsuya Moriguchi. All rights reserved.
//

import Foundation

/*
 // JSON data sample
 {
 "id":"110579",
 "url":"https://product-images.ibotta.com/offer/dUxYcQPeq391-DiywFZF8g-normal.png",
 "name":"Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges",
 "description":"Any variety - 2 ct. pack or larger",
 "terms":"Rebate valid on Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges for any variety, 2 ct. pack or larger.",
 "current_value":"$0.75 Cash Back"}
 */

// Map json data
struct ItemOffer: Codable {
    var id: String?
    var url: String?
    var name: String?
    var description: String?
    var terms: String?
    var current_value: String?
}
