import Foundation

struct IntCode {
    // MARK: - Types

    enum Mode: Int {
        case positional = 0
        case immediate = 1
    }

    struct Op: Hashable {
        // MARK: - Properties

        let instruction: Int
        let run: (_ counter: inout Int, _ io: inout Int, _ memory: inout [Int]) -> Void

        // MARK: - Operations

        static let add = Op(instruction: 1) { pointerCounter, _, memory in
            let params = interpret(pointerCounter: pointerCounter, memory: memory, arguments: 3)
            let register = memory[pointerCounter + 3]
            memory[register] = params[0] + params[1]
            pointerCounter += 4
        }

        static let multiply = Op(instruction: 2) { pointerCounter, _, memory in
            let params = interpret(pointerCounter: pointerCounter, memory: memory, arguments: 3)
            let register = memory[pointerCounter + 3]
            memory[register] = params[0] * params[1]
            pointerCounter += 4
        }

        static let set = Op(instruction: 3) { pointerCounter, io, memory in
            let register = memory[pointerCounter + 1]
            memory[register] = io
            pointerCounter += 2
        }

        static let get = Op(instruction: 4) { pointerCounter, io, memory in
            let register = memory[pointerCounter + 1]
            memory[pointerCounter + 1] = register
            pointerCounter += 2
        }

        static let halt = Op(instruction: 99) { $0 = $2.count }

        // MARK: - Utility

        static func interpret(pointerCounter: Int, memory: [Int], arguments: Int) -> [Int] {
            var op = memory[pointerCounter]

            // 1002 => 02
            op /= 100

            var modes: [Mode] = op.digits.map { Mode(rawValue: $0)! }

            // Observe v1 behavior
            while modes.count < arguments {
                modes.insert(.positional, at: 0)
            }

            return modes
                .reversed()
                .enumerated()
                .map { (index, mode) -> Int in
                    let value = memory[pointerCounter + index + 1]
                    return mode == .positional
                        ? memory[value]
                        : value
                }
        }

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

    func run(input: Int = 0) -> ([Int], Int) {
        var pointerCounter = 0
        var io = input
        var mem = memory

        while pointerCounter < mem.count {
            let instruction = mem[pointerCounter] % 100

            guard let operation = operations[instruction] else {
                fatalError("Invalid Instruction: \(instruction)")
            }

            operation.run(&pointerCounter, &io, &mem)
        }

        return (mem, io)
    }
}
