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
    
   
    
    
    public func execute <T: Codable> (_ urlRequest :  URLRequest?,expecting type : T.Type, retryCount: Int = 0,  completion : @escaping (Result <T, Error>) -> Void){
 
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
//
            if (200...299).contains(httpResponse.statusCode) {
                // If status code is in the range 200-299, try to decode the expected result
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print(jsonObject)
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
                    let user_id = user.user_id
                    let seller_id = user.seller_id
                    
                    
                    
                    print("Refresh token \(token)")
                    print("Refresh token \(refreshToken)")
                    print("Refresh token \(user_id)")
                    AuthManager.setUserDefaultsTokens(token: token, refresh_token: refreshToken, user_id: user_id, seller_id: seller_id)
                    
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

//Cart


extension Service{
    public func fetchCart<T:Codable>( expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        
        
        
        let request  =  Request(endpoint: .cart, pathComponents: [])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .GET)
            .build()
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
        }
    }
    
    public func addProductToCart<T:Codable>(_ cartItem : CartItemSend , expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        

     
      
        let jsonData  =  try? JSONEncoder().encode(cartItem)
        
        let request  =  Request(endpoint: .cart, pathComponents: ["items"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .POST)
            .set(body: jsonData)
            .build()
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
        }
    }
    
    public func deleteProductFromCart<T:Codable>(_ itemId : String , expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        

     
        
        let request  =  Request(endpoint: .cart, pathComponents: ["items", itemId])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .DELETE)
            .build()
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
        }
    }
    
    public func updateProductFromCart<T:Codable>(_ cartItemId : String , _ cartItem: CartItem,   expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        

        let jsonData  =  try? JSONEncoder().encode(cartItem)
        
        let request  =  Request(endpoint: .cart, pathComponents: ["items", cartItemId])
            .add(headerField: "Content-Type", value: "application/json")
        
            .set(method: .PUT)
            .set(body: jsonData)
            .build()
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
        }
    }
    
    
    
    public func clearCart<T:Codable>(  expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        

    
        
        let request  =  Request(endpoint: .cart, pathComponents: [])
            .add(headerField: "Content-Type", value: "application/json")
        
            .set(method: .DELETE)
            .build()
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
        }
    }
    
        
}
extension Service{
    public func createPaymentIntent<T:Codable>(   expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        
        let request  =  Request(endpoint: .base, pathComponents: ["create-payment-intent"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .POST)
            .build()
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
        }
    }
    
    public func createNewOrder<T:Codable>(_ order : Order,   expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        
        let jsonData  =  try? JSONEncoder().encode(order)
        
        let request  =  Request(endpoint: .orders, pathComponents: ["success"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .POST)
            .set(body: jsonData)
            .build()
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
        }
    }
    
    
    
    
    
    
    public func updateOrder<T:Codable>(  _ orderId : String,  with order : Order ,expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        
        let jsonData  =  try? JSONEncoder().encode(order)
        
        let request  =  Request(endpoint: .orders, pathComponents: [orderId])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .PUT)
            .set(body: jsonData)
            .build()
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
        }
    }
        
    
    
    
    
    
    
}



extension Service{
    public func getOrdersForBuyers<T:Codable>(expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        let request  =  Request(endpoint: .orders, pathComponents: ["items"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .GET)
            .build()
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
        }
    }
    
    public func getOrderFromSeller<T:Codable>(  expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        let request  =  Request(endpoint: .orders, pathComponents: ["seller"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .GET)
            .build()
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
        }
    }
}


extension Service{
    
    public func uploadTrackingNumber<T:Codable>( to orderId : String, with  trackingObject : Tracking , expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        
        let jsonData  =  try? JSONEncoder().encode(trackingObject)
        let request  =  Request(endpoint: .orders, pathComponents: ["items", orderId])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .PUT)
            .set(body: jsonData)
            .build()
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
        }
    }
}


