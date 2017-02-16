//
//  Interpreter.swift
//  SwiftLox
//
//  Created by Mateusz Ślażyński on 16.02.2017.
//  Copyright © 2017 Mateusz Ślażyński. All rights reserved.
//

import Foundation

enum InterpretingError : Error {
    case dividedByZero
}

typealias InterepretingResult<V> = Result<V, InterpretingError>

protocol Interpreter {
    func run() -> InterepretingResult<Void>
}
