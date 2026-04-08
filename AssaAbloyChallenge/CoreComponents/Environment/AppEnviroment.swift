//
//  AppEnviroment.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import Foundation

enum AppEnviroment {
    case debug
    case release
    
    static var current: AppEnviroment {
#if DEBUG
        return .debug
#else
        return .release
#endif
    }
}
