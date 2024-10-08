//
//  TopView.swift
//  Translate
//
//  Created by Yandel Gil on 10/1/24.
//

import Foundation
import SwiftUI


struct SettingsButton: View {
  
  @ObservedObject var contentViewState: ContentViewState
  
  func toggleSettingsView() {
    switch contentViewState.currentView {
    case .translate:
      contentViewState.currentView = .settings
    case .settings:
      contentViewState.currentView = .translate
    }
  }
  
  var body: some View {
    Button() {
      toggleSettingsView()
    } label: {
      Image(systemName: contentViewState.currentView == .translate ? "gearshape" : "arrowshape.turn.up.backward")
        .font(.system(size: 14.0))
        .padding(.trailing, 12)
        .foregroundColor(.white)
    }.buttonStyle(.plain).keyboardShortcut(",")
  }
}

struct PowerButton: View {
  var body: some View {
    Button() {
      exit(0)
    } label: {
      Image(systemName: "power")
        .font(.system(size: 14.0, weight: .bold))
        .foregroundColor(.white)
    }
    .buttonStyle(.plain)
    
  }
}

struct TopView: View {
  @ObservedObject var contentViewState: ContentViewState
  
  var body: some View {
    HStack {
      Text("QuickTranslate")
        .padding()
        .foregroundColor(.white)
      Spacer()
      HStack {
        PowerButton()
        SettingsButton(contentViewState: contentViewState)
      }
    }
    .frame(minWidth: Constants.AppSize.width)
    .background(Color.blue)
  }
}
