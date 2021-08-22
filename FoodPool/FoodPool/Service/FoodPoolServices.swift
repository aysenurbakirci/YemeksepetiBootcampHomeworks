//
//  FoodPoolServices.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 17.08.2021.
//
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

protocol FoodPoolRestaurantServiceProtocol {
    func fetchRestaurants(response: @escaping (Result<RestaurantModel, Error>) -> Void)
    func fetchCuisines(response: @escaping (Result<CuisineModel, Error>) -> Void)
    func fetchDiscounts(response: @escaping (Result<DiscountModel, Error>) -> Void)
}

protocol FoodPoolUsersServiceProtocol {
    func fetchUserInfo(response: @escaping (Result<UserModel, Error>) -> Void)
}

protocol FoodPoolOrdersServiceProtocol {
    func fetchOrders(response: @escaping (Result<OrderModel, Error>) -> Void)
}

protocol FoodPoolPaymentMethodsServiceProtocol {
    func fetchPaymentMethods(response: @escaping (Result<PaymentMethodModel, Error>) -> Void)
}

protocol FoodPoolCreateOrderServiceProtocol {
    func createOrder(mealList: [String], price: String, state: String, nameRestaurant: String, userID: String, paymentMethod: String, completion: @escaping (Bool?) -> Void)
}

protocol FoodPoolCreateAddressServiceProtocol {
    func createAddress(addressTitle: String, address: String, province: String, document: String, completion: @escaping (Bool?) -> Void)
}

protocol FoodPoolCreateUserServiceProtocol {
    func signUp(userEmail: String, userPassword: String, userName: String, userPhone: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

protocol FoodPoolSignInServiceProtocol{
    func signIn(userEmail: String, userPassword: String, completion: @escaping (Result<String, Error>) -> Void)
    func forgatPassword(userEmail: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

struct FoodPoolServices: FoodPoolRestaurantServiceProtocol {
    
    private let firestore = Firestore.firestore()
    
    func fetchCuisines(response: @escaping (Result<CuisineModel, Error>) -> Void) {
        
        firestore.collection("Cuisines").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    do {
                        try response(.success(document.data(as: CuisineModel.self)!))
                    }
                    catch {
                        response(.failure(error))
                    }
                }
            }
        }
    }
    
    func fetchRestaurants(response: @escaping (Result<RestaurantModel, Error>) -> Void) {
        
        firestore.collection("Restaurants").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    do {
                        try response(.success(document.data(as: RestaurantModel.self)!))
                    }
                    catch {
                        response(.failure(error))
                    }
                }
            }
        }
    }
    
    func fetchDiscounts(response: @escaping (Result<DiscountModel, Error>) -> Void) {
        firestore.collection("Discounts").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    do {
                        try response(.success(document.data(as: DiscountModel.self)!))
                    } catch {
                        response(.failure(error))
                    }
                }
            }
        }
    }
}

extension FoodPoolServices: FoodPoolUsersServiceProtocol {
    
    func fetchUserInfo(response: @escaping (Result<UserModel, Error>) -> Void) {
        
        firestore.collection("Users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    do {
                        try response(.success(document.data(as: UserModel.self)!))
                    }
                    catch {
                        response(.failure(error))
                    }
                }
            }
        }
    }
}

extension FoodPoolServices: FoodPoolOrdersServiceProtocol {
    
    func fetchOrders(response: @escaping (Result<OrderModel, Error>) -> Void) {
        
        firestore.collection("Orders").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    do {
                        try response(.success(document.data(as: OrderModel.self)!))
                    }
                    catch {
                        response(.failure(error))
                      print(error)
                    }
                }
            }
        }
    }

}

extension FoodPoolServices: FoodPoolCreateUserServiceProtocol {
    
    func signUp(userEmail: String, userPassword: String, userName: String, userPhone: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: userEmail, password: userPassword, completion: { (result, error) in
            if error != nil {
                completion(.failure(error!))
                print("Error getting documents: \(String(describing: error))")
            } else {
                firestore.collection("Users").addDocument(data: ["userEmail" : userEmail, "userName" : userName, "userPhone" : userPhone, "uid" : result!.user.uid, "userAddresses" : [] ]) { error in
                    if error != nil {
                        completion(.failure(error!))
                        print("Error save user: \(String(describing: error))")
                    } else {
                        completion(.success(true))
                    }
                }
            }
        })
    }

}

extension FoodPoolServices: FoodPoolSignInServiceProtocol {
    
    func signIn(userEmail: String, userPassword: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().signIn(withEmail: userEmail, password: userPassword, completion: { (result, error) in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            if error != nil {
                completion(.success((result.user.uid)))
            } else {
                completion(.failure(error!))
            }
        })
    }
    
    func forgatPassword(userEmail: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: userEmail) { error in
            if error != nil {
                completion(.failure(error!))
                print("Error save user: \(String(describing: error))")
            } else {
                completion(.success(true))
            }
        }
    }
}

extension FoodPoolServices: FoodPoolCreateOrderServiceProtocol {
    
    func createOrder(mealList: [String], price: String, state: String, nameRestaurant: String, userID: String, paymentMethod: String, completion: @escaping (Bool?) -> Void) {
        
        firestore.collection("Orders").addDocument(data: ["mealList" : mealList, "price" : price, "state" : state, "restaurantName" : nameRestaurant, "userID" : userID, "paymentMethod" : paymentMethod]) { error in
            if error != nil {
                completion(false)
                print("Error save user: \(String(describing: error))")
            } else {
                completion(true)
            }
        }
    }
}

extension FoodPoolServices: FoodPoolCreateAddressServiceProtocol {
    func createAddress(addressTitle: String, address: String, province: String, document: String, completion: @escaping (Bool?) -> Void) {
        
        let array = ["address" : address, "addressTitle" : addressTitle, "province" : province]

        firestore.collection("Users").document(document).updateData(["userAddresses" : FieldValue.arrayUnion([array])]) { error in
            if error != nil {
                completion(false)
                print("Error save user: \(String(describing: error))")
            } else {
                completion(true)
            }
        }
    }
}

extension FoodPoolServices: FoodPoolPaymentMethodsServiceProtocol {
    
    func fetchPaymentMethods(response: @escaping (Result<PaymentMethodModel, Error>) -> Void) {
        firestore.collection("PaymentMethods").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    do {
                        try response(.success(document.data(as: PaymentMethodModel.self)!))
                    }
                    catch {
                        response(.failure(error))
                    }
                }
            }
        }
    }
}
