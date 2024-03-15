//
//  TelinkAdvertisementRow.swift
//  
//
//  Created by Alsey Coleman Miller on 3/15/24.
//

import Foundation
import SwiftUI
import Bluetooth
import Telink

struct TelinkAdvertisementRow: View {
    
    let advertisement: TelinkAdvertisement
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(verbatim: advertisement.name)
                .font(.title3)
            Text(verbatim: advertisement.manufacturerData.address.rawValue)
                .foregroundColor(.gray)
                .font(.subheadline)
        }
    }
}

#if DEBUG
struct TelinkAdvertisementRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                
            }
        }
    }
}
#endif
