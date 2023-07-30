//
//  Service.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 26/07/2023.
//

import Foundation



/// API service object to get data
final class Service{
    
    
    /// Shared singleton
    static var shared  =  Service()
    
    /// Privatized Constructors
    private init(){}
    
    enum ServiceError : Error{
        case FailedToCreateRequest
        case FailedToPostData
        case FailedToGetData
        case InvalidRepsonse
        case NetworkUNavailble
        case FailedToDecodeResponse
        case NoResponseCode
        case UnAuthorized
        case CustomError(statusCode: Int, message : String)
    }
    
    
    
    
    public func execute <T: Codable> (_ urlRequest :  URLRequest?,expecting type : T.Type, completion : @escaping (Result <T, Error>) -> Void){
        guard let urlRequest =  urlRequest else {
            completion(.failure(ServiceError.FailedToCreateRequest))
            return
        }
        
        let task  = URLSession.shared.dataTask(with: urlRequest) {[weak self] data, response, error in
            guard let data  =  data, error  == nil, let httpResponse = response as? HTTPURLResponse  else{
                completion(.failure(error ?? ServiceError.FailedToGetData))
                return
            }
            
            
            print(error)
            print(httpResponse.statusCode)
        
           
          
            if (200...299).contains(httpResponse.statusCode) {
                    // If status code is in the range 200-299, try to decode the expected result
                    do {
                        let result = try JSONDecoder().decode(type.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(ServiceError.FailedToDecodeResponse))
                    }
            }else if httpResponse.statusCode == 401{
                
            
            
                completion(.failure(ServiceError.UnAuthorized))
            
            
            }
            
            
            else {
                // If status code is outside the range 200-299, try to decode an error message
                do {
                    //user normal decoder
                    
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print(json)
                    }
                    
//                    let errorResponse = try JSONDecoder().decode(ReponseError.self, from: data)
//                    let errorMessages = errorResponse.errors.map { $0.message }.joined(separator: "\n")
                    completion(.failure(ServiceError.NoResponseCode))
                } catch {
                    completion(.failure(ServiceError.InvalidRepsonse))
                }
                
            }
            
            
            
                
            
            
        }
        
        task.resume()
        
        
        
        
    }
    
    
    
    public func refreshToken (){
        
        guard let refreshToken  =  UserDefaults.standard.string(forKey: "refresh_token")else {
            print("Refresh Token Not Found")
            return
            
        }
        
        let body = ["refresh_token" : refreshToken]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        let request  =  Request(endpoint: .base, pathComponents: ["token"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .POST)
            .set(body: jsonData)
            .build()
        
        
        Service.shared.execute(request, expecting: AuthResponse.self) { [weak self] result in
        
            
            
        }
        
    }
    
    
    
    public func checkUserLoggedIn<T:Codable>(completion : @escaping (Result <T, Error>) -> Void){
        
        let request  =  Request(endpoint: .base, pathComponents: ["checkUserLoggedIn"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .POST)
            .build()
        
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            completion(result)
            
            
        }
        
    }
    
    public func sendVerificationLink<T:Codable>(_ email : String, expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        
        let body = ["email" : email]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        
        let request  =  Request(endpoint: .base, pathComponents: ["sendVerifyLink"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(body: jsonData)
            .set(method: .POST)
            .build()
        
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let strongSelf = self else { return }
            
            completion(result)
            
            
            
            
        }
        
        
    }
    
    public func verifyEmail<T:Codable>(_ email : String, _ verification_code : String, expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        
        let body = ["email" : email,"verification_token" : verification_code ]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        
        let request  =  Request(endpoint: .base, pathComponents: ["verify"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(body: jsonData)
            .set(method: .POST)
            .build()
        
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let strongSelf = self else { return }
            
            completion(result)
            
            
            
            
        }
        
        
    }
    
    
    public func sendPasswordResetLink<T:Codable>(_ email : String, expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        
        let body = ["email" : email]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        
        let request  =  Request(endpoint: .base, pathComponents: ["sendPasswordLink"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(body: jsonData)
            .set(method: .POST)
            .build()
        
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
            
            
        }
        
        
    }
    
    
    public func verifyPasswordLink<T:Codable>(_ user_id : String, _ token : String,  expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        
//        let body = ["email" : email]
//        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        
        let request  =  Request(endpoint: .base, pathComponents: ["verifyPasswordLink", user_id, token])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .GET)
            .build()
        
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
            
            
        }
        
        
    }
    
    public func resetPassword<T:Codable>(_ user_id : String, _ token : String,_ password : String, expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        
        let body = ["password" : password]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
      
        
        let request  =  Request(endpoint: .base, pathComponents: ["resetPassword", user_id, token])
            .add(headerField: "Content-Type", value: "application/json")
            .set(body: jsonData)
            .set(method: .POST)
            .build()
        
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
            
            
        }
        
        
    }
    
    
    public func logout<T:Codable>(expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        
//        let body = ["password" : password]
//        let jsonData = try? JSONSerialization.data(withJSONObject: body)
//
//
        let request  =  Request(endpoint: .base, pathComponents: ["logout"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .POST)
            .build()
        
        
        print(request)
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
        }
        
    }
    
    public func createConnectAccount<T:Codable>(_ country : String, expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        
        let body = ["country" : country]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
      
        
        let request  =  Request(endpoint: .onboarding, pathComponents: ["account"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(body: jsonData)
            .set(method: .POST)
            .build()
        
        print("request is \(request)")
      
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
            
            
        }
        
        
    }


    
    
    
    
    
    public func sendVerificationStripeLink<T:Codable>( expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
    
        
        let request  =  Request(endpoint: .onboarding, pathComponents: ["link"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .POST)
            .build()
        
        print("request is \(request)")
      
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
            
            
        }
        
        
    }
    
    public func checkSellerStatus<T:Codable>( expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
    
        
        let request  =  Request(endpoint: .seller, pathComponents: ["account"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .GET)
            .build()
        
//        print("request is \(request)")
//      
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
            
            
        }
        
        
    }
    
    


    
    
    
    
    
    
  
}

