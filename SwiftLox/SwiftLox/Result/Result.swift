//
//  Result.swift
//  SwiftLox
//
//  Created by Mateusz Ślażyński on 15.02.2017.
//  Copyright © 2017 Mateusz Ślażyński. All rights reserved.
//

enum Result<V, E> where E : Error {
    case success(V)
    case failure(E)
    case foreignFailure(Error)
    
    init(_ throwingExpr: (Void) throws -> V) {
        do {
            let value = try throwingExpr()
            self = Result.success(value)
        } catch let error as E {
            self = .failure(error)
        } catch let error {
            self = .foreignFailure(error)
        }
    }
    
    init(_ error: Error) {
        if let e = error as? E {
            self = .failure(e)
        } else {
            self = .foreignFailure(error)
        }
    }
    
    init(_ value: V) {
        self = .success(value)
    }
    
    init<NE : Error>(_ result: Result<V, NE>) {
        switch result {
        case let .success(value): self.init(value)
        case let .failure(error): self.init(error)
        case let .foreignFailure(error): self.init(error)
        }
    }

    func map<U>(f: (V) -> U) -> Result<U, E> {
        switch self {
        case .success(let t): return .success(f(t))
        case .failure(let err): return .failure(err)
        case .foreignFailure(let err): return .foreignFailure(err)
        }
    }
    
    func flatMap<U, NE : Error>(f: (V) -> Result<U, NE>) -> Result<U, NE> {
        switch self {
        case .success(let t): return f(t)
        case .failure(let error): return Result<U, NE>(error)
        case .foreignFailure(let error): return Result<U, NE>(error)
        }
    }
    
    func pack<NE: Error>() -> Result<V, NE> {
        return Result<V, NE>.init(self)
    }
    
    func ignore() -> Void {
        return
    }
    
    func resolve() throws -> V {
        switch self {
        case .success(let value): return value
        case .failure(let error): throw error
        case .foreignFailure(let error): throw error
        }
    }    
}
