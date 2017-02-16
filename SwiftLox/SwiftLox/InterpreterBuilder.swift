//
//  InterpreterBuilder.swift
//  SwiftLox
//
//  Created by Mateusz Ślażyński on 16.02.2017.
//  Copyright © 2017 Mateusz Ślażyński. All rights reserved.
//

import Foundation

enum InterpreterBuildingError : Error {
    case tooManyArguments
    case notEnoughArguments
}

typealias InterpreterBuildingResult = Result<Interpreter, InterpreterBuildingError>

class InterpreterBuilder {
    let arguments : [String]
    let io : InputOutput
    var help = "Usage: SwiftLox [script]"
    
    required init(arguments: [String], io: InputOutput = ConsoleIO()) {
        self.arguments = arguments
        self.io = io
    }
    
    func build() -> InterpreterBuildingResult {
        switch self.arguments.count {
            case 0: return .failure(.notEnoughArguments)
            case 1: return .success(buildREPL())
            case 2: return .success(buildScriptRunner(withScriptPath: self.arguments[1]))
            default: return .failure(.tooManyArguments)
        }
    }
    
    private func buildREPL() -> REPL {
        return REPL.init(io: io)
    }
    
    private func buildScriptRunner(withScriptPath path: String) -> ScriptRunner {
        let scriptReader = FileReader.init(path: path)
        return ScriptRunner.init(scriptReader: scriptReader, io: io)
    }
    
}
