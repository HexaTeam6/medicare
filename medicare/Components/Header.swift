//
//  Header.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 17/05/22.
//

import SwiftUI

// MARK: Header
struct Header: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text(greetingLogic())
                .font(.system(size: 32, weight: .light, design: .rounded))
            Text("Wahed")
                .font(.system(size: 32, weight: .bold, design: .rounded))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(Color("Navy"))
        .padding(.horizontal, 25)
        .padding(.top, 108)
    }
    
    func greetingLogic() -> String {
      let hour = Calendar.current.component(.hour, from: Date())
      
      let newDay = 0
      let noon = 12
      let sunset = 18
      let midnight = 24
      
      var greetingText = "Hello," // Default greeting text
      switch hour {
      case newDay..<noon:
          greetingText = "Good morning,"
      case noon..<sunset:
          greetingText = "Good afternoon,"
      case sunset..<midnight:
          greetingText = "Good evening,"
      default:
          _ = "Hello,"
      }
      
      return greetingText
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
