//
//  ChainAPI.swift
//  AutoBit
//
//  Created by Eric Cerney on 7/10/15.
//  Copyright (c) 2015 Eric Cerney. All rights reserved.
//

import Foundation

public class ChainAPI {
    
    public static let sharedInstance = ChainAPI()
    
    private let API_ID = "8f30105ef365e4ed7951de0fd88997d1"
    private let API_SECRET = "fb45c19c8fd166015ef4fb63fbae20ee"
    
    public func getAsset(assetID: String, completion: (asset: ChainAsset?) -> Void) {
        let baseURL = "https://w.chain.com/v3/"
        
        if let url = NSURL(string: baseURL)?.URLByAppendingPathComponent("assets").URLByAppendingPathComponent(assetID) {
            
            let request = authedRequestForURL(url)
            
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                let json = JSON(data: data)
                
                println("json: \(json)")
                println("Error: \(error)")
                
                dispatch_async(dispatch_get_main_queue()) {
                  completion(asset: ChainAsset(json: json))
                }
            }).resume()
        } else {
            dispatch_async(dispatch_get_main_queue()) {
                completion(asset: nil)
            }
        }
    }
    
    public func getBucketBalances(bucketID: String, completion: (assets: [ChainAsset]) -> Void) {
        let baseURL = "https://api.chain.com/v3/"
        
        if let url = NSURL(string: "https://blockchain-melody.herokuapp.com/api/buckets/")?.URLByAppendingPathComponent("aecbc268-2ed2-4143-b69c-da89c1bb9a99").URLByAppendingPathComponent("balances") {
            println("URL: \(url)")
            
            let request = authedRequestForURL(url)
            
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                let json = JSON(data: data)
                
                println("json: \(json)")
                println("Error: \(error)")

                var responseArray: [ChainAsset] = []
                var currentCompleted = 0
                
                for dictionary in json.arrayValue {
                    ChainAPI.sharedInstance.getAsset(dictionary["asset_id"].stringValue) { chainAsset in
                        println("Boom success: \(chainAsset)")
                        currentCompleted++
                        if var asset = chainAsset {
                            asset.total = dictionary["total"].intValue
                            asset.confirmed = dictionary["confirmed"].intValue
                            
                            responseArray.append(asset)
                        }
                        
                        if currentCompleted >= json.arrayValue.count {
                            dispatch_async(dispatch_get_main_queue()) {
                                println("Sending completion!")
                                completion(assets: responseArray)
                            }
                        }
                    }
                }
            }).resume()
        } else {
            dispatch_async(dispatch_get_main_queue()) {
                completion(assets: [])
            }
        }
    }
    
    private func authedRequestForURL(url: NSURL) -> NSMutableURLRequest {
        var request = NSMutableURLRequest(URL: url)
        
        let basicAuthCredentials = "\(API_ID):\(API_SECRET)"
        
        let base64 = basicAuthCredentials.base64Encoded()
        request.setValue("Basic \(base64)", forHTTPHeaderField: "Authorization")
        
        return request
    }
}

extension String {
    func base64Encoded() -> String {
        let plainData = dataUsingEncoding(NSUTF8StringEncoding)
        let base64String = plainData?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        return base64String!
    }
}

/*
for dictionary in json.arrayValue {
ChainAPI.sharedInstance.getAsset(dictionary["asset_id"].stringValue) { chainAsset in
println("Boom success: \(chainAsset)")
if var asset = chainAsset {
asset.total = dictionary["total"].intValue
asset.confirmed = dictionary["confirmed"].intValue

responseArray.append(asset)
}
}
}
*/