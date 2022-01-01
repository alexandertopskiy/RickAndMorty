//
//  Created by Alexander Loshakov on 26.11.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import Foundation

struct Character: Codable, Equatable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: CharacterSpecies
    let type: CharacterType
    let gender: CharacterGender
    let origin: CharacterLocation
    let location: CharacterLocation
    let image: String
    let episodeURLs: [URL]
    let url: String
    let created: String
    var originLocation: [Location] = []
    var episodes: [Episode] = []

    var episodesIDs: [Int] {
        return episodeURLs.compactMap { Int($0.lastPathComponent) }
    }

    init() {
        id = 0
        name = ""
        status = .unknown
        species = .unknown
        type = .unknown
        gender = .unknown
        origin = CharacterLocation()
        location = CharacterLocation()
        image = ""
        episodeURLs = []
        url = ""
        created = ""
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case type
        case gender
        case origin
        case location
        case image
        case episodeURLs = "episode"
        case url
        case created
    }

    enum CharacterStatus: String, Codable, Equatable, CaseIterable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }

    enum CharacterSpecies: String, Codable, Equatable, CaseIterable {
        case alien = "Alien"
        case animal = "Animal"
        case cronenberg = "Cronenberg"
        case disease = "Disease"
        case human = "Human"
        case humanoid = "Humanoid"
        case mythCreature = "Mythological Creature"
        case poopybutthole = "Poopybutthole"
        case robot = "Robot"
        case unknown = "unknown"

        public init(from decoder: Decoder) throws {
            self = try CharacterSpecies(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
        }
    }

    enum CharacterGender: String, Codable, Equatable, CaseIterable {
        case male = "Male"
        case female = "Female"
        case genderless = "Genderless"
        case unknown = "unknown"
    }

    enum CharacterType: String, Codable, Equatable, CaseIterable {
        case alligator = "Alligator-Person"
        case alphabetrian = "Alphabetrian"
        case amoeba = "Amoeba-Person"
        case animal = "Animal"
        case anime = "Anime"
        case artIntelligence = "Artificial Intelligence"
        case bepisian = "Bepisian"
        case birdPerson = "Bird-Person"
        case birdPersonHumanMix = "Bird-Person Human Mix"
        case blueApeAlien = "Blue ape alien"
        case boobieBuyer = "Boobie buyer reptilian"
        case boobloosian = "Boobloosian"
        case bread = "Bread"
        case chud = "CHUD"
        case chudHumanMix = "CHUD Human Mix"
        case cat = "Cat"
        case catControlled = "Cat controlled dead lady"
        case catPerson = "Cat-Person"
        case caterpillar = "Caterpillar"
        case centaur = "Centaur"
        case chair = "Chair"
        case changeformer = "Changeformer"
        case clayPerson = "Clay-Person"
        case clone = "Clone"
        case coneNippledAlien = "Cone-nippled alien"
        case conjoinedTwin = "Conjoined twin"
        case cookie = "Cookie"
        case cornPerson = "Corn-person"
        case cromulon = "Cromulon"
        case cronenberg = "Cronenberg"
        case crow = "Crow"
        case crowHorse = "Crow Horse"
        case cyborg = "Cyborg"
        case decoy = "Decoy"
        case demon = "Demon"
        case dog = "Dog"
        case doopidoo = "Doopidoo"
        case dragon = "Dragon"
        case drumbloxian = "Drumbloxian"
        case dummy = "Dummy"
        case eatShiterPerson = "Eat shiter-Person"
        case eel = "Eel"
        case elephantPerson = "Elephant-Person"
        case ferkusian = "Ferkusian"
        case ferretRobot = "Ferret Robot"
        case fishPerson = "Fish-Person"
        case flansian = "Flansian"
        case floopFloopian = "Floop Floopian"
        case fly = "Fly"
        case game = "Game"
        case garblovian = "Garblovian"
        case gazorpian = "Gazorpian"
        case gazorpianRobot = "Gazorpian reproduction robot"
        case gearPerson = "Gear-Person"
        case genExperiment = "Genetic experiment"
        case giant = "Giant"
        case giantCatMonster = "Giant Cat Monster"
        case giantIncestBaby = "Giant Incest Baby"
        case glorzo = "Glorzo"
        case god = "God"
        case goddess = "Goddess"
        case gramuflackian = "Gramuflackian"
        case grandma = "Grandma"
        case greebybobe = "Greebybobe"
        case gromflomite = "Gromflomite"
        case guineaPig = "Guinea Pig for the Polio Vaccine"
        case hairyAlien = "Hairy alien"
        case halfSoullessPuppet = "Half Soulless Puppet"
        case hammerheadPerson = "Hammerhead-Person"
        case hivemind = "Hivemind"
        case hole = "Hole"
        case hologram = "Hologram"
        case humanGazorpian = "Human Gazorpian"
        case humanWithFlower = "Human with a flower in his head"
        case humanWithAntennae = "Human with antennae"
        case humanWithAnts = "Human with ants in his eyes"
        case humanWithBabyLegs = "Human with baby legs"
        case humanWithGiantHead = "Human with giant head"
        case humanWithTusks = "Human with tusks"
        case humanSnakeHybrid = "Human-Snake hybrid"
        case gaseousBeing = "Interdimensional gaseous being"
        case jellybean = "Jellybean"
        case korblock = "Korblock"
        case krootabulan = "Krootabulan"
        case larvaAlien = "Larva alien"
        case leprechaun = "Leprechaun"
        case lightBulbAlien = "Light bulb-Alien"
        case littleHuman = "Little Human"
        case lizard = "Lizard"
        case lizardPerson = "Lizard-Person"
        case lobsterAlien = "Lobster-Alien"
        case mannie = "Mannie"
        case mascot = "Mascot"
        case meeseeks = "Meeseeks"
        case megaGargantuan = "Mega Gargantuan"
        case memory = "Memory"
        case mexican = "Mexican"
        case microverse = "Microverse inhabitant"
        case miniverse = "Miniverse inhabitant"
        case monogatron = "Monogatron"
        case monster = "Monster"
        case morglutzian = "Morglutzian"
        case mortysToxicSide = "Morty's toxic side"
        case mytholog = "Mytholog"
        case nanoAlien = "Nano Alien"
        case narnian = "Narnian"
        case necrophiliac = "Necrophiliac"
        case normalSizeBug = "Normal Size Bug"
        case numbericon = "Numbericon"
        case octopusPerson = "Octopus-Person"
        case oldAmazons = "Old Amazons"
        case omniscientBeing = "Omniscient being"
        case organicGun = "Organic gun"
        case parasite = "Parasite"
        case passingButterRobot = "Passing Butter Robot"
        case phone = "Phone"
        case phonePerson = "Phone-Person"
        case pickle = "Pickle"
        case pizza = "Pizza"
        case planet = "Planet"
        case plutonian = "Plutonian"
        case pripudlian = "Pripudlian"
        case rat = "Rat"
        case ricksToxicSide = "Rick's toxic side"
        case ringNippledAlien = "Ring-nippled alien"
        case robot = "Robot"
        case robotCrocodile = "Robot-Crocodile hybrid"
        case scarecrow = "Scarecrow"
        case scrotian = "Scrotian"
        case selfAwareArm = "Self-aware arm"
        case sentientAntColony = "Sentient ant colony"
        case sexyAquaman = "Sexy Aquaman"
        case shapeshifter = "Shapeshifter"
        case shimshamian = "Shimshamian"
        case shrimp = "Shrimp"
        case slartivartian = "Slartivartian"
        case slug = "Slug"
        case snailAlien = "Snail alien"
        case snake = "Snake"
        case soullessPuppet = "Soulless Puppet"
        case squid = "Squid"
        case stairGoblin = "Stair goblin"
        case starfish = "Starfish"
        case summon = "Summon"
        case spermMonster = "Super Sperm Monster"
        case superhuman = "Superhuman"
        case superhumanGhost = "Superhuman (Ghost trains summoner)"
        case teddyBear = "Teddy Bear"
        case teenInhabitant = "Teenyverse inhabitant"
        case tentacleAlien = "Tentacle alien"
        case theDevil = "The Devil"
        case tiger = "Tiger"
        case timeGod = "Time God"
        case tinymouth = "Tinymouth"
        case toy = "Toy"
        case traflorkian = "Traflorkian"
        case trunkPerson = "Trunk-Person"
        case tumblorkian = "Tumblorkian"
        case turkey = "Turkey"
        case turkeyHumanMix = "Turkey Human Mix"
        case tuskfish = "Tuskfish"
        case unknownNippledAlien = "Unknown-nippled alien"
        case vampire = "Vampire"
        case wasp = "Wasp"
        case weasel = "Weasel"
        case whenwolf = "Whenwolf"
        case zeus = "Zeus"
        case zigerion = "Zigerion"
        case zombodian = "Zombodian"
        case noType = ""
        case unknown = "unknown"

        public init(from decoder: Decoder) throws {
            self = try CharacterType(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
        }
    }
}

struct CharacterLocation: Codable, Equatable {
    let name: String
    let locationURL: URL?

    var originID: [Int] {
        guard let id = Int(locationURL?.lastPathComponent ?? "") else {
            return []
        }
        return [id]
    }

    enum CodingKeys: String, CodingKey {
        case name
        case locationURL = "url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        locationURL = try? container.decodeIfPresent(URL.self, forKey: .locationURL)
    }

    init() {
        name = ""
        locationURL = nil
    }
}
