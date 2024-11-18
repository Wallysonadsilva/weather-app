

import SwiftUI

struct HourWeatherView: View {
    var current: Current
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    
    var body: some View {
        let formattedDate = DateFormatterUtils.formattedDateWithDay(from: TimeInterval(current.dt))

      /*  VStack(alignment: .leading, spacing: 5) {
            Text(formattedDate)
                .font(.body)
                .padding(.horizontal)
                .background(Color.white)
                .foregroundColor(.black)

            Text("Add style & other elements")
                .frame(width: 125)
                .font(.body)
                .multilineTextAlignment(.leading)
                .lineLimit(nil) 
                .padding(.horizontal)
                .background(Color.white)
                .foregroundColor(.black)
        }*/
        ZStack{
                VStack() {
                    Text(formattedDate)
                    //Icon
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(current.weather[0].icon)@2x.png"
                                       )) { image in
                        image
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding(.horizontal)
                    } placeholder: {
                        ProgressView()
                        //this ProgressView method, which communicates the ongoing image loading process
                    }
                    Text("\((Double)(current.temp), specifier: "%.0f") ºC")
                    Text("\(current.weather[0].weatherDescription.rawValue)")
                    
                }//Close VStack
                .frame(width: 140, height: 135)
        }
        .frame(width: 150, height: 170)
        //.clipShape(RoundedRectangle(cornerRadius: 8))
        .cornerRadius(7.0)
        .background(
        RoundedRectangle(cornerRadius: 8)
            .fill(.mint)
        )
        
    }
}




