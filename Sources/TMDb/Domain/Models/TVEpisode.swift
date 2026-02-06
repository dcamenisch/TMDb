//
//  TVEpisode.swift
//  TMDb
//
//  Copyright © 2026 Adam Young.
//

import Foundation

///
/// A model representing a TV episode.
///
public struct TVEpisode: Identifiable, Codable, Equatable, Hashable, Sendable {

    ///
    /// TV episode identifier.
    ///
    public let id: Int

    ///
    /// TV episode name.
    ///
    public let name: String

    ///
    /// TV episode number.
    ///
    public let episodeNumber: Int

    ///
    /// TV episode season number.
    ///
    public let seasonNumber: Int

    ///
    /// TV episode overview.
    ///
    public let overview: String?

    ///
    /// TV episode air date.
    ///
    public let airDate: Date?

    ///
    /// TV episode runtime.
    ///
    public let runtime: Int?

    ///
    /// TV episode production code.
    ///
    public let productionCode: String?

    ///
    /// TV episode still image path.
    ///
    /// To generate a full URL see <doc:/TMDb/GeneratingImageURLs>.
    ///
    public let stillPath: URL?

    ///
    /// TV episode crew.
    ///
    public let crew: [CrewMember]?

    ///
    /// TV episode guest cast members.
    ///
    public let guestStars: [CastMember]?

    ///
    /// Average vote score.
    ///
    public let voteAverage: Double?

    ///
    /// Number of votes.
    ///
    public let voteCount: Int?

    ///
    /// Creates a TV episode object.
    ///
    /// - Parameters:
    ///    - id: TV episode identifier.
    ///    - name: TV episode name.
    ///    - episodeNumber: TV episode number.
    ///    - seasonNumber: TV episode season number.
    ///    - overview: TV episode overview.
    ///    - airDate: TV episode air date.
    ///    - runtime: TV episode runtime.
    ///    - productionCode: TV episode production code.
    ///    - stillPath: TV episode still image path.
    ///    - crew: TV episode crew.
    ///    - guestStars: TV episode guest cast members.
    ///    - voteAverage: Average vote score.
    ///    - voteCount: Number of votes.
    ///
    public init(
        id: Int,
        name: String,
        episodeNumber: Int,
        seasonNumber: Int,
        overview: String? = nil,
        airDate: Date? = nil,
        runtime: Int? = nil,
        productionCode: String? = nil,
        stillPath: URL? = nil,
        crew: [CrewMember]? = nil,
        guestStars: [CastMember]? = nil,
        voteAverage: Double? = nil,
        voteCount: Int? = nil
    ) {
        self.id = id
        self.name = name
        self.episodeNumber = episodeNumber
        self.seasonNumber = seasonNumber
        self.overview = overview
        self.airDate = airDate
        self.runtime = runtime
        self.productionCode = productionCode
        self.stillPath = stillPath
        self.crew = crew
        self.guestStars = guestStars
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }

}

extension TVEpisode {

    // Custom decoder to handle invalid cast/crew entries
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.episodeNumber = try container.decode(Int.self, forKey: .episodeNumber)
        self.seasonNumber = try container.decode(Int.self, forKey: .seasonNumber)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.airDate = try container.decodeIfPresent(Date.self, forKey: .airDate)
        self.runtime = try container.decodeIfPresent(Int.self, forKey: .runtime)
        self.productionCode = try container.decodeIfPresent(String.self, forKey: .productionCode)
        self.stillPath = try container.decodeIfPresent(URL.self, forKey: .stillPath)

        // Decode crew and skip invalid entries
        self.crew = try? container.decodeIfPresent([CrewMember].self, forKey: .crew)

        // Decode guest stars and skip invalid entries
        self.guestStars = try? container.decodeIfPresent([CastMember].self, forKey: .guestStars)

        self.voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
        self.voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
    }

}
