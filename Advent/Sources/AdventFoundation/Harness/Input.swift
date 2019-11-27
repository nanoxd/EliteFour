//
//  Input.swift
//  Advent of Code
//
//  Created by Dave DeLong on 12/1/18.
//  Copyright © 2018 Dave DeLong. All rights reserved.
//
import Foundation

public protocol StringInput {
    init(_ raw: String)
    var raw: String { get }
    var integer: Int? { get }
    var characters: [Character] { get }

    var trimmed: Self { get }
    var lines: [Line] { get }
    var words: [Word] { get }
}

public final class Input: StringInput {
    public convenience init(file: String) { self.init(try! String(contentsOfFile: file)) }
    public init(_ raw: String) { self.raw = raw.trimmingCharacters(in: .newlines) }

    public let raw: String
    public lazy var integer: Int? = { Int(raw) }()
    public lazy var characters: [Character] = { Array(raw) }()

    public lazy var trimmed: Input = { Input(raw.trimmingCharacters(in: .whitespacesAndNewlines)) }()
    public lazy var lines: [Line] = { raw.components(separatedBy: .newlines).map { Line($0) } }()
    public lazy var words: [Word] = { raw.components(separatedBy: .whitespaces).filter { $0.isEmpty == false }.map { Word($0) } }()

    public lazy var rawLines: [String] = { lines.raw }()
    public lazy var rawWords: [String] = { words.raw }()
    public lazy var rawLineWords: [[String]] = { lines.words.raw }()
}

public final class Line: StringInput {
    public init(_ raw: String) { self.raw = raw }

    public let raw: String
    public lazy var integer: Int? = { Int(raw) }()
    public lazy var characters: [Character] = { Array(raw) }()

    public lazy var trimmed: Line = { Line(raw.trimmingCharacters(in: .whitespacesAndNewlines)) }()
    public var lines: [Line] { [self] }
    public lazy var words: [Word] = { raw.components(separatedBy: .whitespaces).filter { $0.isEmpty == false }.map { Word($0) } }()

    public lazy var integers: [Int] = {
        let matches = Regex.integers.matches(in: raw)
        return matches.compactMap { $0.int(1) }
    }()
}

public final class Word: StringInput {
    public init(_ raw: String) { self.raw = raw }

    public let raw: String
    public lazy var integer: Int? = { Int(raw) }()
    public lazy var characters: [Character] = { Array(raw) }()

    public lazy var trimmed: Word = { Word(raw.trimmingCharacters(in: .whitespacesAndNewlines)) }()
    public lazy var lines: [Line] = { [Line(raw)] }()
    public var words: [Word] { [self] }
}

extension Collection where Element: StringInput {
    public var raw: [String] { map { $0.raw } }
    public var integers: [Int] { map { $0.integer! } }
    public var characters: [[Character]] { map { $0.characters } }

    public var trimmed: [Element] { map { $0.trimmed } }
    public var lines: [[Line]] { map { $0.lines } }
    public var words: [[Word]] { map { $0.words } }
}

extension Collection where Element: Collection, Element.Element: StringInput {
    public var raw: [[String]] { map { $0.raw } }
    public var integers: [[Int]] { map { $0.integers } }
}

extension Collection where Element == Character {
    public var integers: [Int] { map { Int("\($0)")! } }
}
