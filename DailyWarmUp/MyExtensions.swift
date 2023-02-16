
import SwiftUI

extension Font {
    static func defaultFont(size: CGFloat) -> Font {
        return Font.custom("SourceSansPro-Black", size: size)
    }
    static func defaultRegularFont(size: CGFloat) -> Font {
        return Font.custom("SourceSansPro-Regular", size: size)
    }
}

extension Color {
    static var defaultBackground = Color(red: 245/255, green: 245/255, blue: 245/255)
}
