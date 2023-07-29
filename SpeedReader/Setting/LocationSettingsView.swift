//
//  LocationSettingsView.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 26.04.23.
//

import SwiftUI

struct LocationSettingsView: View {
    let fileManager = FileManagerSingelton.shared
    
    
    
    var body: some View {
        HStack{
            Text("Archives:")
                .bold()
            Text(fileManager.getPath().absoluteString)
                .frame(width: 200)
            Button("set"){
                fileManager.showInFinder(url: fileManager.getPath())
            }
        }
    }
}

struct LocationSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSettingsView()
            .frame(width: 375,height: 300)
    }
}
