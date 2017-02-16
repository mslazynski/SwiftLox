//
//  InputOutput.swift
//  SwiftLox
//
//  Created by Mateusz Ślażyński on 15.02.2017.
//  Copyright © 2017 Mateusz Ślażyński. All rights reserved.
//

import Foundation

enum IOError : Error {
    case cantReadStream
    case cantDecodeInput
}

typealias IOResult<V> = Result<V, IOError>

protocol Input {
    func read() -> IOResult<String>
}

protocol Output {
    func write(message: String) -> IOResult<Void>
}

protocol InputOutput {
    var input : Input { get }
    var output : Output { get }
    var error : Output { get }
}

extension InputOutput {
    func read() -> IOResult<String> {
        return self.input.read()
    }
    
    func write(message : String) -> IOResult<Void> {
        return self.output.write(message: message)
    }
    
    func error(message : String) -> IOResult<Void> {
        return self.error.write(message: message)
    }
}
