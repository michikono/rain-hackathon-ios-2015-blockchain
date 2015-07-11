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
                
                completion(asset: ChainAsset(json: json))
            }).resume()
        } else {
            completion(asset: nil)
        }
    }
    
    public func getBucketBalances(bucketID: String, completion: () -> Void) {
        let baseURL = "https://api.chain.com/v3/"
        
        if let url = NSURL(string: baseURL)?.URLByAppendingPathComponent("buckets").URLByAppendingPathComponent(bucketID).URLByAppendingPathComponent("balance/assets") {
            println("URL: \(url)")
            
            let request = authedRequestForURL(url)
            
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                let json = JSON(data: data)
                
                println("json: \(json)")
                println("Error: \(error)")

                completion()
            }).resume()
        } else {
            completion()
        }
    }
    
    private func authedRequestForURL(url: NSURL) -> NSMutableURLRequest {
        var request = NSMutableURLRequest(URL: url)
        
        let basicAuthCredentials = "\(API_ID):\(API_SECRET)"
        let base64 = basicAuthCredentials.base64Encoded()
        request.setValue(base64, forHTTPHeaderField: "Authorization")
        
        return request
    }
}

extension String {
    func base64Encoded() -> String {
        let plainData = dataUsingEncoding(NSUTF8StringEncoding)
        let base64String = plainData?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        println("base64: \(base64String)")
        return base64String!
    }
}