//
//  DefaultSettings.swift
//  Translate
//
//  Created by Yandel Gil on 10/1/24.
//


import Foundation
import AppKit

enum TranslationProvider: String {
  case google, deepl
}

enum MenuBarIcon: String, CaseIterable, Identifiable {
  case original = "MenuIcon"
  case minimal = "MenuIconMinimal"
  
  var id: String { self.rawValue }
}

struct DefaultSettings {
  
    static let translationProvider = TranslationProvider.google
    static let menuBarIcon = MenuBarIcon.minimal
  
  
  }
  
