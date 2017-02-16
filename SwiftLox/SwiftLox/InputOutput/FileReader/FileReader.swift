//
//  FileReader.swift
//  SwiftLox
//
//  Created by Mateusz Ślażyński on 16.02.2017.
//  Copyright © 2017 Mateusz Ślażyński. All rights reserved.
//

import Foundation

class FileReader : ScriptReader {
    let path : String
    let encoding : String.Encoding
    
    required init(path : String, encoding : String.Encoding = String.Encoding.utf8) {
        self.path = path
        self.encoding = encoding
    }
    
    func contents() -> ScriptReadingResult {
        return ScriptReadingResult.init({ (Void) -> String in
            return try String.init(contentsOfFile: path, encoding: self.encoding)
        })
    }
}
