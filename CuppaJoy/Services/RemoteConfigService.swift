//
//  RemoteConfigService.swift
//  CuppaJoy
//
//  Created by Oleksandr Andrianov on 19.12.2025.
//

import Foundation
import FirebaseRemoteConfig

protocol RemoteConfigServiceProtocol {
  func fetchAndActivate() async throws
  func getBool(forKey key: String) -> Bool
  func getString(forKey key: String) -> String
  func getInt(forKey key: String) -> Int
  func getDouble(forKey key: String) -> Double
}

final class RemoteConfigService: RemoteConfigServiceProtocol {
  
  private let remoteConfig: RemoteConfig
  
  init() {
    remoteConfig = RemoteConfig.remoteConfig()
    
    // Configure settings
    let settings = RemoteConfigSettings()
    settings.minimumFetchInterval = 0
    remoteConfig.configSettings = settings
    
    // Default values
    let defaults: [String: NSObject] = [
      "welcome_message": "Welcome to CuppaJoy!" as NSObject,
      "max_coffee_items": 10 as NSObject
    ]
    
    remoteConfig.setDefaults(defaults)
  }
  
  func fetchAndActivate() async throws {
    try await remoteConfig.fetch()
    try await remoteConfig.activate()
  }
  
  func getBool(forKey key: String) -> Bool {
    remoteConfig[key].boolValue
  }
  
  func getString(forKey key: String) -> String {
    remoteConfig[key].stringValue
  }
  
  func getInt(forKey key: String) -> Int {
    Int(truncating: remoteConfig[key].numberValue)
  }
  
  func getDouble(forKey key: String) -> Double {
    remoteConfig[key].numberValue.doubleValue
  }
}
