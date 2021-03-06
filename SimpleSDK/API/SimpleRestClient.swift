//
//  SimpleRestClient.swift
//  SimpleSDK
//
//  Created by Nicholas Mata on 3/16/18.
//  Copyright © 2018 MataDesigns. All rights reserved.
//

import UIKit

public protocol SimpleRestClient {
    associatedtype Key
    associatedtype Model

    func get(id: Key) -> Future<Model>
    func update(model: Model) -> Future<Model>
    func delete(model: Model)
}
