import SwiftUI

struct OKLCHColor {
    let l: Double
    let c: Double
    let h: Double

    func toColor() -> Color {
        let hr = h * Double.pi / 180.0
        let a = c * cos(hr)
        let bAxis = c * sin(hr)

        let l_ = l + 0.3963377774 * a + 0.2158037573 * bAxis
        let m_ = l - 0.1055613458 * a - 0.0638541728 * bAxis
        let s_ = l - 0.0894841775 * a - 1.2914855480 * bAxis

        let l3 = l_ * l_ * l_
        let m3 = m_ * m_ * m_
        let s3 = s_ * s_ * s_

        let rLinear = 4.0767416621 * l3 - 3.3077115913 * m3 + 0.2309699292 * s3
        let gLinear = -1.2684380046 * l3 + 2.6097574011 * m3 - 0.3413193965 * s3
        let bLinear = -0.0041960863 * l3 - 0.7034186147 * m3 + 1.7076147010 * s3

        func compand(_ value: Double) -> Double {
            if value <= 0.0031308 {
                return 12.92 * value
            }
            return 1.055 * pow(value, 1.0 / 2.4) - 0.055
        }

        let r = max(0, min(1, compand(rLinear)))
        let g = max(0, min(1, compand(gLinear)))
        let b = max(0, min(1, compand(bLinear)))

        return Color(red: r, green: g, blue: b)
    }
}

enum Theme {
    static let background = OKLCHColor(l: 0.18, c: 0.04, h: 250).toColor()
    static let foreground = OKLCHColor(l: 0.98, c: 0.0, h: 0).toColor()
    static let card = OKLCHColor(l: 0.22, c: 0.04, h: 250).toColor()
    static let primary = OKLCHColor(l: 0.75, c: 0.15, h: 195).toColor()
    static let primaryForeground = OKLCHColor(l: 0.18, c: 0.04, h: 250).toColor()
    static let secondary = OKLCHColor(l: 0.30, c: 0.05, h: 250).toColor()
    static let muted = OKLCHColor(l: 0.25, c: 0.04, h: 250).toColor()
    static let mutedForeground = OKLCHColor(l: 0.65, c: 0.02, h: 250).toColor()
    static let border = OKLCHColor(l: 0.35, c: 0.05, h: 250).toColor()
    static let destructive = OKLCHColor(l: 0.55, c: 0.22, h: 25).toColor()
    static let success = OKLCHColor(l: 0.74, c: 0.18, h: 145).toColor()
    static let warning = OKLCHColor(l: 0.72, c: 0.18, h: 70).toColor()
    static let alert = OKLCHColor(l: 0.72, c: 0.14, h: 30).toColor()
    static let magenta = OKLCHColor(l: 0.68, c: 0.22, h: 320).toColor()
}
