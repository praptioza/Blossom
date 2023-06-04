//
//  SearchPlantsView.swift
//  Blossom


import SwiftUI

struct SearchPlantsView: View {
    @State private var selectedPlantName: String = ""
    @ObservedObject var vm = SpeciesViewModel()
    @State private var searchText = ""
    
    var columns = [GridItem(.adaptive(minimum: 160),spacing:20)]
    
    init(){
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(Color.pinkColor.opacity(0.5))
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        ZStack{
            Color.red
                .opacity(0.2)
                .ignoresSafeArea()
            NavigationView{
                ScrollView (.vertical, showsIndicators: false){
                    LazyVGrid(columns:columns, spacing:20){
                        ForEach(vm.speciesList.filter({ plant in
                            if searchText.isEmpty {
                                return true
                            } else {
                                return (plant.commonName?.lowercased().contains(searchText.lowercased()) ?? false)
                            }
                        }), id :\.id){ plant in
                            NavigationLink(destination: PlantInfoView(selectedPlantName: plant.commonName ?? "About Plant", species : plant)){
                                PlantListRowView(plants: plant)
                            }
                            
                        }
                    }
                    .padding()
                    .onAppear{
                        vm.fetchSpeciesFromAPI()
                    }
                    .navigationTitle("SEARCH PLANT")
                    .navigationBarTitleDisplayMode(.inline)
                    .searchable(
                        text: $searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Search Plants"
                    )
                }.padding(.top, 20)
                
            }//end of navigation view
            
        }//end of zstack
    }
}

struct SearchPlantsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlantsView()
    }
}

struct SearchBar : View{
    @Binding var text: String
    var body : some View{
        HStack{
            TextField("Search Plants", text : $text)
                .padding(.leading, 24)
        }
        .padding()
        .background(Color.pinkColor).opacity(0.5)
        .cornerRadius(10)
        .padding(.horizontal)
        .overlay(
            HStack{
                Image(systemName: "magnifyingglass")
                Spacer()
            }.padding(.horizontal,20)
                .foregroundColor(.gray)
        )
        
    }
}
