import Testing
@testable import baraka_iOS
import UIKit

struct SemanticsUtilityTests {
    @Test func updateSemanticsRecursively() {
        let root = UIView()
        let child = UIView()
        let grandchild = UIView()
        root.addSubview(child)
        child.addSubview(grandchild)
        SemanticsUtility.updateSemantics(for: root, semantic: .forceRightToLeft)
        #expect(root.semanticContentAttribute == .forceRightToLeft)
        #expect(child.semanticContentAttribute == .forceRightToLeft)
        #expect(grandchild.semanticContentAttribute == .forceRightToLeft)
    }
}
