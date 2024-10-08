//
//  View+Widgets.swift
//  Piggy Banks
//
//  Created by Elijah Biede on 10/7/24.
//  Copyright © 2024 Empower. All rights reserved.
//

import SwiftUI
import WidgetKit

extension View {
    func tintable(_ tintable: Bool = true) -> some View {
        if #available(iOSApplicationExtension 16.0, watchOS 9.0, macOSApplicationExtension 13.0, *) {
            return widgetAccentable(tintable)
        }
        return self
    }
}

