//
//  YoutubeSearchResponse.swift
//  Netflix Clone
//
//  Created by BS1096 on 16/6/23.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
    
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
 }

