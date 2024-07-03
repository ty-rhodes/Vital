//
//  TabItem.swift
//  Vital
//
//  Created by Tyler Rhodes on 7/3/24.
//

import SwiftUI

struct TabItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: Image
    var tab: Tab
}

var tabItems = [
    TabItem(text: "Data", icon: Image(systemName: "heart.text.square"), tab: .dashboard),
    TabItem(text: "Settings", icon: Image(systemName: "gearshape"), tab: .account)
    
]

enum Tab: String {
    case dashboard
    case account
}
