

import SwiftUI

struct TouristDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    var location: Location
    
    var body: some View {
        // Display information about the selected location
        NavigationView {
            VStack {
                Image(location.imageNames.first ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
                Text(location.name)
                    .font(.title)
                    .bold()
                    .padding()
                Text("\(location.description)")
                    .foregroundColor(.gray)
                    .padding()
                    .multilineTextAlignment(.center)
                Text("Link For more information:")
                    .foregroundColor(.gray)
                Link(destination: URL(string: location.link)!) {
                    Text(location.link)
                        .foregroundColor(.blue)
                        .underline()
                }
                HStack{
                    Text("Latitude: \(location.coordinates.latitude)")
                        .foregroundColor(.gray)
                        .padding()
                    
                    Text("Longitude: \(location.coordinates.longitude)")
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                Text("Dismiss")
            })
            .navigationBarTitle(Text(location.cityName), displayMode: .inline)
        }
    }
}

