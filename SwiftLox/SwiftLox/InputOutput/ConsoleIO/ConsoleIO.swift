//
//  ConsoleIO.swift
//  SwiftLox
//
//  Created by Mateusz Ślażyński on 15.02.2017.
//  Copyright © 2017 Mateusz Ślażyński. All rights reserved.
//

import Foundation

class ConsoleInput : Input {
    func read() -> IOResult<String> {
        let keyboard = FileHandle.standardInput
        let inputData = keyboard.availableData
        let decodingResult = String(data: inputData, encoding: String.Encoding.utf8)
        guard let input = decodingResult else {
            return .failure(.cantDecodeInput)
        }
        let trimmedInput = input.trimmingCharacters(in: CharacterSet.newlines)
        return .success(trimmedInput)
    }
}

class ConsoleOutput : Output {
    func write(message: String) -> IOResult<Void> {
        print("\u{001B}[;m\(message)")
        return .success()
    }
}

class ConsoleError : Output {
    func write(message: String) -> IOResult<Void> {
        fputs("\u{001B}[0;31m\(message)\n", stderr)
        return .success()
    }
}

class ConsoleIO : InputOutput {
    let input : Input = ConsoleInput()
    let output : Output = ConsoleOutput()
    let error : Output = ConsoleError()
}
