//
//  NetworkService.swift
//  FoodOrderingApp
//
//  Created by Huseyn Valiyev on 21.08.2021.
//

import Foundation

struct NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func getPopularMeal(completion: @escaping(Result<MealsRoot, Error>) -> Void) {
        request(route: .getPopularMeals, method: .get, completion: completion)
    }
    
    func getChefsMels(completion: @escaping(Result<MealsRoot, Error>) -> Void) {
        request(route: .getChefsMeals, method: .get, completion: completion)
    }
    
    func getCategories(completion: @escaping(Result<CategoriesRoot, Error>) -> Void) {
        request(route: .getCategories, method: .get, completion: completion)
    }
    
    func getMealsByCategory(category: String, completion: @escaping(Result<MealsRoot, Error>) -> Void) {
        let params = ["c": category] as [String : Any]
        request(route: .getCategoryMeals, method: .get, parameters: params, completion: completion)
    }
    
    func getMealById(id: String, completion: @escaping(Result<MealsRoot, Error>) -> Void) {
        let params = ["i": id] as [String : Any]
        request(route: .getMealById, method: .get, parameters: params, completion: completion)
    }
    
    private func request<T: Decodable>(route: Route, method: Methods, parameters: [String: Any]? = nil, completion: @escaping(Result<T, Error>) -> Void) {
        
        guard let request = createRequest(route: route, method: method, parameters: parameters) else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            var result: Result<Data, Error>?
            if let data = data {
                result = .success(data)
            } else if let error = error {
                result = .failure(error)
                print("The error is: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.handleResponse(result: result, completion: completion)
            }
            
        }.resume()
        
    }
    
    private func handleResponse<T: Decodable>(result: Result<Data, Error>?, completion: (Result<T, Error>) -> Void) {
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(T.self, from: data) else {
                completion(.failure(AppError.errorDecoding))
                return
            }
            completion(.success(response))
        case .failure(let error):
            completion(.failure(error))
        }
        
    }
    
    private func createRequest(route: Route, method: Methods, parameters: [String: Any]? = nil) -> URLRequest? {
        let urlString = Route.baseURL + route.description
        guard let url = URL(string: urlString) else { return nil}
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        if let params = parameters {
            switch method {
            case .get:
                var urlComponnet = URLComponents(string: urlString)
                urlComponnet?.queryItems = params.map {URLQueryItem(name: $0, value: "\($1)")}
                urlRequest.url = urlComponnet?.url
            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        return urlRequest
    }
    
}
