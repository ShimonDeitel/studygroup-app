import XCTest
@testable import Studygroup

@MainActor
final class StudygroupStoreTests: XCTestCase {

    func makeFreshStore() -> StudygroupStore {
        // Use a fresh store; it will load persisted state or seed data.
        let store = StudygroupStore()
        return store
    }

    func testSeedDataLoadsBelowFreeLimit() {
        let store = makeFreshStore()
        XCTAssertLessThan(store.items.count, StudygroupStore.freeLimit)
    }

    func testAddIncreasesCount() {
        let store = makeFreshStore()
        let before = store.items.count
        let added = store.add(title: "Test Entry", category: "Weekly Group", value: 1.0)
        XCTAssertTrue(added)
        XCTAssertEqual(store.items.count, before + 1)
    }

    func testCanAddMoreWhenBelowLimit() {
        let store = makeFreshStore()
        XCTAssertTrue(store.canAddMore)
    }

    func testFreeLimitBlocksAdditionalAdds() {
        let store = makeFreshStore()
        while store.items.count < StudygroupStore.freeLimit {
            _ = store.add(title: "Filler", category: "Weekly Group", value: 1.0)
        }
        let added = store.add(title: "Overflow", category: "Weekly Group", value: 1.0)
        XCTAssertFalse(added)
        XCTAssertEqual(store.items.count, StudygroupStore.freeLimit)
    }

    func testProBypassesFreeLimit() {
        let store = makeFreshStore()
        store.isPro = true
        while store.items.count < StudygroupStore.freeLimit {
            _ = store.add(title: "Filler", category: "Weekly Group", value: 1.0)
        }
        let added = store.add(title: "Extra", category: "Weekly Group", value: 1.0)
        XCTAssertTrue(added)
    }

    func testDeleteRemovesItem() {
        let store = makeFreshStore()
        _ = store.add(title: "ToDelete", category: "Weekly Group", value: 1.0)
        guard let item = store.items.first(where: { $0.title == "ToDelete" }) else {
            return XCTFail("item not found")
        }
        store.delete(item)
        XCTAssertNil(store.items.first(where: { $0.id == item.id }))
    }

    func testTotalValueSumsItems() {
        let store = makeFreshStore()
        let before = store.totalValue
        _ = store.add(title: "SumTest", category: "Weekly Group", value: 5.0)
        XCTAssertEqual(store.totalValue, before + 5.0, accuracy: 0.001)
    }

    func testToggleResolvedFlipsFlag() {
        let store = makeFreshStore()
        _ = store.add(title: "ResolveMe", category: "Weekly Group", value: 1.0)
        guard let item = store.items.first(where: { $0.title == "ResolveMe" }) else {
            return XCTFail("item not found")
        }
        XCTAssertFalse(item.isResolved)
        store.toggleResolved(item)
        XCTAssertTrue(store.items.first(where: { $0.id == item.id })!.isResolved)
    }
}
