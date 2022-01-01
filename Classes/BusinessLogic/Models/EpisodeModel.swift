//
//  Created by Alexander Loshakov on 02.12.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import Foundation

struct Episode: Codable, Equatable {
    let id: Int
    let name: String
    let date: String
    let episodeCode: String
    let characterURLs: [URL]
    let url: String
    let created: String
    var characters: [Character] = []

    var convertedEpisodeCode: (episodeNumber: Int, seasonNumber: Int)? {
        guard let indexOfSeasonCode = episodeCode.firstIndex(of: "S"),
              let indexOfEpisodeCode = episodeCode.firstIndex(of: "E") else {
                  return nil
              }
        let seasonCodeRange = episodeCode.index(indexOfSeasonCode, offsetBy: 1)..<indexOfEpisodeCode
        let episodeCodeRange = episodeCode.index(indexOfEpisodeCode, offsetBy: 1)...
        guard let seasonNumber = Int(episodeCode[seasonCodeRange]),
              let episodeNumber = Int(episodeCode[episodeCodeRange]) else {
                  return nil
              }
        return (episodeNumber, seasonNumber)
    }

    var charactersIDs: [Int] {
        return characterURLs.compactMap { Int($0.lastPathComponent) }
    }

    init() {
        id = 1
        name = ""
        date = ""
        episodeCode = ""
        characterURLs = []
        url = ""
        created = ""
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case characterURLs = "characters"
        case url
        case created
        case date = "air_date"
        case episodeCode = "episode"
    }
}
