//
//  PlantListRowView.swift
//  Blossom


import SwiftUI

struct PlantListRowView: View {

    let plants : Species
    
    var body: some View {
        
        
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottom){
                if let imagepath = plants.image{
                    AsyncImage (url: URL(string: imagepath)){
                        image in
                        image
                            .resizable()
                            .frame(width:160)
                            .cornerRadius(20)
                            .scaledToFit()
                    } placeholder: {
                        Color.gray
                            .frame(width:160,height:220)
                    }
                    
                    VStack(alignment: .leading){
                        if let commonName = plants.commonName {
                            Text(commonName)
                                .font(.custom("Lato-Bold", size: 18))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                        }
                        
                    }
                    .padding(20)
                    .frame(width : 160, alignment: .leading)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                }
                else{
                    Color.gray
                        .frame(width:160, height:220)
                        .cornerRadius(20)
                }
                
            }//end of first zstack
            .frame(width:160, height:220)
            .shadow(radius: 3)
        }
        
    }
    
    
}




