//
//  TMDbTVSeasonServiceTests.swift
//  TMDb
//
//  Copyright © 2024 Adam Young.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an AS IS BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

@testable import TMDb
import XCTest

final class TMDbTVSeasonServiceTests: XCTestCase {

    var service: TMDbTVSeasonService!
    var apiClient: MockAPIClient!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        service = TMDbTVSeasonService(apiClient: apiClient)
    }

    override func tearDown() {
        apiClient = nil
        service = nil
        super.tearDown()
    }

    func testDetailsReturnsTVSeason() async throws {
        let tvSeriesID = Int.randomID
        let expectedResult = TVSeason.mock()
        let seasonNumber = expectedResult.seasonNumber
        apiClient.addResponse(.success(expectedResult))
        let expectedRequest = TVSeasonRequest(
            seasonNumber: seasonNumber,
            tvSeriesID: tvSeriesID,
            language: nil
        )

        let result = try await service.details(forSeason: seasonNumber, inTVSeries: tvSeriesID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastRequest as? TVSeasonRequest, expectedRequest)
    }

    func testDetailsWithLanguageReturnsTVSeason() async throws {
        let tvSeriesID = Int.randomID
        let expectedResult = TVSeason.mock()
        let seasonNumber = expectedResult.seasonNumber
        let language = "en"
        apiClient.addResponse(.success(expectedResult))
        let expectedRequest = TVSeasonRequest(
            seasonNumber: seasonNumber,
            tvSeriesID: tvSeriesID,
            language: language
        )

        let result = try await service.details(forSeason: seasonNumber, inTVSeries: tvSeriesID, language: language)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastRequest as? TVSeasonRequest, expectedRequest)
    }

    func testDetailsWhenErrorsThrowsError() async throws {
        let tvSeriesID = 1
        let seasonNumber = 2
        apiClient.addResponse(.failure(.unknown))

        var error: Error?
        do {
            _ = try await service.details(forSeason: seasonNumber, inTVSeries: tvSeriesID)
        } catch let err {
            error = err
        }

        let tmdbAPIError = try XCTUnwrap(error as? TMDbError)

        XCTAssertEqual(tmdbAPIError, .unknown)
    }

    func testAggregateCreditsReturnsTVSeasonCredits() async throws {
        let tvSeriesID = Int.randomID
        let expectedResult = TVSeasonAggregateCredits(id: 1, cast: [], crew: [])
        let seasonNumber = Int.randomID
        apiClient.addResponse(.success(expectedResult))
        let expectedRequest = TVSeasonAggregateCreditsRequest(
            seasonNumber: seasonNumber,
            tvSeriesID: tvSeriesID,
            language: nil
        )

        let result = try await service.aggregateCredits(forSeason: seasonNumber, inTVSeries: tvSeriesID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastRequest as? TVSeasonAggregateCreditsRequest, expectedRequest)
    }

    func testAggregateCreditsWithLanguageReturnsTVSeasonCredits() async throws {
        let tvSeriesID = Int.randomID
        let expectedResult = TVSeasonAggregateCredits(id: 1, cast: [], crew: [])
        let seasonNumber = Int.randomID
        let language = "en"
        apiClient.addResponse(.success(expectedResult))
        let expectedRequest = TVSeasonAggregateCreditsRequest(
            seasonNumber: seasonNumber,
            tvSeriesID: tvSeriesID,
            language: language
        )

        let result = try await service.aggregateCredits(
            forSeason: seasonNumber,
            inTVSeries: tvSeriesID,
            language: language
        )

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastRequest as? TVSeasonAggregateCreditsRequest, expectedRequest)
    }

    func testAggregateCreditsWhenErrorsThrowsError() async throws {
        let tvSeriesID = 1
        let seasonNumber = 2
        apiClient.addResponse(.failure(.unknown))

        var error: Error?
        do {
            _ = try await service.aggregateCredits(forSeason: seasonNumber, inTVSeries: tvSeriesID)
        } catch let err {
            error = err
        }

        let tmdbAPIError = try XCTUnwrap(error as? TMDbError)

        XCTAssertEqual(tmdbAPIError, .unknown)
    }

    func testImagesReturnsImages() async throws {
        let seasonNumber = Int.randomID
        let tvSeriesID = Int.randomID
        let expectedResult = TVSeasonImageCollection.mock()
        apiClient.addResponse(.success(expectedResult))
        let expectedRequest = TVSeasonImagesRequest(
            seasonNumber: seasonNumber,
            tvSeriesID: tvSeriesID,
            languages: nil
        )

        let result = try await service.images(forSeason: seasonNumber, inTVSeries: tvSeriesID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastRequest as? TVSeasonImagesRequest, expectedRequest)
    }

    func testImagesWithFilterReturnsImages() async throws {
        let seasonNumber = Int.randomID
        let tvSeriesID = Int.randomID
        let languages = ["en-GB", "fr"]
        let expectedResult = TVSeasonImageCollection.mock()
        apiClient.addResponse(.success(expectedResult))
        let expectedRequest = TVSeasonImagesRequest(
            seasonNumber: seasonNumber,
            tvSeriesID: tvSeriesID,
            languages: languages
        )

        let filter = TVSeasonImageFilter(languages: languages)
        let result = try await service.images(forSeason: seasonNumber, inTVSeries: tvSeriesID, filter: filter)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastRequest as? TVSeasonImagesRequest, expectedRequest)
    }

    func testImagesWhenErrorsThrowsError() async throws {
        let tvSeriesID = 1
        let seasonNumber = 2
        apiClient.addResponse(.failure(.unknown))

        var error: Error?
        do {
            _ = try await service.images(forSeason: seasonNumber, inTVSeries: tvSeriesID)
        } catch let err {
            error = err
        }

        let tmdbAPIError = try XCTUnwrap(error as? TMDbError)

        XCTAssertEqual(tmdbAPIError, .unknown)
    }

    func testVideosReturnsVideos() async throws {
        let seasonNumber = Int.randomID
        let tvSeriesID = Int.randomID
        let expectedResult = VideoCollection.mock()
        apiClient.addResponse(.success(expectedResult))
        let expectedRequest = TVSeasonVideosRequest(
            seasonNumber: seasonNumber,
            tvSeriesID: tvSeriesID,
            languages: nil
        )

        let result = try await service.videos(forSeason: seasonNumber, inTVSeries: tvSeriesID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastRequest as? TVSeasonVideosRequest, expectedRequest)
    }

    func testVideosWithFilterReturnsVideos() async throws {
        let seasonNumber = Int.randomID
        let tvSeriesID = Int.randomID
        let languages = ["en", "fr"]
        let expectedResult = VideoCollection.mock()
        apiClient.addResponse(.success(expectedResult))
        let expectedRequest = TVSeasonVideosRequest(
            seasonNumber: seasonNumber,
            tvSeriesID: tvSeriesID,
            languages: languages
        )

        let filter = TVSeasonVideoFilter(languages: languages)
        let result = try await service.videos(forSeason: seasonNumber, inTVSeries: tvSeriesID, filter: filter)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastRequest as? TVSeasonVideosRequest, expectedRequest)
    }

    func testVideosWhenErrorsThrowsError() async throws {
        let tvSeriesID = 1
        let seasonNumber = 2
        apiClient.addResponse(.failure(.unknown))

        var error: Error?
        do {
            _ = try await service.videos(forSeason: seasonNumber, inTVSeries: tvSeriesID)
        } catch let err {
            error = err
        }

        let tmdbAPIError = try XCTUnwrap(error as? TMDbError)

        XCTAssertEqual(tmdbAPIError, .unknown)
    }

}
