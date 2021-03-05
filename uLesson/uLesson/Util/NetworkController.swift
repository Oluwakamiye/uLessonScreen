//
//  NetworkController.swift
//  uLesson
//
//  Created by Oluwakamiye Akindele on 04/03/2021.
//

import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif


class NetworkController {
    
    static func makeGetCall<T: Decodable>(_ urlString: String, errorHandler: @escaping (String) -> Void, completionHandler: @escaping (T) -> Void) {
        if let url = URL(string: urlString){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let responseData = data {
                    do{
                        let decoder = JSONDecoder()
                        let model = try decoder.decode(T.self, from: responseData)
                        completionHandler(model)
                    } catch{
                        errorHandler("An error occurred")
                    }
                } else{
                    errorHandler("An error occurred")
                }
            }
            
            task.resume()
        } else {
            errorHandler("An error occurred")
        }
    }
}
