//
//  UserTradeModel.swift
//  Blossom
//

import Foundation
import SwiftUI


// model to get the trade details of the user(s)
struct Trade: Identifiable{
    var id: String
    var uid: String
    var plant_name: String
    var plant_age: String
    var plant_size:String
    var user_location: String
    var plant_grown: String
    var username: String
    var plant_img: String
    var mode_of_contact: String
}

