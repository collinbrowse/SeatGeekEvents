//
//  FetchError.swift
//  FetchRewardsCodingExercise
//
//  Created by Collin Browse on 1/7/21.
//

import Foundation

enum FetchError: String, Error {
    
    case unableToComplete = "Unable to complete your request"
    case invalidURL = "The URL for the request is invalid"
    case invalidResponse = "Invalid Response from the server"
    case invalidData = "The data from the server was invalid"
    case unableToFavorite = "There was an error adding the user to favorites"
    case alreadyInFavorites = "This user is already a favorite"
    
}
