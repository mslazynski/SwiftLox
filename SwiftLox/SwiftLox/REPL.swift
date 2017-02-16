//
//  REPL.swift
//  SwiftLox
//
//  Created by Mateusz Ślażyński on 16.02.2017.
//  Copyright © 2017 Mateusz Ślażyński. All rights reserved.
//

import Foundation

class REPL : Interpreter {
    let io : InputOutput
    
    required init(io : InputOutput = ConsoleIO()) {
        self.io = io
    }
    
    func run() -> InterepretingResult<Void> {
        return read().flatMap(f: eval).flatMap(f: print).flatMap(f: loop)
    }
    
    func read() -> IOResult<String> {
        return io.read()
    }
    
    func eval(code: String) -> InterepretingResult<String> {
        return .success(code)
    }
    
    func print(message: String) -> IOResult<Void> {
        return io.write(message: message)
    }
    
    func loop() -> InterepretingResult<Void> {
        return run()
    }
}
