

import SwiftUI

struct DailyWeatherView: View {
    var day: Daily
    var body: some View {
        HStack(spacing:15){
                //Icon
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(day.weather[0].icon)@2x.png"
                                   )) { image in
                    image
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding(.horizontal)
                } placeholder: {
                    ProgressView()
                    //this ProgressView method, which communicates the ongoing image loading process
                }
                
                VStack{
                    Text("\(day.weather[0].weatherDescription.rawValue)")
                        .font(.body) // Customize the font if needed
                    
                    let formattedDate = DateFormatterUtils.formattedDateWithWeekdayAndDay(from: TimeInterval(day.dt))
                    Text(formattedDate)
                        .font(.body) // Customize the font if needed
                }//VSI
                .frame(maxWidth: 200)
                .multilineTextAlignment(.center)
                
                Text("\((Double)(day.temp.min), specifier: "%.0f") ºC / \((Double)(day.temp.max), specifier: "%.0f") ºC")
                    .font(.body)
                
            }//HSI
            .background(
                Image("background")
                    .resizable()
                    .opacity(0.2)
                    .scaledToFill()
            )
            
        }
}

struct DailyWeatherView_Previews: PreviewProvider {
    static var day = WeatherMapViewModel().weatherDataModel!.daily
    static var previews: some View {
        DailyWeatherView(day: day[0])
    }
}
