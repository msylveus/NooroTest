//
//  ContentView.swift
//  WeatherTracker
//
//  Created by Myrline Sylveus on 12/14/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var weatherVM: WeatherViewModel
    @State var textFieldVal = ""
    @AppStorage("savedCity") private var savedCity: String?
    
    var body: some View {
        VStack {
            searchView
            if weatherVM.showSpinner == true {
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            } else if savedCity == nil, weatherVM.showSearchResult == false  {
                Spacer()
                noCityView
            } else {
                if weatherVM.showSearchResult == true {
                    searchResultView
                } else if weatherVM.weather != nil {
                    savedCityHomeView
                }
            }
            
            Spacer()
        }
        .task {
            if let city = savedCity {
                do {
                    try await weatherVM.getWeatherServices(param: city)
                    
                } catch {
                    print("Error")
                }
            }
        }
    }
    
    private var searchView: some View {
        HStack {
            TextField("", text: $textFieldVal, prompt: Text("Search Location").font(Font.custom("Poppins", size: 15))
                .fontWeight(Font.Weight.regular)
                .foregroundStyle(Color.lightGray))
            .padding(.leading, 20.5)
            .onSubmit {
                weatherVM.searchCityWeather(param: textFieldVal)
                
            }
            
            Image(systemName: "magnifyingglass")
            .padding(.trailing, 20.5)
            .foregroundStyle(Color.lightGray)
            
        }
        .frame(height:46)
        .background(Color.paleGrayishWhite)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 24)
    }
    
    private var noCityView: some View {
        VStack(alignment: .center, spacing: 12.0) {
            Text("No City Selected")
                .font(Font.custom("Poppins", size: 30))
                .fontWeight(Font.Weight.semibold)
                .foregroundStyle(Color.blackishGray)
            Text("Please Search For A City")
                .font(Font.custom("Poppins", size: 15))
                .fontWeight(Font.Weight.semibold)
                .foregroundStyle(Color.blackishGray)
        }
        .padding()
    }
    
    private var savedCityHomeView: some View {
        VStack(alignment: .center, spacing: 5.0) {
            
            weatherIcon

            cityName
            
            temperature
            
            humidityView
            
            Spacer()
        }
        .padding(.top, 25)

    }
    
    private var weatherIcon: some View {
        AsyncImage(url: URL(string: weatherVM.weather?.current.condition.imageURL ?? "")) { image in
            
            image
                .resizable()
                .frame(width: 123, height: 113)
                .scaledToFill()
            
        } placeholder: {
            ProgressView()
        }
        
    }
    
    private var cityName: some View {
        HStack(spacing: 0.0) {
            Text(weatherVM.weather?.location.name ?? "").font(Font.custom("Poppins", size: 30))
                .fontWeight(Font.Weight.semibold)
                .foregroundStyle(Color.blackishGray)
                .padding(.trailing, 11)
            
            Image(systemName: "location.fill")
                .resizable()
                .frame(width: 21, height: 21)
                .aspectRatio(contentMode: .fill)
                
        }
    }
    
    private var temperature: some View {
        HStack {
            
            Label {
                Circle()
                    .stroke(lineWidth: 1.5)
                    .frame(width: 8, height: 8)
                    .padding(.bottom, 50)
                
            } icon: {
                Text("\(Int(weatherVM.weather?.current.tempF ?? 0))").font(Font.custom("Poppins", size: 70))
                    .fontWeight(Font.Weight.semibold)
                    .foregroundStyle(Color.blackishGray)
            }
        }
        .padding(.bottom, 26)
    }
    
    private var humidityView: some View {
        HStack(alignment: .center, spacing: 56.0) {
            VStack {
                Text("Humidity").font(Font.custom("Poppins", size: 12))
                    .fontWeight(Font.Weight.medium)
                    .foregroundStyle(Color.lightGray)
                
                Text("\(weatherVM.weather?.current.humidity ?? 0)%").font(Font.custom("Poppins", size: 15))
                    .fontWeight(Font.Weight.medium)
                    .foregroundStyle(Color.mediumGray)
                                            
            }
            .padding(.leading, 16)
            
            VStack {
                Text("UV").font(Font.custom("Poppins", size: 12))
                    .fontWeight(Font.Weight.medium)
                    .foregroundStyle(Color.lightGray)
                
                Text("\(Int(weatherVM.weather?.current.uv ?? 0))").font(Font.custom("Poppins", size: 15))
                    .fontWeight(Font.Weight.medium)
                    .foregroundStyle(Color.mediumGray)
                                            
            }
            
            VStack {
                Text("Feels Like").font(Font.custom("Poppins", size: 8))
                    .fontWeight(Font.Weight.medium)
                    .foregroundStyle(Color.lightGray)
                
                Text("\(Int(weatherVM.weather?.current.feelsLikeF ?? 0))°").font(Font.custom("Poppins", size: 15))
                    .fontWeight(Font.Weight.medium)
                    .foregroundStyle(Color.mediumGray)
                                            
            }
            .padding(.trailing, 28)
            
        }
        .frame(height:75)
        .background(Color.paleGrayishWhite)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private var searchResultView: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: -10) {
                Text("\(weatherVM.weather?.location.name ?? "")").font(Font.custom("Poppins", size: 20))
                    .fontWeight(Font.Weight.semibold)
                    .foregroundStyle(Color.blackishGray)
                    .padding(.top, 18)
                
                Label {
                    Circle()
                        .stroke(lineWidth: 1)
                        .frame(width: 5, height: 5)
                        .padding(.bottom, 50)
                    
                } icon: {
                    Text("\(Int(weatherVM.weather?.current.tempF ?? 0))").font(Font.custom("Poppins", size: 60))
                        .fontWeight(Font.Weight.semibold)
                        .foregroundStyle(Color.blackishGray)
                    
                }
            }
            .padding(.leading, 31)
            
            Spacer()
            
            VStack {
                AsyncImage(url: URL(string: weatherVM.weather?.current.condition.imageURL ?? "")) { image in
                    
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 83, height: 67)
                        
                    
                } placeholder: {
                    ProgressView()
                }
            }
            .padding(.trailing, 31)
            
        }
        .frame(height:117)
        .background(Color.paleGrayishWhite)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 20)
        .padding(.top, 22)
        .onTapGesture {
            weatherVM.showSearchResult = false
            savedCity = textFieldVal
        }
    }
}



#Preview {
    ContentView(weatherVM: WeatherViewModel(weatherService: WeatherAPIServices()))
}
