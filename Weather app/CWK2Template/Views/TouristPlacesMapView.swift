

import Foundation
import SwiftUI
import CoreLocation
import MapKit

struct TouristPlacesMapView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    @State var locations: [Location] = []
    @State var  mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5216871, longitude: -0.1391574), latitudinalMeters: 8000, longitudinalMeters: 8000)
    @State private var selectedLocation: Location?
    var body: some View {
        NavigationView {
            VStack(spacing: 5) {
                if weatherMapViewModel.coordinates != nil {
                    VStack(spacing: 10){
                        Map(coordinateRegion: $mapRegion, annotationItems: locations){location in
                            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.coordinates.latitude, longitude: location.coordinates.longitude)){
                                Text(location.name)
                                    .font(.caption2)
                                    .bold()
                                Image(systemName: "mappin.and.ellipse")
                                    .foregroundColor(.red)
                                    .shadow(radius: 1)
                            }

                        }
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: 500,height: 300)
                        .onChange(of: weatherMapViewModel.coordinates){ newCoordinates in
                            //update the mapRegion when coordinate change
                            let newRegion = MKCoordinateRegion(center: newCoordinates!, latitudinalMeters: 8000, longitudinalMeters: 8000)
                            mapRegion = newRegion
                        }
                        
                        /* VStack{
                         Text("This is a locally defined map for starter template")
                         Text("A map of the user-entered location should be shown here")
                         Text("Map should also show pins of tourist places")
                         }.multilineTextAlignment(.leading)
                         .lineLimit(nil)
                         .fixedSize(horizontal: false, vertical: true)
                         */
                    }
                    .offset(y: -20)
                }
                //title
                Text("Tourist Attractions in \(weatherMapViewModel.city)")
                    .font(.title2)
                    .padding()
                // display the tourist location using the a list
               /* List(locations) { location in
                    if location.cityName == weatherMapViewModel.city {
                        HStack {
                            // Display each location in the list
                            Image(location.imageNames.first ?? "")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            Text(location.name)
                                .frame(width: 180, alignment: .leading)
                                .foregroundColor(.gray)
                        }
                    }
                }//List Close
                */
                ScrollView {
                    VStack{//VS image
                        ForEach(locations) { location in
                            VStack{
                                if location.cityName == weatherMapViewModel.city{
                                    HStack{
                                        // Display each location in the list
                                        Image(location.imageNames.first ?? "")
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                        Text(location.name)
                                            .frame(width: 180, alignment: .leading)
                                            .foregroundColor(.gray)
                                    }
                                    .onTapGesture {
                                        selectedLocation = location
                                    }
                                }
                            }
                        }
                    }
                }// ScrowView close
                //display the tourist location using a ForEach
            }.frame(height:700)
                .padding()
                .sheet(item: $selectedLocation) { selectedLocation in
                                TouristDetailsView(location: selectedLocation) // Create a DetailView for the selected location
                            }
        }
        .onAppear {
            // process the loading of tourist places
            locations = weatherMapViewModel.loadLocationsFromJSONFile(cityName: weatherMapViewModel.city) ?? weatherMapViewModel.loadLocationsFromJSONFile(cityName: "")!
        }
    }
}

// in order to make the CLLocationCoordinate2D work with the .onChange method, had to make the CLLocationCoordinate2D Equatable
extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

struct TouristPlacesMapView_Previews: PreviewProvider {
    static var previews: some View {
        TouristPlacesMapView()
    }
}
