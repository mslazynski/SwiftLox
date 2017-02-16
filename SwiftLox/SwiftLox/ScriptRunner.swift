//
//  ScriptRunner.swift
//  SwiftLox
//
//  Created by Mateusz Ślażyński on 16.02.2017.
//  Copyright © 2017 Mateusz Ślażyński. All rights reserved.
//

import Foundation

class ScriptRunner : Interpreter {
    let io : InputOutput
    let scriptReader : ScriptReader
    
    init(scriptReader : ScriptReader, io : InputOutput = ConsoleIO()) {
        self.io = io
        self.scriptReader = scriptReader
    }
    
    func run() -> InterepretingResult<Void> {
        return self.scriptReader.contents().flatMap(f: io.write).pack()
    }
}
