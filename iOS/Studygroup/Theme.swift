import SwiftUI

/// Bespoke palette for Studygroup: Log study group meetups, who attended, and what was covered.
enum Theme {
    static let accent = Color(red: 0.247, green: 0.714, blue: 0.788)
    static let background = Color(red: 0.031, green: 0.078, blue: 0.082)
    static let card = Color(red: 0.059, green: 0.137, blue: 0.149)
    static let ink = Color(white: 0.95)
    static let mutedInk = Color(white: 0.65)

    static func titleFont(_ size: CGFloat = 28) -> Font {
        .system(size: size, weight: .bold, design: .rounded)
    }
    static func bodyFont(_ size: CGFloat = 16) -> Font {
        .system(size: size, weight: .regular, design: .rounded)
    }
    static func labelFont(_ size: CGFloat = 13) -> Font {
        .system(size: size, weight: .semibold, design: .rounded)
    }

    static let cornerRadius: CGFloat = 18
}
