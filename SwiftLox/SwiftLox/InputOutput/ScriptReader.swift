//
//  ScriptReader.swift
//  SwiftLox
//
//  Created by Mateusz Ślażyński on 16.02.2017.
//  Copyright © 2017 Mateusz Ślażyński. All rights reserved.
//

import Foundation

enum ScriptReadingError : Error {
    case incorrectEncoding
    case fileDoesNotExist
    case wrongPath
}

typealias ScriptReadingResult = Result<String, ScriptReadingError>

protocol ScriptReader {
    
    func contents() -> ScriptReadingResult
}
