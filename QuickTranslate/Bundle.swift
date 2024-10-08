//
//  Bundle.swift
//  Translate
//
//  Created by Yandel Gil on 10/1/24.
//
//  Implementation credits: https://stackoverflow.com/a/68912269/8011179

import Foundation

extension Bundle {
    public var copyright: String         { getInfo("NSHumanReadableCopyright").replacingOccurrences(of: "\\\\n", with: "\n") }
    public var appVersionLong: String    { getInfo("CFBundleShortVersionString") }
    //public var appVersionShort: String { getInfo("CFBundleShortVersion") }
    
    fileprivate func getInfo(_ str: String) -> String { infoDictionary?[str] as? String ?? "⚠️" }
}
