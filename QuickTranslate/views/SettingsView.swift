//
//  SettingsView.swift
//  Translate
//
//  Created by Yandel Gil on 10/1/24.
//

import SwiftUI
import Foundation
import ServiceManagement // Asegúrate de importar el framework ServiceManagement

struct SponsorButton: View {
    var body: some View {
        Link("Sponsor This Project 🙏",
             destination: URL(string: "https://paypal.me/yandelgil")!)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, minHeight: 30)
        .background(.blue)
        .cornerRadius(6)
        .padding(.top, 2)
        .padding(.bottom, 14)
    }
}

struct SettingsView: View {
    
    @AppStorage("translationProvider") private var translationProvider: TranslationProvider = DefaultSettings.translationProvider
    @AppStorage("menuBarIcon") private var menuBarIcon: MenuBarIcon = DefaultSettings.menuBarIcon
    @AppStorage("launchAtLogin") var launchAtLogin: Bool = false // Toggle desactivado por defecto
    
    var body: some View {
        VStack {
            SponsorButton()
            
            // Translation Provider
            Form {
                Picker("Translation Provider", selection: $translationProvider) {
                    Text("Google").tag(TranslationProvider.google)
                    Text("DeepL").tag(TranslationProvider.deepl)
                }
                .pickerStyle(.menu)
            }.frame(maxWidth: .infinity)
            
            Divider().padding(.bottom, 4)
            
            // Menu Bar Icon Toggle
            HStack {
                Text("Menu Bar Icon")
                Picker("", selection: $menuBarIcon) {
                    ForEach(MenuBarIcon.allCases) { icon in
                        Image(icon.rawValue)
                            .resizable()
                            .scaledToFit()
                            .tag(icon)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 100)
                Spacer()
            }
            
            // Centrando el Switch para abrir al inicio
            HStack {
                Spacer() // Espaciador a la izquierda
                Toggle("Open at login", isOn: $launchAtLogin)
                    .toggleStyle(SwitchToggleStyle())
                    .padding(.horizontal, 10)
                    .onChange(of: launchAtLogin) { newValue in
                        let appService = SMAppService.mainApp
                        do {
                            if newValue {
                                try appService.register() // Registrar la aplicación para abrir al inicio
                            } else {
                                try appService.unregister() // Desregistrar la aplicación
                            }
                        } catch {
                            print("Error al cambiar el estado de inicio al iniciar: \(error)")
                        }
                    }
                Spacer() // Espaciador a la derecha
            }
            .padding(.top, 10)
            
            // Version & Updates
            VStack(spacing: 2) {
                Spacer().frame(maxHeight: .infinity)
                Text("Version: \(Bundle.main.appVersionLong)")
                Link("Check for updates", destination: URL(string: "https://github.com/Yandelgil/QuickTranslate/releases/")!)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .frame(
                minWidth: Constants.AppSize.width,
                maxWidth: Constants.AppSize.width,
                minHeight: Constants.AppSize.height,
                maxHeight: Constants.AppSize.height
            )
    }
}
