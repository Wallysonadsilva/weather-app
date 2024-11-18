

import SwiftUI

struct WeatherNowView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    @State private var isLoading = false
    @State private var temporaryCity = ""
    
    var body: some View {

        VStack{
            HStack{
                Text("Change Location")

                TextField("Enter New Location", text: $temporaryCity)
                    .onSubmit {

                        weatherMapViewModel.city = temporaryCity
                        Task {
                            do {
                                // write code to process user change of location
                                try await weatherMapViewModel.getCoordinatesForCity()
                                let result =  try? await weatherMapViewModel.loadData(lat: weatherMapViewModel.region.center.latitude, lon: weatherMapViewModel.region.center.longitude)
                                
                               // let result = try await weatherMapViewModel.loadData(lat: weatherMapViewModel.coordinates?.latitude ?? 0, lon: weatherMapViewModel.coordinates?.longitude ?? 0)

                            } catch {
                                print("Error: \(error)")
                                isLoading = false
                            }
                        }
                        temporaryCity = ""
                    }
            }
            .bold()
            .font(.system(size: 20))
            .padding(10)
            .shadow(color: .blue, radius: 10)
            .cornerRadius(10)
            .fixedSize()
            .font(.custom("Arial", size: 26))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .cornerRadius(15)
            VStack{
                HStack{
                    Text("Current Location: \(weatherMapViewModel.city)")
                }
                .bold()
                .font(.system(size: 20))
                .padding(10)
                .shadow(color: .blue, radius: 10)
                .cornerRadius(10)
                .fixedSize()
                .font(.custom("Arial", size: 26))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(15)

                
                if let timestamp = weatherMapViewModel.weatherDataModel?.current.dt,
                   let timezoneOffset = weatherMapViewModel.weatherDataModel?.timezoneOffset {
                    let localTimestamp = TimeInterval(timestamp) + Double(timezoneOffset)
                    let formattedDate = DateFormatterUtils.formattedDateTime(from:localTimestamp)
                    Text(formattedDate)
                        .padding()
                        .font(.title)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 1)
                }
                VStack{
                   
                    // Weather Temperature Value
                    if let forecast = weatherMapViewModel.weatherDataModel {
                        HStack{
                            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(forecast.current.weather[0].icon)@2x.png"
                                               )) { image in
                                image
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .padding(.horizontal)
                            } placeholder: {
                                ProgressView()
                                //this ProgressView method, which communicates the ongoing image loading process
                            }
                            
                            Text("\(forecast.current.weather[0].weatherDescription.rawValue)")
                                .font(.system(size: 25, weight: .medium))
                                .frame(width: 240)
                        }
                        HStack{
                            Image("temperature")
                                .resizable()
                                .frame(width:40, height: 40)
                                .padding(.horizontal)
                            Text("Temp: \((Double)(forecast.current.temp), specifier: "%.2f") ºC")
                                .font(.system(size: 25, weight: .medium))
                                .frame(width: 240)
                            
                        }
                        HStack{
                            Image("humidity")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .padding(.horizontal)
                            Text("Humidity: \(forecast.current.humidity) %")
                                .font(.system(size: 25, weight: .medium))
                                .frame(width: 240)
                        }
                        HStack{
                            Image("pressure")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .padding(.horizontal)
                            Text("Pressure: \(forecast.current.pressure) hPa")
                                .font(.system(size: 25, weight: .medium))
                                .frame(width: 240)
                        }
                        HStack{
                            Image("windSpeed")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.horizontal)
                            Text("Windspeed: \((Double)(forecast.current.windSpeed), specifier: "%.0f") mph")
                                .font(.system(size: 25, weight: .medium))
                                .frame(width: 240)
                        }
                        .padding(.all)
                    } else {
                        Text("Temp: N/A")
                            .font(.system(size: 25, weight: .medium))
                    }
                    
                }
               
            }//VS2
        }// VS1
        .background(Image("sky"))
    }
}
struct WeatherNowView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherNowView()
    }
}
