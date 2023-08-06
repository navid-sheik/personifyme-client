//
//  Service.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 26/07/2023.
//

import Foundation

enum ServiceError : Error{
    case FailedToCreateRequest
    case FailedToPostData
    case FailedToGetData
    case InvalidResponse
    case NetworkUNavailble
    case FailedToDecodeResponse
    case NoResponseCode
    case UnAuthorized
    case CustomError(statusCode: Int, message : String, errorType : String)
}



/// API service object to get data
final class Service{
    
    
    /// Shared singleton
    static var shared  =  Service()
    
    /// Privatized Constructors
    private init(){}
    
   
    
    
    public func execute <T: Codable> (_ urlRequest :  URLRequest?,expecting type : T.Type, retryCount: Int = 0, completion : @escaping (Result <T, Error>) -> Void){
 
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
//                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                    print(jsonObject)
                    let result = try JSONDecoder().decode(type.self, from: data)
                    completion(.success(result))
                } catch let error as DecodingError {
                    print(error)
                    switch error {
                    case .typeMismatch(let context):
                        print("Type mismatch: \(context)")
                    case .valueNotFound(let context):
                        print("Value not found: \(context)")
                    case .keyNotFound(let key, let context):
                        print("Key not found: \(key.stringValue) in \(context.debugDescription)")
                    case .dataCorrupted(let context):
                        print("Data corrupted: \(context.debugDescription)")
                    @unknown default:
                        print("Unknown error: \(error.localizedDescription)")
                    }
                    completion(.failure(ServiceError.FailedToDecodeResponse))
                } catch {
                    print("Other error: \(error)")
                    completion(.failure(ServiceError.FailedToDecodeResponse))
                }
            }else if httpResponse.statusCode == 401{
                print("Unauthorized")
           
                if let success_getting_token = self?.refreshToken(), success_getting_token == true, retryCount < 2 {
                    print(success_getting_token)
//                    completion(.failure(ServiceError.UnAuthorized))
                    
                    
                    self?.execute(urlRequest, expecting: type, retryCount: retryCount + 1, completion: completion)
                }else {
                    AuthManager.clearUserDefaults()
                    completion(.failure(ServiceError.UnAuthorized))
                    
                }
            }
            
            else {
                do {
                    let errorResponse = try JSONDecoder().decode(ApiErrorResponse.self, from: data)
                    print(errorResponse)
                    completion(.failure(ServiceError.CustomError(statusCode: errorResponse.statusCode, message: errorResponse.message, errorType: errorResponse.errorType)))
                    
                } catch {
                    completion(.failure(ServiceError.InvalidResponse))
                }
            }
            
        }
        task.resume()
        
    }
    

    
    
    
   
    
    

  

    
    
    
    
   


    
    
    
    
    
    
  
}



