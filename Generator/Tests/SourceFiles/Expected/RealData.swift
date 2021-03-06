// MARK: - Torch entity extensions generated from file: ../../Tests/SourceFiles/RealData.swift

import Torch
import CoreData

internal extension Data {

    internal static var torch_name: String {
        return "UserProject_Data"
    }

    internal static let id = Torch.Property<Data, Int?>(name: "id")
    internal static let number = Torch.Property<Data, Int>(name: "number")
    internal static let optionalNumber = Torch.Property<Data, Int?>(name: "optionalNumber")
    internal static let numbers = Torch.Property<Data, [Int]>(name: "numbers")
    internal static let text = Torch.Property<Data, String>(name: "text")
    internal static let float = Torch.Property<Data, Float>(name: "float")
    internal static let double = Torch.Property<Data, Double>(name: "double")
    internal static let bool = Torch.Property<Data, Bool>(name: "bool")
    internal static let set = Torch.Property<Data, Set<Int>>(name: "set")
    internal static let relation = Torch.Property<Data, OtherData>(name: "relation")
    internal static let optionalRelation = Torch.Property<Data, OtherData?>(name: "optionalRelation")
    internal static let arrayWithRelation = Torch.Property<Data, [OtherData]>(name: "arrayWithRelation")
    internal static let readOnly = Torch.Property<Data, String>(name: "readOnly")

    internal init(fromManagedObject object: Torch.NSManagedObjectWrapper) throws {
        id = object.getValue(Data.id)
        number = object.getValue(Data.number)
        optionalNumber = object.getValue(Data.optionalNumber)
        numbers = object.getValue(Data.numbers)
        text = object.getValue(Data.text)
        float = object.getValue(Data.float)
        double = object.getValue(Data.double)
        bool = object.getValue(Data.bool)
        set = object.getValue(Data.set)
        relation = try object.getValue(Data.relation)
        optionalRelation = try object.getValue(Data.optionalRelation)
        arrayWithRelation = try object.getValue(Data.arrayWithRelation)
        readOnly = object.getValue(Data.readOnly)
    }

    internal mutating func torch_updateManagedObject(object: Torch.NSManagedObjectWrapper) throws {
        object.setValue(id, for: Data.id)
        object.setValue(number, for: Data.number)
        object.setValue(optionalNumber, for: Data.optionalNumber)
        object.setValue(numbers, for: Data.numbers)
        object.setValue(text, for: Data.text)
        object.setValue(float, for: Data.float)
        object.setValue(double, for: Data.double)
        object.setValue(bool, for: Data.bool)
        object.setValue(set, for: Data.set)
        try object.setValue(&relation, for: Data.relation)
        try object.setValue(&optionalRelation, for: Data.optionalRelation)
        try object.setValue(&arrayWithRelation, for: Data.arrayWithRelation)
        object.setValue(readOnly, for: Data.readOnly)
    }

    internal static func torch_describeEntity(to registry: Torch.EntityRegistry) {
        registry.description(of: Data.self)
    }

    internal static func torch_describeProperties(to registry: Torch.PropertyRegistry) {
        registry.description(of: Data.id)
        registry.description(of: Data.number)
        registry.description(of: Data.optionalNumber)
        registry.description(of: Data.numbers)
        registry.description(of: Data.text)
        registry.description(of: Data.float)
        registry.description(of: Data.double)
        registry.description(of: Data.bool)
        registry.description(of: Data.set)
        registry.description(of: Data.relation)
        registry.description(of: Data.optionalRelation)
        registry.description(of: Data.arrayWithRelation)
        registry.description(of: Data.readOnly)
    }
}

internal extension OtherData {

    internal static var torch_name: String {
        return "UserProject_OtherData"
    }

    internal static let id = Torch.Property<OtherData, Int?>(name: "id")
    internal static let text = Torch.Property<OtherData, String>(name: "text")

    internal init(fromManagedObject object: Torch.NSManagedObjectWrapper) throws {
        id = object.getValue(OtherData.id)
        text = object.getValue(OtherData.text)
    }

    internal mutating func torch_updateManagedObject(object: Torch.NSManagedObjectWrapper) throws {
        object.setValue(id, for: OtherData.id)
        object.setValue(text, for: OtherData.text)
    }

    internal static func torch_describeEntity(to registry: Torch.EntityRegistry) {
        registry.description(of: OtherData.self)
    }

    internal static func torch_describeProperties(to registry: Torch.PropertyRegistry) {
        registry.description(of: OtherData.id)
        registry.description(of: OtherData.text)
    }
}

internal struct UserProjectEntityBundle: Torch.TorchEntityBundle {
    internal let entityTypes: [Torch.TorchEntity.Type] = [
            Data.self,
            OtherData.self,
        ]

    internal init() { }
}
