import Testing
@testable import baraka_iOS

struct LocalizationTests {
    @Test func toggleLanguageCyclesBetweenEnglishAndArabic() {
        let original = Localization.current

        Localization.setLanguage(.en)
        Localization.toggleLanguage()
        let toggled = Localization.current
        #expect(toggled != .en)

        Localization.toggleLanguage()
        #expect(Localization.current == .en)

        Localization.setLanguage(original)
    }

    @Test func buttonTitleMatchesLanguage() {
        let original = Localization.current

        Localization.setLanguage(.en)
        #expect(Localization.buttonTitle == "AR")

        Localization.toggleLanguage()
        #expect(Localization.buttonTitle == "EN")

        Localization.setLanguage(original)
    }

    @Test func pnlWithPercentageTextMatchesLanguage() {
        let original = Localization.current

        Localization.setLanguage(.en)
        #expect(Localization.pnlWithPercentageText == "Pnl (Pnl %)")

        Localization.setLanguage(.ar)
        #expect(Localization.pnlWithPercentageText == "الأرباح والخسائر (% الأرباح والخسائر)")

        Localization.setLanguage(original)
    }
}

