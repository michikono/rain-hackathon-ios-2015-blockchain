//
//  ChainAsset.swift
//  AutoBit
//
//  Created by Eric Cerney on 7/10/15.
//  Copyright (c) 2015 Eric Cerney. All rights reserved.
//

import Foundation

public struct ChainAsset {
    let assetID: String
    let isMutable: Bool
    let definititionURL: String
    let definititionBase64: String
    let definititionHash: String
    let definititionReference: [String: AnyObject]
    
    // Info from GetBucketBalance
    var total: Int = 0
    var confirmed: Int = 0
    
    public init(json: JSON) {
        assetID = json["asset_id"].stringValue
        isMutable = json["definition_mutable"].stringValue == "true" ? true : false
        definititionURL = json["definition_url"].stringValue
        definititionBase64 = json["definition_base64"].stringValue
        definititionHash = json["definition_hash"].stringValue
        
        if let dictionary = json["definition_reference"].dictionaryObject {
            definititionReference = dictionary
        } else {
            definititionReference = [:]
        }
    }
}