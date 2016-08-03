//
//  Utils.swift
//  Torch
//
//  Created by Filip Dolnik on 01.08.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import RealmSwift

public struct Utils {
    
    public static func toValue<T: PropertyValueType>(managedValue: T) -> T {
        return managedValue
    }
    
    // For ID
    public static func toValue<T: PropertyValueType>(managedValue: T) -> T? {
        return managedValue
    }
    
    public static func toValue<T: PropertyValueType>(managedValue: RealmOptional<T>) -> T? {
        return managedValue.value
    }
    
    public static func toValue<T: PropertyOptionalType where T.Wrapped: PropertyValueType>(managedValue: T) -> T {
        return managedValue
    }
    
    public static func toValue<T: PropertyValueType, V: ValueTypeWrapper where V.ValueType == T>(managedValue: List<V>) -> [T] {
        return managedValue.map { $0.value }
    }
    
    public static func toValue<T: TorchEntity>(managedValue: T.ManagedObjectType?) -> T? {
        if let managedValue = managedValue {
            return T(fromManagedObject: managedValue)
        } else {
            return nil
        }
    }
    
    public static func toValue<T: TorchEntity>(managedValue: List<T.ManagedObjectType>) -> [T] {
        return managedValue.map { T(fromManagedObject: $0) }
    }
    
    public static func updateManagedValue<T: PropertyValueType>(inout managedValue: T, _ value: T) {
        managedValue = value
    }
    
    public static func updateManagedValue<T: PropertyValueType>(inout managedValue: RealmOptional<T>, _ value: T?) {
        managedValue.value = value
    }
    
    public static func updateManagedValue<T: PropertyOptionalType where T.Wrapped: PropertyValueType>(inout managedValue: T, _ value: T) {
        managedValue = value
    }
    
    public static func updateManagedValue<T: PropertyValueType, V: ValueTypeWrapper where V.ValueType == T>(inout managedValue: List<V>, _ value: [T]) {
        managedValue.first?.realm?.delete(managedValue)
        managedValue.removeAll()
        value.map {
            let wrapper = V()
            wrapper.value = $0
            return wrapper
        }.forEach { managedValue.append($0) }
    }
    
    public static func updateManagedValue<T: TorchEntity>(inout managedValue: T.ManagedObjectType?, inout _ value: T?, _ database: Database) {
        if var unwrapedValue = value {
            managedValue = database.getManagedObject(&unwrapedValue)
            value = unwrapedValue
        } else {
            managedValue = nil
        }
    }
    
    public static func updateManagedValue<T: TorchEntity>(inout managedValue: List<T.ManagedObjectType>, inout _ value: [T], _ database: Database) {
        managedValue.removeAll()
        for i in value.indices {
            managedValue.append(database.getManagedObject(&value[i]))
        }
    }
}