//
//  ChainAsset.swift
//  AutoBit
//
//  Created by Eric Cerney on 7/10/15.
//  Copyright (c) 2015 Eric Cerney. All rights reserved.
//

import Foundation

public struct ChainAsset {
    public let assetID: String
    public let isMutable: Bool
    public let definititionURL: String
    public let definititionBase64: String
    public let definititionHash: String
    public let definitionReference: [String: AnyObject]
    
    public let name: String?
    public let nameShort: String?
    public let imageURL: String?
    public let description: String?
    
    // Info from GetBucketBalance
    public var total: Int = 0
    public var confirmed: Int = 0
    
    public let price: Int
    
    public init(json: JSON) {
        assetID = json["asset_id"].stringValue
        isMutable = json["definition_mutable"].stringValue == "true" ? true : false
        definititionURL = json["definition_url"].stringValue
        definititionBase64 = json["definition_base64"].stringValue
        definititionHash = json["definition_hash"].stringValue
        
        if let dictionary = json["definition_reference"].dictionaryObject {
            definitionReference = dictionary
            name = definitionReference["name"] as? String
            nameShort = definitionReference["name_short"] as? String
            imageURL = definitionReference["image_url"] as? String
            description = definitionReference["description"] as? String
        } else {
            definitionReference = [:]
            name = nil
            nameShort = nil
            imageURL = nil
            description = nil
        }
        
        price = Int(arc4random() % 20) + 5
    }
}