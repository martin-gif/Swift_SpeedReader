//
//  colorComponent.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 23.03.23.
//

import Foundation
import RealmSwift

class colorComponent: EmbeddedObject {
   @Persisted var red: Double = 0
   @Persisted var green: Double = 0
   @Persisted var blue: Double = 0
   @Persisted var alpha: Double = 1

   convenience init(red: Double, green: Double, blue: Double, alpha: Double) {
      self.init()
      self.red = red
      self.green = green
      self.blue = blue
      self.alpha = alpha
   }
}
