//
//  JsonAPIConnector.swift
//  RecipePuppy
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

protocol JsonAPIConnectorDelegate: class {
    func onAPIResponse(response: [String: Any])
}

class JsonAPIConnector: NSObject, URLSessionDelegate {
    
    var apiURL: String
    weak var delegate: JsonAPIConnectorDelegate?
    
    init(withApiURL: String, delegate: JsonAPIConnectorDelegate) {
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
            
            self.delegate?.onAPIResponse(response: (content.toJson))
            
        })
        task.resume()
        
    }
    
    
    
}
