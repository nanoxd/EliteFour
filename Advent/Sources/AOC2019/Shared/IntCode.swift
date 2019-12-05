import Foundation

struct IntCode {
    // MARK: - Types

    enum Mode {
        case positional
        case immediate
    }

    struct Op: Hashable {
        // MARK: - Properties

        let instruction: Int
        let run: (_ counter: inout Int, _ memory: inout [Int]) -> Void

        // MARK: - Operations

        static let add = Op(instruction: 1) { pointerCounter, memory in
            let pointer1 = memory[pointerCounter + 1]
            let pointer2 = memory[pointerCounter + 2]
            let register = memory[pointerCounter + 3]
            memory[register] = memory[pointer1] + memory[pointer2]
            pointerCounter += 4
        }

        static let multiply = Op(instruction: 2) { pointerCounter, memory in
            let pointer1 = memory[pointerCounter + 1]
            let pointer2 = memory[pointerCounter + 2]
            let register = memory[pointerCounter + 3]
            memory[register] = memory[pointer1] * memory[pointer2]
            pointerCounter += 4
        }

        static let set = Op(instruction: 3) { pointerCounter, memory in
            let register = memory[pointerCounter + 1]
            memory[register] = register
            pointerCounter += 2
        }

        static let get = Op(instruction: 4) { pointerCounter, memory in
            let register = memory[pointerCounter + 1]
            memory[pointerCounter + 1] = register
            pointerCounter += 2
        }

        static let halt = Op(instruction: 99) { $0 = $1.count }

        // MARK: - Equatable & Hashable

        static func == (lhs: IntCode.Op, rhs: IntCode.Op) -> Bool {
            lhs.instruction == rhs.instruction
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(instruction)
        }
    }

    // MARK: - Properties

    var memory: [Int]
    let operations: [Int: Op]

    // MARK: - Initializer

    init(memory: [Int], supportedOperations: Set<Op>) {
        self.memory = memory
        operations = Dictionary(uniqueKeysWithValues: supportedOperations.compactMap { ($0.instruction, $0) })
    }

    // MARK: - API

    func run() -> [Int] {
        var pointerCounter = 0
        var mem = memory

        while pointerCounter < mem.count {
            let instruction = mem[pointerCounter]

            guard let operation = operations[instruction] else {
                fatalError("Invalid Instruction: \(instruction)")
            }

            operation.run(&pointerCounter, &mem)
        }

        return mem
    }
}
