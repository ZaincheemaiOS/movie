//
//  Movies.swift
//  Movie App
//
//  Created by Zain Cheema on 10/7/22.
//

import Foundation
import UIKit


struct Movies: Decodable{
    
    let Title: String
    let Year: String
    let Genre: String
    let Plot: String
    let Poster: String
}
