//
//  APIClient.swift
//  RecipePuppy
//
//  Created by mnu on 21/10/2018.
//  Copyright © 2018 mundaco.com. All rights reserved.
//

import Foundation

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

protocol APIClientDelegate: class {
    func onAPIResponse(response: Any)
}

class APIClient: NSObject, URLSessionDelegate {
    
    let apiURL = "http://www.recipepuppy.com/api/"
    weak var delegate: APIClientDelegate?
    
    init(delegate: APIClientDelegate) {
        self.delegate = delegate
    }
    
    public func sendRequest<T: Codable>(_ dump: T.Type, params: [String: Any], completionHandler: ((T) -> ())? = nil) {
        
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
            
            do {
                //Decode retrived data with JSONDecoder and assing type of Article object
                let decoded = try JSONDecoder().decode(T.self, from: content)
                if(completionHandler != nil) {
                    completionHandler!(decoded)
                }
                else {
                    self.delegate?.onAPIResponse(response: decoded)
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            
            
        })
        task.resume()
        
    }
    
    
    
}
