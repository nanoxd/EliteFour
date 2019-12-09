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
            let params = interpret(pointerCounter: pointerCounter, memory: memory, arguments: 1)
            io = params[0]
            pointerCounter += 2
        }

        static let jumpIfTrue = Op(instruction: 5) { pointerCounter, _, memory in
            let params = interpret(pointerCounter: pointerCounter, memory: memory, arguments: 2)
            let shouldJump = params[0] != 0

            if shouldJump {
                pointerCounter = params[1]
            } else {
                pointerCounter += 3
            }
        }

        static let jumpIfFalse = Op(instruction: 6) { pointerCounter, _, memory in
            let params = interpret(pointerCounter: pointerCounter, memory: memory, arguments: 2)
            let shouldJump = params[0] == 0

            if shouldJump {
                pointerCounter = params[1]
            } else {
                pointerCounter += 3
            }
        }

        static let lessThan = Op(instruction: 7) { pointerCounter, _, memory in
            let params = interpret(pointerCounter: pointerCounter, memory: memory, arguments: 3)
            let register = memory[pointerCounter + 3]

            memory[register] = params[0] < params[1]
                ? 1 : 0

            pointerCounter += 4
        }

        static let equals = Op(instruction: 8) { pointerCounter, _, memory in
            let params = interpret(pointerCounter: pointerCounter, memory: memory, arguments: 3)
            let register = memory[pointerCounter + 3]

            memory[register] = params[0] == params[1]
                ? 1 : 0

            pointerCounter += 4
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

final class IntCode2 {
    var memory: [Int]
    var inputs = [Int]()
    var pointerCounter = 0
    var relativeBase = 0

    init(memory: [Int], inputs: [Int] = []) {
        self.memory = memory
        self.inputs = inputs
    }

    func executeUntilTermination() -> (outputs: [Int], termination: Int) {
        var outputs = [Int]()

        while true {
            let result = step()

            if let output = result.output {
                outputs.append(output)
            }

            if let termination = result.termination {
                return (outputs: outputs, termination: termination)
            }
        }
    }

    func step() -> (output: Int?, termination: Int?) {
        while true {
            let opcode = memory[pointerCounter]

            switch opcode % 100 {
            case 1:
                operate(operation: +)

            case 2:
                operate(operation: *)

            case 3:
                memory[pointerApplyingOpcode(atOffset: 1)] = inputs.removeFirst()
                pointerCounter += 2

            case 4:
                let value = valueOfMemory(atOffset: 1)
                pointerCounter += 2
                return (output: value, termination: nil)

            case 5:
                jump(ifTrue: true)

            case 6:
                jump(ifTrue: false)

            case 7:
                evaluate(operation: <)

            case 8:
                evaluate(operation: ==)
            case 9:
                let value = valueOfMemory(atOffset: 1)
                relativeBase += value
                pointerCounter += 2

            case 99:
                return (output: nil, termination: memory[0])

            default:
                fatalError()
            }
        }
    }

    private func pointerApplyingOpcode(atOffset offset: Int) -> Int {
        let opcode = memory[pointerCounter]
        let mode = opcode.digit(atPlace: offset + 1)
        let newPointer: Int

        switch mode {
        case 0:
            // position
            newPointer = memory[pointerCounter + offset]
        case 1:
            // immediate
            newPointer = pointerCounter + offset
        case 2:
            // relative
            newPointer = memory[pointerCounter + offset] + relativeBase
        default:
            fatalError()
        }

        allocateMemory(of: newPointer)
        return newPointer
    }

    private func valueOfMemory(atOffset offset: Int) -> Int {
        let index = pointerApplyingOpcode(atOffset: offset)
        return memory[index]
    }

    private func operate(operation: (Int, Int) -> Int) {
        let storeIndex = pointerApplyingOpcode(atOffset: 3)
        memory[storeIndex] = operation(valueOfMemory(atOffset: 1), valueOfMemory(atOffset: 2))
        pointerCounter += 4
    }

    private func evaluate(operation: (Int, Int) -> Bool) {
        let storeIndex = pointerApplyingOpcode(atOffset: 3)
        memory[storeIndex] = operation(valueOfMemory(atOffset: 1), valueOfMemory(atOffset: 2)) ? 1 : 0
        pointerCounter += 4
    }

    private func jump(ifTrue: Bool) {
        let passes: Bool = {
            if ifTrue { return valueOfMemory(atOffset: 1) != 0 }
            else { return valueOfMemory(atOffset: 1) == 0 }
        }()

        if passes {
            pointerCounter = valueOfMemory(atOffset: 2)
        } else {
            pointerCounter += 3
        }
    }

    private func allocateMemory(of count: Int) {
        guard count >= memory.count else { return }
        memory += [Int](repeating: 0, count: count - memory.count + 1)
    }
}

extension Int {
    func digit(atPlace place: Int) -> Int {
        self / Int(pow(10, Double(place))) % 10
    }
}
