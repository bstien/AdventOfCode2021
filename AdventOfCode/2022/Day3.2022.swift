import Foundation

extension Year2022.Day3: Runnable {
    func run(input: String) {
        let backpacks = splitInput(input).map {
            let backpackSize = $0.count / 2
            let lhs = String($0.prefix(backpackSize))
            let rhs = String($0.suffix(backpackSize))
            return Backpacks(lhs: lhs, rhs: rhs)
        }

        let itemPriorityOrder = ("a"..."z").characters + ("A"..."Z").characters

        let prioritySum = backpacks
            .map { backpacks -> Character in
                guard let firstOverlappingItem = backpacks.lhs.first(where: { backpacks.rhs.contains($0) }) else {
                    fatalError("Could not find overlapping item in backpacks. lhs: '\(backpacks.lhs)' – rhs: '\(backpacks.rhs)'")
                }

                return firstOverlappingItem
            }.map { overlappingItem in
                guard let index = itemPriorityOrder.firstIndex(where: { $0 == overlappingItem }) else {
                    fatalError("Could not find priority for item '\(overlappingItem)'")
                }

                return index + 1
            }.reduce(0, +)

        printResult(dayPart: 1, message: "Sum of overlapping items: \(prioritySum)")
    }
}

private extension Year2022.Day3 {
    typealias Backpacks = (lhs: String, rhs: String)
}

private extension ClosedRange where Bound == Unicode.Scalar {
    var range: ClosedRange<UInt32>  { lowerBound.value...upperBound.value }
    var scalars: [Unicode.Scalar]   { range.compactMap(Unicode.Scalar.init) }
    var characters: [Character]     { scalars.map(Character.init) }
}
