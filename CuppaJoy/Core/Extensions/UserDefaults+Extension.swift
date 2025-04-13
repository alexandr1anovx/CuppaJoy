import Foundation

extension UserDefaults {
  private enum Keys {
    static let isFirstLaunch = "isFirstLaunch"
  }
  
  var isFirstLaunch: Bool {
    get { object(forKey: Keys.isFirstLaunch) == nil }
    set { setValue(newValue, forKey: Keys.isFirstLaunch) }
  }
}
