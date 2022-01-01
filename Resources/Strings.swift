// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Characters {
    /// Characters
    internal static let title = L10n.tr("Localizable", "characters.title")
  }

  internal enum Details {
    internal enum Character {
      /// Origin
      internal static let origin = L10n.tr("Localizable", "details.character.origin")
      /// Episodes
      internal static let scrollTitle = L10n.tr("Localizable", "details.character.scroll_title")
    }
    internal enum Episode {
      /// Characters
      internal static let scrollTitle = L10n.tr("Localizable", "details.episode.scroll_title")
    }
    internal enum Info {
      /// Air Date:
      internal static let airDate = L10n.tr("Localizable", "details.info.air_date")
      /// Dimension:
      internal static let dimension = L10n.tr("Localizable", "details.info.dimension")
      /// Episode:
      internal static let episode = L10n.tr("Localizable", "details.info.episode")
      /// Gender:
      internal static let gender = L10n.tr("Localizable", "details.info.gender")
      /// None
      internal static let `none` = L10n.tr("Localizable", "details.info.none")
      /// Season:
      internal static let season = L10n.tr("Localizable", "details.info.season")
      /// Species:
      internal static let species = L10n.tr("Localizable", "details.info.species")
      /// Info
      internal static let title = L10n.tr("Localizable", "details.info.title")
      /// Type:
      internal static let type = L10n.tr("Localizable", "details.info.type")
    }
    internal enum Location {
      /// Residents
      internal static let scrollTitle = L10n.tr("Localizable", "details.location.scroll_title")
    }
  }

  internal enum Episodes {
    /// Episodes
    internal static let title = L10n.tr("Localizable", "episodes.title")
    internal enum SeasonCode {
      /// Episode
      internal static let episode = L10n.tr("Localizable", "episodes.seasonCode.episode")
      /// Season
      internal static let season = L10n.tr("Localizable", "episodes.seasonCode.season")
      /// Unknown episode code
      internal static let unknown = L10n.tr("Localizable", "episodes.seasonCode.unknown")
    }
  }

  internal enum Filters {
    /// All
    internal static let all = L10n.tr("Localizable", "filters.all")
    /// Filters
    internal static let title = L10n.tr("Localizable", "filters.title")
    internal enum Action {
      /// Apply
      internal static let apply = L10n.tr("Localizable", "filters.action.apply")
      /// Reset all
      internal static let resetAll = L10n.tr("Localizable", "filters.action.reset_all")
    }
    internal enum Characters {
      /// Gender
      internal static let gender = L10n.tr("Localizable", "filters.characters.gender")
      /// Species
      internal static let species = L10n.tr("Localizable", "filters.characters.species")
      /// Status
      internal static let status = L10n.tr("Localizable", "filters.characters.status")
      /// Type
      internal static let type = L10n.tr("Localizable", "filters.characters.type")
    }
    internal enum Locations {
      /// Dimension
      internal static let dimension = L10n.tr("Localizable", "filters.locations.dimension")
      /// Type
      internal static let type = L10n.tr("Localizable", "filters.locations.type")
    }
  }

  internal enum Locations {
    /// Locations
    internal static let title = L10n.tr("Localizable", "locations.title")
  }

  internal enum Log {
    /// Error! Please, check your internet connection!
    internal static let error = L10n.tr("Localizable", "log.error")
    /// Not found
    internal static let notFound = L10n.tr("Localizable", "log.notFound")
  }

  internal enum Placeholder {
    /// Search
    internal static let search = L10n.tr("Localizable", "placeholder.search")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
