//
//  AppConfig.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import Foundation

struct AppConfig {
    let baseURL: URL
    let apiKey: String

    static let current: AppConfig = {
        guard
            let baseURLString = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String,
            let baseURL = URL(string: baseURLString),
            let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
        else {
            fatalError("Missing environment config — check Info.plist and xcconfig")
        }
        return AppConfig(baseURL: baseURL, apiKey: apiKey)
    }()
}
