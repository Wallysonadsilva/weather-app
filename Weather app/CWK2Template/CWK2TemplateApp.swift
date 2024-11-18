

import SwiftUI

@main
struct CWK2TemplateApp: App {
    @StateObject var weatherMapViewModel = WeatherMapViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(weatherMapViewModel)
        }
    }
}
