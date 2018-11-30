//
//  BBServer.swift
//  login
//
//  Created by mnu on 21/10/2018.
//  Copyright © 2018 mundaco.com. All rights reserved.
//

import Foundation

extension Data {
    var toJson: [String: Any] {
        var json: [String: Any]
        do {
            json = try (JSONSerialization.jsonObject(with: self, options:JSONSerialization.ReadingOptions.mutableContainers)) as! [String: Any]
        } catch {
            return [:]
        }
        
        return json
    }
}

extension Dictionary {
    var toQueryString: String {
        var output: String = ""
        for (key,value) in self {
            output +=  "\(key)=\(value)&"
        }
        output = String(output.dropLast())
        return output.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

protocol ServerDelegate: class {
    func onServerResponse(response: [String: Any])
}

class Server: NSObject, URLSessionDelegate {
    
    var apiURL: String
    weak var delegate: ServerDelegate?
    
    init(withApiURL: String, delegate: ServerDelegate) {
        self.apiURL = withApiURL
        self.delegate = delegate
    }
    
    public func sendRequest(params: [String: Any]) {
        
        let url : URL = URL(string: "\(self.apiURL)?\(params.toQueryString)")!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error -> Void in
            
            guard error == nil else {
                print("returned error")
                return
            }
            
            guard let content = data else {
                print("No data")
                return
            }
            
            self.delegate?.onServerResponse(response: (content.toJson))
            
        })
        task.resume()
        
    }
    
    
    
}
