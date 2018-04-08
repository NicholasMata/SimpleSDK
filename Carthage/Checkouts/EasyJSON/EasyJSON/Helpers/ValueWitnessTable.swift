//
//  ValueWitnessTable.swift
//  EasyJSON
//
//  Created by Nicholas Mata on 3/18/18.
//  Copyright © 2018 MataDesigns. All rights reserved.
//


struct ValueWitnessTable : PointerType {
    var pointer: UnsafePointer<_ValueWitnessTable>

    private var alignmentMask: Int {
        return 0x0FFFF
    }

    var size: Int {
        return pointer.pointee.size
    }

    var align: Int {
        return (pointer.pointee.align & alignmentMask) + 1
    }

    var stride: Int {
        return pointer.pointee.stride
    }
}

struct _ValueWitnessTable {
    let destroyBuffer: Int
    let initializeBufferWithCopyOfBuffer: Int
    let projectBuffer: Int
    let deallocateBuffer: Int
    let destroy: Int
    let initializeBufferWithCopy: Int
    let initializeWithCopy: Int
    let assignWithCopy: Int
    let initializeBufferWithTake: Int
    let size: Int
    let align: Int
    let stride: Int
}
