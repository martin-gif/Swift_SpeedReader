//
//  Toolbar.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 15.05.23.
//

import AppKit

extension NSImage.Name {
    static let calendar = "calendar"
    static let today = "clock"
}

extension NSToolbarItem.Identifier {
    static let calendar = NSToolbarItem.Identifier(rawValue: "ShowCalendar")
    static let today = NSToolbarItem.Identifier(rawValue: "GoToToday")
}

extension NSToolbar {
    static let taskListToolbar: NSToolbar = {
        let toolbar = NSToolbar(identifier: "TaskListToolbar")
        toolbar.displayMode = .iconOnly
        
        return toolbar
    }()
}
