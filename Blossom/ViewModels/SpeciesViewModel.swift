//
//  SpeciesViewModel.swift
//  Blossom
//


import Foundation
import SwiftUI

class SpeciesViewModel: ObservableObject {
    @Published var speciesList: [Species] = []
    
    init(){
        fetchSpecies()
    }
    
    func fetchSpecies() {
        if let data = fetchSpeciesFromLocalFile() {
            speciesList = data
        } else {
            fetchSpeciesFromAPI()
        }
    }
    
    func fetchSpeciesFromLocalFile() -> [Species]? {
        let fileName = "speciesList.json"
        //using FileManager class to retrieve the URL of docs directory where file will be stored.
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        //this points to the file created above
        let fileUrl = documentDirectoryUrl.appendingPathComponent(fileName)
        
        if !FileManager.default.fileExists(atPath: fileUrl.path) {
            // create an empty file if it does not exist
            FileManager.default.createFile(atPath: fileUrl.path, contents: nil, attributes: nil)
        }
        
        //loading the file data into memory and decode JSON data
        do {
            let data = try Data(contentsOf: fileUrl)
            let decoder = JSONDecoder()
            let speciesList = try decoder.decode([Species].self, from: data)
            // print("Data from file: \(speciesList)")
            return speciesList
        } catch {
            print("error loading from file: \(error)")
            return nil
        }
    }
    
    //function fetches data from Trefle API
    func fetchSpeciesFromAPI() {
        let baseApiUrl = "https://trefle.io/api/v1/species?token=Bla-U6N_LqFNDXa-BSZDj4h2RFKpVEq7Yl_d3F8PVGE&page="
        let numberOfPages = 20
        var fetchedData: [Species] = []
        
        //used to sunchronize the completion of multiple async tasks
        let dispatchGroup = DispatchGroup()
        
        //iterating over different pages of the API
        for page in 1...numberOfPages {
            //starting a new task
            dispatchGroup.enter()
            guard let url = URL(string: baseApiUrl + "\(page)&filter_not[common_name]=null" ) else { continue }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    dispatchGroup.leave()
                    return
                }
                
                
                if let response = response as? HTTPURLResponse{
                    print("Response status code: \(response.statusCode)")
                }
                
                
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    let speciesList = try decoder.decode(SpeciesList.self, from: data)
                    fetchedData += speciesList.data
                } catch {
                    print(error)
                }
                //current task completed
                dispatchGroup.leave()
            }.resume()
        }
        
        //executing a completion handler when all the tasks are complete
        //this updates the speciesList property of the current object with fetchedData array and saves it to local file and passing this to main queue
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.speciesList = fetchedData
            self.saveToLocalFile(data: fetchedData)
        }
    }
    
    func saveToLocalFile(data: [Species]) {
        let fileName = "speciesList.json"
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent(fileName)
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(data)
            try jsonData.write(to: fileUrl)
        } catch {
            print("error saving to file: \(error)")
        }
    }
    
}

