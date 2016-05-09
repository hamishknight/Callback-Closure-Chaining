//
//  RequestHandler.swift
//  Method Chaining 2
//
//  Created by Hamish Knight on 09/05/2016.
//  Copyright © 2016 Redonkulous Apps. All rights reserved.
//

import Foundation


// An enum to encapsulate the folllowing in its own namespace – not technically required
enum RequestHandler {
    
    // A few structs to encapsulate the input/output & result values
    struct Input {
        var foo:Int
        var bar:String
    }
    
    struct Output {
        var foo:Int
        var bar:String
    }
    
    enum Result {
        case Failure
        case Success(Output)
    }
    
    // replace with request logic
    static func doRequest(input:Input) -> ResultHandler {
        let resultHandler = ResultHandler()
        doSomethingAsynchronous(resultHandler.invokeCallbacks)
        return resultHandler
    }
    
    // replace with your actual asynchronous logic
    static func doSomethingAsynchronous(completion:Result->Void) {
        dispatch_async(dispatch_get_main_queue()) {
            if arc4random_uniform(2) == 0 {
                completion(.Success(Output(foo: 9, bar: "blah")))
            } else {
                completion(.Failure)
            }
        }
    }
}

class ResultHandler {
    
    typealias SuccessClosure = RequestHandler.Output->Void
    typealias FailureClosure = Void->Void
    
    // the success and failure callback arrays
    private var _successes = [SuccessClosure]()
    private var _failures = [FailureClosure]()
    
    /// Invoke all the stored callbacks with a given callback result
    func invokeCallbacks(result:RequestHandler.Result) {
        
        switch result {
        case .Success(let result):
            _successes.forEach{$0(result)}
        case .Failure:
            _failures.forEach{$0()}
        }
        _successes.removeAll()
        _failures.removeAll()
    }
    
    /// appends a new success callback to the result handler's successes array
    func success(closure:SuccessClosure) -> Self {
        _successes.append(closure)
        return self
    }
    
    /// appends a new failure callback to the result handler's failures array
    func failure(closure:FailureClosure) -> Self {
        _failures.append(closure)
        return self
    }
}
