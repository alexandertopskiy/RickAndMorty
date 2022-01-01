//
//  Created by Nikita Gavrikov on 28.11.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import Foundation
import UIKit

struct Location: Codable, Equatable {
    let id: Int
    let name: String
    let type: LocationType
    let dimension: LocationDimension
    let residentURLs: [URL]
    let url: String
    let created: String
    var residents: [Character] = []

    var residentsIDs: [Int] {
        return residentURLs.compactMap { Int($0.lastPathComponent) }
    }

    init() {
        id = 0
        name = ""
        type = .unknown
        dimension = .unknown
        residentURLs = []
        url = ""
        created = ""
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case dimension
        case residentURLs = "residents"
        case url
        case created
    }

    enum LocationType: String, Codable, Equatable, CaseIterable {
        case acidPlant = "Acid Plant"
        case arcade = "Arcade"
        case artGenWorld = "Artificially generated world"
        case asteroid = "Asteroid"
        case base = "Base"
        case box = "Box"
        case cluster = "Cluster"
        case consciousness = "Consciousness"
        case convention = "Convention"
        case country = "Country"
        case customs = "Customs"
        case daycare = "Daycare"
        case deathStar = "Death Star"
        case diegesis = "Diegesis"
        case dimension = "Dimension"
        case dream = "Dream"
        case dwarfPlanet = "Dwarf planet (Celestial Dwarf)"
        case elementalRings = "Elemental Rings"
        case fantasyTown = "Fantasy town"
        case game = "Game"
        case hell = "Hell"
        case human = "Human"
        case liquid = "Liquid"
        case machine = "Machine"
        case memory = "Memory"
        case menagerie = "Menagerie"
        case microverse = "Microverse"
        case miniverse = "Miniverse"
        case mount = "Mount"
        case nightmare = "Nightmare"
        case nonDiegeticAltReality = "Non-Diegetic Alternative Reality"
        case planet = "Planet"
        case policeDepartment = "Police Department"
        case quadrant = "Quadrant"
        case quasar = "Quasar"
        case reality = "Reality"
        case resort = "Resort"
        case spa = "Spa"
        case space = "Space"
        case spaceStation = "Space station"
        case spacecraft = "Spacecraft"
        case tvType = "TV"
        case teenyverse = "Teenyverse"
        case woods = "Woods"
        case noType = ""
        case unknown = "unknown"

        public init(from decoder: Decoder) throws {
            self = try LocationType(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
        }

        var icon: UIImage {
            switch self {
            case .planet:
                return Asset.Icons.icPlanet.image
            case .cluster:
                return Asset.Icons.icCluster.image
            case .spaceStation:
                return Asset.Icons.icSpaceStation.image
            case .microverse:
                return Asset.Icons.icMicroverse.image
            case .tvType:
                return Asset.Icons.icTV.image
            case .resort:
                return Asset.Icons.icResort.image
            case .fantasyTown:
                return Asset.Icons.icFantasyTown.image
            case .dream:
                return Asset.Icons.icDream.image
            default:
                return Asset.Icons.icStar.image
            }
        }
    }

    enum LocationDimension: String, Codable, Equatable, CaseIterable {
        case chair = "Chair Dimension"
        case cromulon = "Cromulon Dimension"
        case cronenberg = "Cronenberg Dimension"
        case d5126 = "Dimension 5-126"
        case c137 = "Dimension C-137"
        case c35 = "Dimension C-35"
        case c500a = "Dimension C-500A"
        case d99 = "Dimension D-99"
        case d716 = "Dimension D716"
        case d716b = "Dimension D716-B"
        case d716c = "Dimension D716-C"
        case j22 = "Dimension J-22"
        case j19 = "Dimension J19ζ7"
        case k22 = "Dimension K-22"
        case k83 = "Dimension K-83"
        case stoltzMask = "Eric Stoltz Mask Dimension"
        case ricksTarget = "Evil Rick's Target Dimension"
        case fantasy = "Fantasy Dimension"
        case fascist = "Fascist Dimension"
        case shrimp = "Fascist Shrimp Dimension"
        case teddyBear = "Fascist Teddy Bear Dimension"
        case spiders = "Giant Telepathic Spiders Dimension"
        case magic = "Magic Dimension"
        case merged = "Merged Dimension"
        case phone = "Phone Dimension"
        case pizza = "Pizza Dimension"
        case postApocalyptic = "Post-Apocalyptic Dimension"
        case replacement = "Replacement Dimension"
        case testicleMonster = "Testicle Monster Dimension"
        case tusk = "Tusk Dimension"
        case wasp = "Wasp Dimension"
        case noDimension = ""
        case unknown = "unknown"

        public init(from decoder: Decoder) throws {
            self = try LocationDimension(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
        }
    }
}
