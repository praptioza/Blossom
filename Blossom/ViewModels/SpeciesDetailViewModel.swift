//
//  SpeciesDetailViewModel.swift
//  Blossom


import Foundation
import SwiftUI

class SpeciesDetailViewModel : ObservableObject{
    @Published var species = Details(id: 0, commonName: "", scientificName: "", imageURL: "", family: "", edible : false, ediblePart: [], images: Images(leaf: [], flower: [], fruit : [], bark : []), flower: Flower(color: []), specifications: Specifications(growthForm: "", growthRate: ""), growth : Growth(light: 0, atmosphericHumidity: 0, soilNutriments: 0, minimumTemperature: Temperature.init(degF: "") , maximumTemperature: Temperature.init(degF: "")))
    
    
    var urlString = ""
    func fetchSpeciesDetails(){
        if urlString == ""{
            return
        }
        else{
            guard let url = URL(string: "https://trefle.io\(urlString)?token=Bla-U6N_LqFNDXa-BSZDj4h2RFKpVEq7Yl_d3F8PVGE")else{
                return
            }
            
            print("URL to fetch data from: \(url)")
            //to get species details using request and using JSONDecoder to decode the data
            URLSession.shared.dataTask(with: url) {data, response, error in
                guard let data = data else{
                    return
                }
                //getting the data into an array
                do{
                    let details = try JSONDecoder().decode(SpeciesDetails.self, from:data)
                    DispatchQueue.main.async{
                        self.species = details.data
                    }
                }
                catch let error{
                    print("Error decoding details: \(error)")
                }
            }.resume()
        }
    }
    
    func getFirstTwoImages() -> [URL] {
        var images: [URL] = []
        
        if let firstLeafImage = species.images?.leaf?.first?.imageURL,
           let firstLeafImageURL = URL(string: firstLeafImage) {
            images.append(firstLeafImageURL)
        }
        
        if let secondLeafImage = species.images?.leaf?.dropFirst().first?.imageURL,
           let secondLeafImageURL = URL(string: secondLeafImage) {
            images.append(secondLeafImageURL)
        }
        
        
        if let firstFlowerImage = species.images?.flower?.first?.imageURL,
           let firstFlowerImageURL = URL(string: firstFlowerImage) {
            images.append(firstFlowerImageURL)
        }
        
        if let secondFlowerImage = species.images?.flower?.dropFirst().first?.imageURL,
           let secondFlowerImageURL = URL(string: secondFlowerImage) {
            images.append(secondFlowerImageURL)
        }
        
        if let firstFruitImage = species.images?.fruit?.first?.imageURL,
           let firstFruitImageURL = URL(string: firstFruitImage) {
            images.append(firstFruitImageURL)
        }
        
        if let secondFruitImage = species.images?.fruit?.dropFirst().first?.imageURL,
           let secondFruitImageURL = URL(string: secondFruitImage) {
            images.append(secondFruitImageURL)
        }
        
        if let firstBarkImage = species.images?.bark?.first?.imageURL,
           let firstBarkImageURL = URL(string: firstBarkImage) {
            images.append(firstBarkImageURL)
        }
        
        if let secondBarkImage = species.images?.bark?.dropFirst().first?.imageURL,
           let secondBarkImageURL = URL(string: secondBarkImage) {
            images.append(secondBarkImageURL)
        }
        
        
        return images
    }
    
}