///Auth Login -  Register - Logout -CheckStatus
extension Service{
    
    
    public func register<T:Codable>(_ userData : [String: Any], expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        //Send the data to server
        let jsonData  =  try? JSONSerialization.data(withJSONObject: userData)

        //Use the url request builder
        let request  =  Request(endpoint: .base, pathComponents: ["signup"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(body: jsonData)
            .set(method: .POST)
            .build()
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            completion(result)
        }
        
    }
    
    public func login<T:Codable>(_ userData : [String: Any], expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        //Send the data to server
        let jsonData  =  try? JSONSerialization.data(withJSONObject: userData)

        //Use the url request builder
        let request  =  Request(endpoint: .base, pathComponents: ["login"])
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
        let request  =  Request(endpoint: .base, pathComponents: ["logout"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .POST)
            .build()
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            completion(result)
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
}


///Auth Verification
extension Service{
    
   
    
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
    
    
    
}

///Password Reset
extension Service{
    ///Send Password Link
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
    
    ///Reset Verify Password Link
    public func verifyPasswordLink<T:Codable>(_ user_id : String, _ token : String,  expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        
        let request  =  Request(endpoint: .base, pathComponents: ["verifyPasswordLink", user_id, token])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .GET)
            .build()
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            completion(result)
        }
    }
    ///Reset Password
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
    
}




///Get  new JWT token from a refresh token
extension Service{
    public func refreshToken () -> Bool{
        var success = true
        
        guard let refreshToken  =  UserDefaults.standard.object(forKey: "refresh_token") else {
            print("Refresh Token Not Found")
            return false
            
            
        }
        
        
        print(refreshToken)

        
        let body = ["refreshToken" : refreshToken]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        let request  =  Request(endpoint: .base, pathComponents: ["token"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .POST)
            .set(body: jsonData)
            .build()
        
        
        let task = URLSession.shared.dataTask(with: request!) {[weak self] data, response, error in
            guard let self = self else {return}
            
            guard let data  =  data, error  == nil, let httpResponse = response as? HTTPURLResponse  else{
                success = false
                return
            }
            
//            print(error)
//            print(httpResponse.statusCode)
            
            
            if (200...299).contains(httpResponse.statusCode) {
                // If status code is in the range 200-299, try to decode the expected result
                let decoder = JSONDecoder()
                
                do {
                   
                    let myData = try decoder.decode(ApiResponse<TokenResponse>.self, from: data)
                    guard let user = myData.data else {return}
                    
                    let token =  user.token
                    let refreshToken =  user.refreshToken
                    
                    print("Refresh token \(token)")
                    print("Refresh token \(refreshToken)")
                    AuthManager.setUserDefaultsTokens(token: token, refresh_token: refreshToken)
                    
                    success = true
                } catch {
                    print("Failed to decode response: \(error)")
                    success = false
                }
            }else {
                success = false
            
            }
            
        }
        task.resume()
        
        
        
        return success
    }
}


///Stripe Onboarding

extension Service{
    
    
    public func createConnectAccount<T:Codable>(_ country : String, expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        
        let body = ["country" : country]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
      
        
        let request  =  Request(endpoint: .onboarding, pathComponents: ["account"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(body: jsonData)
            .set(method: .POST)
            .build()
        
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
              
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
            
            
        }
        
        
    }
    public func statusStripeAccount<T:Codable>( expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
    
        
        let request  =  Request(endpoint: .onboarding, pathComponents: ["status"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .POST)
            .build()
              
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
            
            
        }
        
        
    }
    
    
    
    

    
}


///Seller
extension Service{
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

//Product
extension Service{
    
    
    public func fetchAllProducts<T:Codable>(expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        
        let request  =  Request(endpoint: .products, pathComponents: [])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .GET)
            .build()
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
        }
        
    }
    
    public func createProduct<T:Codable>( _ product : ProductListing,expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        
    
        let jsonData  =  try? JSONEncoder().encode(product)
        
        let request  =  Request(endpoint: .products, pathComponents: ["create"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .POST)
            .set(body: jsonData)
            .build()
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
        }
        
    }
    
    
    
}

extension Service {
    
    
    public func fetchReviewForProduct<T:Codable>(_ productId : String,  expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        
        let request  =  Request(endpoint: .reviews, pathComponents: ["product", productId])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .GET)
            .build()
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
        }
        
    }
    
    public func createNewReview<T:Codable>( _ rating: Int, _ description : String, _ productId : String ,expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        
        let body = ["rating" : rating, "text" : description, "productId" : productId ] as [String : Any]
        
        
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted) {
            let request  =  Request(endpoint: .reviews, pathComponents: [])
                .add(headerField: "Content-Type", value: "application/json")
                .set(method: .POST)
                .set(body: jsonData)
                .build()
            
            Service.shared.execute(request, expecting: T.self) { [weak self] result in
                guard let _ = self else { return }
                
                completion(result)
                
                
            }
            
        }
    }
    
    
    
    
}


extension Service {
    
    public func fecthAllCategories<T:Codable>( expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        
        
        
        let request  =  Request(endpoint: .categories, pathComponents: [])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .GET)
            .build()
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
        }
        
    }
    
}
