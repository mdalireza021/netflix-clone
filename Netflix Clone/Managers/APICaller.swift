//
//  APICaller.swift
//  Netflix Clone
//
//  Created by BS1096 on 8/6/23.
//

import Foundation

struct Constants {
    static let API_KEY = "6b5fe8a371b3a38678e65e223064c660";
    static let baseURL = "https://api.themoviedb.org";
    
    
}

enum APIError: Error {
    case failedTogetData
}
class APICaller {
    
    static let shared = APICaller();
    
    
    ///Tranding Movies
    
    func getTrandingMovies(completion:  @escaping ( Result<[Title], Error>) -> Void ) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                print(error.localizedDescription)
            }
            
        }
        task.resume();
        
    }
    
    ///Tranding Tv s
    
    func getTrandingTvs(completion:  @escaping ( Result<[Title], Error>) -> Void ) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                print(error.localizedDescription)
            }
            
        }
        task.resume();
        
    }
    
    
    /// Popular
    
    func getPopular(completion:  @escaping ( Result<[Title], Error>) -> Void ) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                print(error.localizedDescription)
            }
            
        }
        task.resume();
        
    }
    
    
    /// Upcoming movies
    
    func getUpcomingMovies( completion:  @escaping ( Result<[Title], Error>) -> Void ) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                print(error.localizedDescription)
            }
            
        }
        task.resume();
        
    }
    
    
    
    /// Top rated movies
    
    func getTopRatedMovies(completion:  @escaping ( Result<[Title], Error>) -> Void ) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                print(error.localizedDescription)
            }
            
        }
        task.resume();
        
    }
  
}
