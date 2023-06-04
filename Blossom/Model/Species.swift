//
//  Species.swift
//  Blossom
//

import Foundation

struct SpeciesList: Codable {
    let data : [Species]
}

struct Species : Codable, Identifiable {
    let id: Int
    let commonName : String?
    let sciName : String?
    let image : String
    let family : String?
    let detailLink : Links
    
    enum CodingKeys : String, CodingKey{
        case id = "id"
        case commonName = "common_name"
        case sciName = "scientific_name"
        case image = "image_url"
        case detailLink = "links"
        case family
    }
}

struct Links : Codable {
    let selfLink: String
    
    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
    }
}

struct SpeciesDetails: Codable {
    let data: Details
}

struct Details : Codable {
    let id: Int
    let commonName, scientificName: String
    let imageURL: String
    let family: String
    let edible: Bool?
    let ediblePart : [String]?
    let images: Images?
    let flower: Flower?
    let specifications: Specifications?
    let growth: Growth
    
    enum CodingKeys: String, CodingKey {
        case id
        case commonName = "common_name"
        case scientificName = "scientific_name"
        case imageURL = "image_url"
        case family
        case edible
        case ediblePart = "edible_part"
        case images
        case flower
        case specifications
        case growth
    }
}


struct Images : Codable {
    let leaf, flower, fruit, bark : [FlowerElement]?
}


struct FlowerElement : Codable {
    let imageURL: String
    
    enum CodingKeys : String, CodingKey{
        case imageURL = "image_url"
    }
}

struct Flower: Codable {
    let color : [String]?
}

struct Growth: Codable {
    let light : Int?
    let atmosphericHumidity: Int?
    let soilNutriments : Int?
    let minimumTemperature, maximumTemperature: Temperature
    
    enum CodingKeys: String, CodingKey {
        case light
        case atmosphericHumidity = "atmospheric_humidity"
        case soilNutriments = "soil_nutriments"
        case minimumTemperature = "minimum_temperature"
        case maximumTemperature = "maximum_temperature"
    }
}

struct Temperature: Codable {
    let degF : String?
    
    enum CodingKeys: String, CodingKey {
        case degF = "deg_f"
    }
}


struct Specifications : Codable{
    let growthForm : String?
    let growthRate : String?
    
    enum CodingKeys : String, CodingKey{
        case growthForm = "growth_form"
        case growthRate = "growth_rate"
    }
}



