

import Quick
import Nimble

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        describe("the 'Documentation' directory") {
            it("has everything you need to get started") {
                let sections = "Organized Tests with Quick Examples and Example Groups, Installing Quick"
                expect(sections).to(contain("Organized Tests with Quick Examples and Example Groups"))
                expect(sections).to(contain("Installing Quick"))
            }
            
            context("if it doesn't have what you're looking for") {
                it("needs to be updated") {
                    let you = true
                    expect{you}.toEventually(beTruthy())
                }
            }
        }
    }
}