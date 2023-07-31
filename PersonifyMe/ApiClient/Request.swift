//
//  Request.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 26/07/2023.
//

import Foundation


enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
    
    // ... add other HTTP methods as required
}


final class Request{

    private struct Constants{
        static let baseUrl   = "https://70ad-2a02-6b66-ea39-0-7087-1c69-8c48-bcb0.ngrok-free.app"
    }
    
    /// Desired endpoint
    let endpoint: Endpoint

    /// Path components for API, if any
    private let pathComponents: [String]

    /// Query arguments for API, if any
    private let queryParameters: [URLQueryItem]

    /// Constructed url for the api request in string format
    private var urlString: String {
        var string = Constants.baseUrl
        
        if (endpoint != .base){
            string += "/"
            string += endpoint.rawValue
        }
 

        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }

        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")

            string += argumentString
        }

        return string
    }

    /// Computed & constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }

    /// Desired http method
    public var httpMethod : HTTPMethod = .GET
    
    private var headers: [String: String] = [:]
    
    
    private var body : Data?
    
    /// Description
    /// - Parameters:
    ///   - endpoint: endpoints
    ///   - pathComponents: components
    ///   - queryParaments: paraments
    public init(endpoint: Endpoint ,  pathComponents: [String] = [] , queryParaments: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters =  queryParaments
        if let token   = (UserDefaults.standard.value(forKey: "token")){
            self.headers["Authorization"] = "Bearer \(token)"
        }
       
      
    }
    
    
    func add(headerField field: String, value: String) ->Request{
        self.headers[field] = value
        return self
    }
    
    
    func set (body : Data?) -> Request{
        self.body = body
        return self
    }
    
    
    func set(token : String) -> Request{
        self.headers["Authorization"] = "Bearer \(token)"
        return self
    }
    
    func set(method : HTTPMethod) -> Request{
        self.httpMethod =  method
        return self
    }
    
    func build() -> URLRequest?{
        guard let url = url else {
            return nil
        }
        var request  = URLRequest(url: url)
        request.allHTTPHeaderFields =  self.headers
        request.httpMethod =  self.httpMethod.rawValue
        request.httpBody =  self.body
        return request
        
    }
    
  
    
    
}



extension Request {
    static let listOfOrders = Request(endpoint: .orders)
    

}
