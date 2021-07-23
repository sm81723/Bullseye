//
//  ContentView.swift
//  Bullseye
//
//  Created by Sean Mattingly on 7/17/21.
//

import SwiftUI

struct ContentView: View {
  
  @State private var alertIsVisible = false
  @State private var sliderValue = 50.0
  @State private var game = Game()
  
  var body: some View {
    ZStack {
      BackgroundView(game: $game)
      VStack {
        InstructionsView(game: $game)
          .padding(.bottom, alertIsVisible ? 0 : 100)
        if alertIsVisible {
          PointsView(game: $game, sliderValue: $sliderValue, alertIsVisible: $alertIsVisible)
            .transition(.scale)
        } else {
          HitMeButton(game: $game, sliderValue: $sliderValue, alertIsVisible: $alertIsVisible)
            .transition(.scale)
        }
      }
      if !alertIsVisible {
        SliderView(sliderValue: $sliderValue)
          .transition(.scale)
      }
    }
  }
}

struct InstructionsView: View {
  
  @Binding var game: Game
  
  var body: some View {
    VStack {
      InstructionText(text: "🎯🎯🎯\n Put the bullseye as close as you can to")
        .padding(.leading, 30.0)
        .padding(.trailing, 30.0)
      BigNumberText(text: String(game.target))
    }
  }
}

struct SliderView: View {
  @Binding var sliderValue: Double
  
  var body: some View {
    HStack {
      SliderLabelText(text: "1")
      Slider(value: $sliderValue, in: 1.0...100.0)
      SliderLabelText(text: "100")
    }
    .padding()
  }
}

struct HitMeButton: View {
  @Binding var game: Game
  @Binding var sliderValue: Double
  @Binding var alertIsVisible: Bool
  
  var body: some View {
    Button(action: {
      withAnimation {
        alertIsVisible = true
      }
    }) {
      Text("Hit me".uppercased())
        .bold()
        .font(.title3)
    }
    .padding(20.0)
    .background(
      ZStack {
        Color("ButtonColor")
        LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.3), Color.clear]), startPoint: .top, endPoint: .bottom)
      }
    )
    .foregroundColor(Color.white)
    .cornerRadius(Constants.General.roundRectCornerRadius)
    .overlay(
      RoundedRectangle(cornerRadius: Constants.General.roundRectCornerRadius)
        .strokeBorder(Color.white, lineWidth: Constants.General.strokeWidth)
    )
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
    ContentView()
      .preferredColorScheme(.dark)
    ContentView()
      .previewLayout(.fixed(width: 568, height: 320))
    ContentView()
      .preferredColorScheme(.dark)
      .previewLayout(.fixed(width: 568, height: 320))
  }
}
