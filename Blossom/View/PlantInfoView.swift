//
//  PlantInfoView.swift
//  Blossom

import SwiftUI

struct PlantInfoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    var selectedPlantName : String
    var species : Species
    @StateObject private var detailvm = SpeciesDetailViewModel()
    
    var body: some View {
        ZStack{
            ScrollView(.vertical, showsIndicators: false){
                //vstack containing everything on the screen
                if let details = detailvm.species{
                    ImageCollectionView(imageURLs: detailvm.getFirstTwoImages())
                    VStack{
                        Text("Plant Name: \(details.commonName)")
                            .font(.custom("Lato-Medium", size: 20))
                            .multilineTextAlignment(.center)
                            .padding(.top,30)
                        
                        Text("Scientific Name: \(details.scientificName)")
                            .font(.custom("Lato-Regular", size : 18)).foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.top,14)
                        
                        Text("Family Name: \(details.family)")
                            .font(.custom("Lato-Regular", size : 18)).foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.top,14)
                        
                        Button(action: {
                            addToMyPlants(plant_name: detailvm.species.commonName, plant_img: detailvm.species.imageURL)
                            
                        }) {
                            HStack {
                                Text("Add to my Plants")
                                    .font(.custom("Lato-Bold",size : 20))
                                Image(systemName: "plus.circle")
                                    .font(.headline)
                            }
                            .padding()
                            .background(Color.greenColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame(width : 294.22, height:45)
                        }.padding(.top,14)
                        
                        
                        HStack{
                            Text("General Information:")
                                .font(.custom("Lato-Regular", size : 18))
                                .multilineTextAlignment(.leading)
                                .padding(.top, 30)
                                .padding(.leading, 30)
                            Spacer()
                        }
                        //card for info
                        ZStack{
                            VStack(alignment: .leading){
                                if let growthrate = details.specifications?.growthRate{
                                    Text("\(details.commonName) is a type of plant that grows in a \(growthrate) rate.").font(.custom("Lato-Regular", size: 16))
                                        .foregroundColor(.gray)
                                        .padding(.leading,13)
                                        .padding(.trailing,13)
                                        .font(.body)
                                        .multilineTextAlignment(.leading)
                                }
                                if let growthform = details.specifications?.growthForm{
                                    Text("It grows in a \(growthform).").font(.custom("Lato-Regular", size: 16))
                                        .foregroundColor(.gray)
                                        .padding(.leading,13)
                                        .padding(.trailing,13)
                                        .font(.body)
                                        .multilineTextAlignment(.leading)
                                }
                                if let isEdible = details.edible{
                                    if isEdible == true{
                                        if let edibleParts = details.ediblePart{
                                            Text("\(details.commonName) is a type of plant that can be consumed, with their \(edibleParts.joined(separator: ", ")) being edible.").font(.custom("Lato-Regular", size: 16))
                                                .foregroundColor(.gray)
                                                .padding(.leading,13)
                                                .padding(.trailing,13)
                                                .font(.body)
                                                .multilineTextAlignment(.leading)
                                        }
                                    } else{
                                        Text("\(details.commonName) is not a type of plant that is edible.").font(.custom("Lato-Regular", size: 16))
                                            .foregroundColor(.gray)
                                            .padding(.leading,13)
                                            .padding(.trailing,13)
                                            .font(.body)
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                                
                                if let flowercolors = details.flower?.color{
                                    Text("Flowers of \(details.commonName) are \(flowercolors.joined(separator: ", ")) in color.").font(.custom("Lato-Regular", size: 16))
                                        .foregroundColor(.gray)
                                        .padding(.leading,13)
                                        .padding(.trailing,13)
                                        .font(.body)
                                        .multilineTextAlignment(.leading)
                                }
                                
                            }//end of vstack
                        }
                        .padding(10)
                        //end of info card
                        
                        
                        HStack{
                            Text("Requirements: ")
                                .font(.custom("Lato-Light", size : 18)).font(.headline)
                                .multilineTextAlignment(.leading)
                                .padding(.leading,30)
                                .padding(.top,15)
                            Spacer()
                        }
                        
                        //vstack for 4 cards
                        //hstack for temp and humidity
                        HStack{
                            ZStack{
                                Color.greenColor.opacity(0.2)
                                VStack(alignment: .leading){
                                    HStack{
                                        Text("Temperature").font(.custom("Lato-Bold", size: 18))
                                            .foregroundColor(Color.greenColor)
                                            .padding(.leading,20)
                                        Image("ic-temperature")
                                        Spacer()
                                    }
                                    if let mintemps = details.growth.minimumTemperature.degF{
                                        if let maxtemps = details.growth.maximumTemperature.degF{
                                            Text("\(mintemps) - \(maxtemps)")
                                                .font(.custom("Lato-Regular", size: 16))
                                                .foregroundColor(.gray)
                                                .padding(.leading,20)
                                        }
                                    }
                                    else{
                                        Text("20 - 30 F")
                                            .font(.custom("Lato-Regular", size: 16))
                                            .foregroundColor(.gray)
                                            .padding(.leading,20)
                                    }
                                }
                            }.frame(width:170, height:87)
                                .cornerRadius(20)
                                .padding(.trailing,10)
                                .padding(.top,10)
                            //end of temp card
                            ZStack{
                                Color.greenColor.opacity(0.2)
                                VStack(alignment: .leading){
                                    HStack{
                                        Text("Humidity").font(.custom("Lato-Bold", size: 18))
                                            .foregroundColor(Color.greenColor)
                                            .padding(.leading,20)
                                        Image("ic-humidity")
                                        Spacer()
                                    }
                                    if let humidity = details.growth.atmosphericHumidity{
                                        if (humidity >= 0 && humidity <= 3){
                                            Text("Low").font(.custom("Lato-Regular", size: 16))
                                                .foregroundColor(.gray)
                                                .padding(.leading,20)
                                        }
                                        else if(humidity >= 4 && humidity <= 6){
                                            Text("Medium").font(.custom("Lato-Regular", size: 16))
                                                .foregroundColor(.gray)
                                                .padding(.leading,20)
                                        }
                                        else if(humidity >= 7 && humidity <= 10){
                                            Text("High").font(.custom("Lato-Regular", size: 16))
                                                .foregroundColor(.gray)
                                                .padding(.leading,20)
                                        }
                                    }
                                    else{
                                        Text("Medium").font(.custom("Lato-Regular", size: 16))
                                            .foregroundColor(.gray)
                                            .padding(.leading,20)
                                    }
                                }
                            }.frame(width:170, height:87)
                                .cornerRadius(20)
                                .padding(.trailing,10) //end of humidity card
                        } //end of hstack for temp and humidity
                        .padding(.bottom,10)
                        
                        
                        //hstack for light and soil
                        HStack{
                            ZStack{
                                Color.greenColor.opacity(0.2)
                                VStack(alignment: .leading){
                                    HStack{
                                        Text("Light").font(.custom("Lato-Bold", size: 18))
                                            .foregroundColor(Color.greenColor)
                                            .padding(.leading,20)
                                        Image("ic-light")
                                        Spacer()
                                    }
                                    if let sunlight = details.growth.light{
                                        if(sunlight == 0){
                                            Text("No light").font(.custom("Lato-Regular", size: 16))
                                                .foregroundColor(.gray)
                                                .padding(.leading,20)
                                        }
                                        else if (sunlight >= 1 && sunlight <= 2){
                                            Text("Very Low").font(.custom("Lato-Regular", size: 16))
                                                .foregroundColor(.gray)
                                                .padding(.leading,20)
                                        }
                                        else if(sunlight >= 3 && sunlight <= 5){
                                            Text("Low").font(.custom("Lato-Regular", size: 16))
                                                .foregroundColor(.gray)
                                                .padding(.leading,20)
                                        }
                                        else if(sunlight >= 6 && sunlight <= 8){
                                            Text("Medium").font(.custom("Lato-Regular", size: 16))
                                                .foregroundColor(.gray)
                                                .padding(.leading,20)
                                        }
                                        else if(sunlight >= 9 && sunlight <= 10){
                                            Text("High").font(.custom("Lato-Regular", size: 16))
                                                .foregroundColor(.gray)
                                                .padding(.leading,20)
                                        }
                                    }
                                    else{
                                        Text("Medium").font(.custom("Lato-Regular", size: 16))
                                            .foregroundColor(.gray)
                                            .padding(.leading,20)
                                    }
                                    
                                }
                            }.frame(width:170, height:87)
                                .cornerRadius(20)
                                .padding(.trailing,10)
                            //end of light card
                            
                            ZStack{
                                Color.greenColor.opacity(0.2)
                                VStack(alignment: .leading){
                                    HStack{
                                        Text("Soil Fertility").font(.custom("Lato-Bold", size: 18))
                                            .foregroundColor(Color.greenColor)
                                            .padding(.leading,20)
                                        Image("ic-soil")
                                        Spacer()
                                    }
                                    if let soilfertility = details.growth.soilNutriments{
                                        if (soilfertility >= 0 && soilfertility <= 3){
                                            Text("Less Fertile").font(.custom("Lato-Regular", size: 16))
                                                .foregroundColor(.gray)
                                                .padding(.leading,20)
                                        }
                                        else if(soilfertility >= 4 && soilfertility <= 7){
                                            Text("Moderately Fertile").font(.custom("Lato-Regular", size: 16))
                                                .foregroundColor(.gray)
                                                .padding(.leading,20)
                                        }
                                        else if(soilfertility >= 7 && soilfertility <= 10){
                                            Text("Highly Fertile").font(.custom("Lato-Regular", size: 16))
                                                .foregroundColor(.gray)
                                                .padding(.leading,20)
                                        }
                                    }
                                    else{
                                        Text("Moderately Fertile").font(.custom("Lato-Regular", size: 16))
                                            .foregroundColor(.gray)
                                            .padding(.leading,20)
                                    }
                                }
                            }.frame(width:170, height:87)
                                .cornerRadius(20)
                                .padding(.trailing,10)
                            //end of soil card
                        }//end of hstack for temp and humidity
                        
                        //vstack containing care part
                        VStack{
                            HStack{
                                Text("Care: ")
                                    .font(.custom("Lato-Light", size : 18)).font(.headline)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading,30)
                                    .padding(.top,15)
                                Spacer()
                            }
                            
                            //card for watering
                            ZStack{
                                Color.greenColor.opacity(0.2)
                                VStack(alignment: .leading){
                                    Text("Watering: ").font(.custom("Lato-Bold", size: 18))
                                        .foregroundColor(Color.greenColor)
                                        .padding(.top,8)
                                        .padding(.leading, 13)
                                    Text("Water is necessary for plants to live, but the quantity and frequency differs depending on the growing environment, and the climate. When a plant needs watering, it can be determined by checking the moisture in the soil and looking for symptoms like withering or poor development. Overwatering a plant can be harmful, so finding the right balance is important. ").font(.custom("Lato-Regular", size: 16))
                                        .foregroundColor(.gray)
                                        .padding(.top,2)
                                        .padding(.bottom,8)
                                        .padding(.leading,13)
                                        .padding(.trailing,13)
                                        .font(.body)
                                        .multilineTextAlignment(.leading)
                                }
                            }.frame(width:367, height:200)
                                .cornerRadius(20)
                                .padding(10)
                            //end of watering card
                            
                            //card for fertilizer
                            ZStack{
                                Color.greenColor.opacity(0.2)
                                VStack(alignment: .leading){
                                    Text("Fertilizer: ").font(.custom("Lato-Bold", size: 18))
                                        .foregroundColor(Color.greenColor)
                                        .padding(.top,8)
                                        .padding(.leading, 13)
                                    if let soilfertility = details.growth.soilNutriments{
                                        if (soilfertility >= 0 && soilfertility <= 3){
                                            Text("Fertilizer should be added in very less quantity every 4 to 6 weeks.\nNote: Applying too much fertilizer can be harmful, so it is crucial to follow specific fertilizer's instructions. Monitor plants for signs of nutrient deficiencies or diseases and adjusting fertilization accordingly is also recommended.").font(.custom("Lato-Regular", size: 16))
                                                .foregroundColor(.gray)
                                                .padding(.top,2)
                                                .padding(.bottom,8)
                                                .padding(.leading,13)
                                                .padding(.trailing,13)
                                                .font(.body)
                                                .multilineTextAlignment(.leading)
                                        }
                                        else if(soilfertility >= 4 && soilfertility <= 7){
                                            Text("Fertilizer should be added every 4 to 6 months.\nNote: Applying too much fertilizer can be harmful, so it is crucial to follow specific fertilizer's instructions. Monitor plants for signs of nutrient deficiencies or diseases and adjusting fertilization accordingly is also recommended.").font(.custom("Lato-Regular", size: 16))
                                                .foregroundColor(.gray)
                                                .padding(.top,2)
                                                .padding(.bottom,8)
                                                .padding(.leading,13)
                                                .padding(.trailing,13)
                                                .font(.body)
                                                .multilineTextAlignment(.leading)
                                        }
                                        else if(soilfertility >= 7 && soilfertility <= 10){
                                            Text("Fertilizer should be added every 10 to 12 months.\nNote: Applying too much fertilizer can be harmful, so it is crucial to follow specific fertilizer's instructions. Monitor plants for signs of nutrient deficiencies or diseases and adjusting fertilization accordingly is also recommended.").font(.custom("Lato-Regular", size: 16))
                                                .foregroundColor(.gray)
                                                .padding(.top,2)
                                                .padding(.bottom,8)
                                                .padding(.leading,13)
                                                .padding(.trailing,13)
                                                .font(.body)
                                                .multilineTextAlignment(.leading)
                                        }
                                    }
                                    else{
                                        Text("Fertilizer should be added every 4 to 6 months.\nNote: Applying too much fertilizer can be harmful, so it is crucial to follow specific fertilizer's instructions. Monitor plants for signs of nutrient deficiencies or diseases and adjusting fertilization accordingly is also recommended.").font(.custom("Lato-Regular", size: 16))
                                            .foregroundColor(.gray)
                                            .padding(.top,2)
                                            .padding(.bottom,8)
                                            .padding(.leading,13)
                                            .padding(.trailing,13)
                                            .font(.body)
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                            }.frame(width:367, height:200)
                                .cornerRadius(20)
                                .padding(10)
                            //end of fertilizer card
                            
                            //sunlight card
                            ZStack{
                                Color.greenColor.opacity(0.2)
                                VStack(alignment: .leading){
                                    Text("Sunlight: ").font(.custom("Lato-Bold", size: 18))
                                        .foregroundColor(Color.greenColor)
                                        .padding(.top,8)
                                        .padding(.leading, 13)
                                    if let sunlight = details.growth.light{
                                        if (sunlight == 0){
                                            Text("No Sunlight or Artificial light is required for the healthy growth and development of this plant.Too little or too much light than required amount can have negative impact on the plant's growth. So, it is important to ensure that plants receive right amount of light for their specific needs.").font(.custom("Lato-Regular", size: 16))
                                                .foregroundColor(.gray)
                                                .padding(.top,2)
                                                .padding(.bottom,8)
                                                .padding(.leading,13)
                                                .padding(.trailing,13)
                                                .font(.body)
                                                .multilineTextAlignment(.leading)
                                        }
                                        else if (sunlight >= 1 && sunlight <= 2){
                                            Text("Very low amount of Sunlight or Artificial light is required for the healthy growth and development of this plant. Too little or too much light than required amount can have negative impact on the plant's growth. So, it is important to ensure that plants receive right amount of light for their specific needs.").font(.custom("Lato-Regular", size: 16))
                                                .foregroundColor(.gray)
                                                .padding(.top,2)
                                                .padding(.bottom,8)
                                                .padding(.leading,13)
                                                .padding(.trailing,13)
                                                .font(.body)
                                                .multilineTextAlignment(.leading)
                                        }
                                        else if(sunlight >= 3 && sunlight <= 5){
                                            Text("Low amount of Sunlight or Artificial light is required for the healthy growth and development of this plant. Too little or too much light than required amount can have negative impact on the plant's growth. So, it is important to ensure that plants receive right amount of light for their specific needs.").font(.custom("Lato-Regular", size: 16))
                                                .foregroundColor(.gray)
                                                .padding(.top,2)
                                                .padding(.bottom,8)
                                                .padding(.leading,13)
                                                .padding(.trailing,13)
                                                .font(.body)
                                                .multilineTextAlignment(.leading)
                                        }
                                        else if(sunlight >= 6 && sunlight <= 8){
                                            Text("Medium amount of Sunlight or Artificial light is required for the healthy growth and development of this plant. Too little or too much light than required amount can have negative impact on the plant's growth. So, it is important to ensure that plants receive right amount of light for their specific needs.").font(.custom("Lato-Regular", size: 16))
                                                .foregroundColor(.gray)
                                                .padding(.top,2)
                                                .padding(.bottom,8)
                                                .padding(.leading,13)
                                                .padding(.trailing,13)
                                                .font(.body)
                                                .multilineTextAlignment(.leading)
                                        }
                                        else if(sunlight >= 9 && sunlight <= 10){
                                            Text("High amount of Sunlight or Artificial light is required for the healthy growth and development of this plant. Too little or too much light than required amount can have negative impact on the plant's growth. So, it is important to ensure that plants receive right amount of light for their specific needs.").font(.custom("Lato-Regular", size: 16))
                                                .foregroundColor(.gray)
                                                .padding(.top,2)
                                                .padding(.bottom,8)
                                                .padding(.leading,13)
                                                .padding(.trailing,13)
                                                .font(.body)
                                                .multilineTextAlignment(.leading)
                                        }
                                    }
                                    else{
                                        Text("Medium amount of Sunlight or Artificial light is required for the healthy growth and development of this plant. Too little or too much light than required amount can have negative impact on the plant's growth. So, it is important to ensure that plants receive right amount of light for their specific needs.").font(.custom("Lato-Regular", size: 16))
                                            .foregroundColor(.gray)
                                            .padding(.top,2)
                                            .padding(.bottom,8)
                                            .padding(.leading,13)
                                            .padding(.trailing,13)
                                            .font(.body)
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                            }.frame(width:367, height:200)
                                .cornerRadius(20)
                                .padding(10)
                            
                        } //end of vstack containg care
                        
                    }//end of main VStack containing everything on  screen
                    .frame(width:400)
                }//end of if
            }//end of scrollview
            
        }//end of zstack
        
        .navigationTitle(selectedPlantName.uppercased())
        .font(.custom("Lato-Bold", size: 20))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image("ic-backarrow")
                .foregroundColor(.black)
                .imageScale(.large)
        }))
        .onAppear{
            detailvm.urlString = species.detailLink.selfLink
            detailvm.fetchSpeciesDetails()
        }
    }
    
    private func addToMyPlants(plant_name: String, plant_img: String){
        // getting the user id
        guard let uid = UserManager.shared.auth.currentUser?.uid
        else{
            print("User not found/ Error getting the user ID")
            return
        }
        
        
        // Create the alert controller
        let alert = UIAlertController(title: "Add to My Plants", message: "Are you sure you want to add this plant to your favorites?", preferredStyle: .alert)
        
        // Add the actions
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            // User clicked OK, so add the plant to MyFavorites
            UserManager.shared.firestore.collection("MyFavorites").addDocument(data:["plant_name": detailvm.species.commonName.self, "uid": uid, "plant_img": detailvm.species.imageURL.self])
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // Present the alert
        if let window = UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene }).first?.windows.first {
            window.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
}


//carousel image view
struct ImageCollectionView: View {
    var imageURLs: [URL]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(imageURLs, id: \.self) { url in
                    AsyncImages(url: url)
                        .frame(width: 250, height: 300)
                        .cornerRadius(10)
                        .aspectRatio(contentMode: .fill)
                        .padding(.top,30)
                }
            }
        }
    }
}

struct AsyncImages: View {
    @StateObject private var imageLoader = ImageLoader()
    var url: URL
    
    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                ProgressView()
            }
        }
        .onAppear {
            imageLoader.loadImage(from: url)
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
