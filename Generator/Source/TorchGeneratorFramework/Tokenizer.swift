//
//  Tokenizer.swift
//  TorchGenerator
//
//  Created by Filip Dolnik on 21.07.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import SourceKittenFramework

public class Tokenizer {
    private let file: File
    private let source: String
    private var containsTorchEntity = false
    
    public init(sourceFile: File) {
        self.file = sourceFile
        
        source = sourceFile.contents
    }
    
    public func tokenize() -> FileRepresentation {
        let structure = Structure(file: file)
        
        let declarations = tokenize(structure.dictionary[Key.Substructure.rawValue] as? [SourceKitRepresentable] ?? [])
        
        return FileRepresentation(sourceFile: file, declarations: declarations, containsTorchEntity: containsTorchEntity)
    }
    
    private func tokenize(representables: [SourceKitRepresentable]) -> [Token] {
        return representables.flatMap(tokenize)
    }
    
    private func tokenize(representable: SourceKitRepresentable) -> Token? {
        guard let dictionary = representable as? [String: SourceKitRepresentable] else { return nil }
        
        let name = dictionary[Key.Name.rawValue] as? String ?? "name not set"
        let kind = dictionary[Key.Kind.rawValue] as? String ?? "unknown type"
        let accesibility = (dictionary[Key.Accessibility.rawValue] as? String).flatMap { Accessibility(rawValue: $0) }
        
        switch kind {
        case Kinds.StructDeclaration.rawValue:
            if accesibility == .Private {
                return nil
            }
            
            let children = tokenize(dictionary[Key.Substructure.rawValue] as? [SourceKitRepresentable] ?? [])
            
            let inheritedTypes = dictionary[Key.InheritedTypes.rawValue] as? [SourceKitRepresentable] ?? []
            let inheritedTypeNames = inheritedTypes.flatMap { $0 as? [String: SourceKitRepresentable] }.flatMap { $0[Key.Name.rawValue] as? String }
            let isTorchEntity = inheritedTypeNames.contains("TorchEntity")
            
            if isTorchEntity {
                containsTorchEntity = true
            }
            
            return StructDeclaration(
                name: name,
                accessibility: accesibility!,
                children: children,
                isTorchEntity: isTorchEntity
            )
        case Kinds.InstanceVariable.rawValue:
            return InstanceVariable(
                name: name,
                type: dictionary[Key.TypeName.rawValue] as! String,
                accessibility: accesibility!,
                isReadOnly: dictionary[Key.SetterAccessibility.rawValue] as? String == nil
            )
        default:
            return nil
        }
    }
}
