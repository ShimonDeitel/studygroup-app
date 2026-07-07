import Foundation

struct StudygroupItem: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var title: String
    var category: String
    var value: Double
    var date: Date = Date()
    var notes: String = ""
    var isResolved: Bool = false
}

enum StudygroupCategory: String, CaseIterable, Codable {
        case weeklygroup = "Weekly Group"
    case examprep = "Exam Prep"
    case projectteam = "Project Team"
    case oneoff = "One-Off"
}
