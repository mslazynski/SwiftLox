//
//  main.swift
//  SwiftLox
//
//  Created by Mateusz Ślażyński on 12.02.2017.
//  Copyright © 2017 Mateusz Ślażyński. All rights reserved.
//

import Foundation

let io = ConsoleIO()
let builder = InterpreterBuilder.init(arguments: CommandLine.arguments, io: io)

if case let .success(interpreter) = builder.build() {
    interpreter.run().ignore()
} else {
    io.error(message: builder.help).ignore()
}
