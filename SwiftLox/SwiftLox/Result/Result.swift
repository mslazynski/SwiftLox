//
//  Result.swift
//  SwiftLox
//
//  Created by Mateusz Ślażyński on 15.02.2017.
//  Copyright © 2017 Mateusz Ślażyński. All rights reserved.
//

protocol ResultError : Error {
    var error : Error { get }
    init(_ error: Error)
}

enum Result<V, E> where E : ResultError {
    case success(V)
    case failure(E)
    
    init( _ throwingExpr: (Void) throws -> V) {
        do {
            let value = try throwingExpr()
            self = Result.success(value)
        } catch let error as E {
            self = Result.failure(error)
        } catch let error {
            self = Result.failure(E.init(error))
        }
    }
    
    func map<U>(f: (V) -> U) -> Result<U, E> {
        switch self {
        case .success(let t): return .success(f(t))
        case .failure(let err): return .failure(err)
        }
    }
    
    func flatMap<U, NE>(f: (V) -> Result<U, NE>) -> Result<U, NE> {
        switch self {
        case .success(let t): return f(t)
        case .failure(let error): return .failure(NE.init(error.error))
        }
    }
    
    func resolve() throws -> V {
        switch self {
        case Result.success(let value): return value
        case Result.failure(let error): throw error
        }
    }
    
}