extension Service{
    public func getLikedProducts<T:Codable>( expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {

        let request = Request(endpoint: .user, pathComponents: ["likes"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .GET)
            .build()

        Service.shared.execute(request, expecting: T.self) {  result in
            completion(result)
        }
    }
    
    public func likeProduct<T:Codable>(productId: String, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {

        let request = Request(endpoint: .user, pathComponents: [ "like", productId])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .PUT)
            .build()

        Service.shared.execute(request, expecting: T.self) { result in
            completion(result)
        }
    }
    
    public func unlikeProduct<T:Codable>( productId: String, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {

        let request = Request(endpoint: .user, pathComponents: [ "unlike", productId])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .PUT)
            .build()

        Service.shared.execute(request, expecting: T.self) { result in
            completion(result)
        }
    }
    
    
}



//Sellers Products

extension Service{
    public func getSellerProducts<T:Codable>( expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {

        let request = Request(endpoint: .seller, pathComponents: ["products"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .GET)
            .build()

        Service.shared.execute(request, expecting: T.self) {  result in
            completion(result)
        }
    }
    
    
    
    
    public func deleteSellerProducts<T:Codable>(with productId : String , expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {

        let request = Request(endpoint: .seller, pathComponents: ["products", "delete",  productId])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .PUT)
            .build()

        Service.shared.execute(request, expecting: T.self) {  result in
            completion(result)
        }
    }
    
    
    public func updateProduct<T:Codable>( to productId : String, with  product : ProductListing ,  newImagesToUpload: [String], deletedUrls : [String] ,expecting type : T.Type,  completion : @escaping (Result <T, Error>) -> Void){
        
        
        // Encode product to JSON
           let productData = try? JSONEncoder().encode(product)
//
//            let deletedUrlsData   = try? JSONEncoder().encode(deletedUrls)
           // Create a dictionary to combine new images array and product JSON object
           let combinedData: [String: Any] = [
               "newImages": newImagesToUpload,
               "delete_urls" :deletedUrls,
               "product": try! JSONSerialization.jsonObject(with: productData!, options: [])
           ]
           
           // Convert combined data to JSON
           let jsonData = try? JSONSerialization.data(withJSONObject: combinedData, options: [])
           
        let request  =  Request(endpoint: .seller, pathComponents: [ "products", productId])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .PUT)
            .set(body: jsonData)
            .build()
        
        Service.shared.execute(request, expecting: T.self) { [weak self] result in
            guard let _ = self else { return }
            
            completion(result)
            
            
        }
    }
    
    
    
    
    
    
    
}



//Shop

extension Service{
    
    public func getShop<T:Codable>( expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {

        let request = Request(endpoint: .shop, pathComponents: [])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .GET)
            .build()

        Service.shared.execute(request, expecting: T.self) {  result in
            completion(result)
        }
    }
    public func getShopProducts<T:Codable>(with sellerId : String, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let body = ["seller_id" : sellerId]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        let request = Request(endpoint: .shop, pathComponents: ["products"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(body: jsonData)
            .set(method: .POST)
           
            .build()
        
        Service.shared.execute(request, expecting: T.self) {  result in
            completion(result)
        }
    }
    
    
    public func getShopNUmberOrders<T:Codable>(with sellerId : String, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
//        let body = ["seller_id" : sellerId]
//        let jsonData = try? JSONSerialization.data(withJSONObject: body)
//
        let request = Request(endpoint: .shop, pathComponents: ["orders", "count", sellerId ])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .GET)
           
            .build()
        
        Service.shared.execute(request, expecting: T.self) {  result in
            completion(result)
        }
    }
    
    
    public func followShop<T:Codable>(with shopId : String, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
//        let body = ["seller_id" : sellerId]
//        let jsonData = try? JSONSerialization.data(withJSONObject: body)
//
        let request = Request(endpoint: .shop, pathComponents: ["follow",  shopId ])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .POST)
           
            .build()
        
        Service.shared.execute(request, expecting: T.self) {  result in
            completion(result)
        }
    }
    
    public func unfollowShop<T:Codable>(with shopId : String, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
//        let body = ["seller_id" : sellerId]
//        let jsonData = try? JSONSerialization.data(withJSONObject: body)
//
        let request = Request(endpoint: .shop, pathComponents: ["unfollow",  shopId ])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .POST)
           
            .build()
        
        Service.shared.execute(request, expecting: T.self) {  result in
            completion(result)
        }
    }
    
    
    
    
    
    public func updateShop<T:Codable>(with shopData : Shop,  expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        let shopData = try? JSONEncoder().encode(shopData)
        let request = Request(endpoint: .shop, pathComponents: [])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .PUT)
            .set(body: shopData)
            .build()

        Service.shared.execute(request, expecting: T.self) {  result in
            completion(result)
        }
    }
    
    
    public func deactivateShop<T:Codable>(  expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
//        let shopData = try? JSONEncoder().encode(shopData)
        let request = Request(endpoint: .shop, pathComponents: [])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .PUT)
//            .set(body: shopData)
            .build()

        Service.shared.execute(request, expecting: T.self) {  result in
            completion(result)
        }
    }
    
    
    public func checkShopPriviligies<T:Codable>(with shopId : String, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
//        let body = ["seller_id" : sellerId]
//        let jsonData = try? JSONSerialization.data(withJSONObject: body)
//
        let request = Request(endpoint: .shop, pathComponents: ["check", shopId ])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .GET)
            .build()
        
        Service.shared.execute(request, expecting: T.self) {  result in
            completion(result)
        }
    }
    
    public func getShopOfSeller<T:Codable>( expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
//        let body = ["seller_id" : sellerId]
//        let jsonData = try? JSONSerialization.data(withJSONObject: body)
//
        let request = Request(endpoint: .shop, pathComponents: [ ])
            .add(headerField: "Content-Type", value: "application/json")
            .set(method: .GET)
            .build()
        
        Service.shared.execute(request, expecting: T.self) {  result in
            completion(result)
        }
    }
    
    
    
  
    
    
    
}
