//
//  TMDbCertificationServiceTests.swift
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

final class TMDbCertificationServiceTests: XCTestCase {

    var service: TMDbCertificationService!
    var apiClient: MockAPIClient!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        service = TMDbCertificationService(apiClient: apiClient)
    }

    override func tearDown() {
        service = nil
        apiClient = nil
        super.tearDown()
    }

    func testMovieCertificationsReturnsMovieCertifications() async throws {
        let certifications = Certifications.gbAndUS
        let expectedResult = certifications.certifications
        let expectedRequest = MovieCertificationsRequest()

        apiClient.addResponse(.success(certifications))

        let result = try await service.movieCertifications()

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastRequest as? MovieCertificationsRequest, expectedRequest)
    }

    func testMovieCertificationsWhenErrosThrowError() async throws {
        apiClient.addResponse(.failure(.unknown))

        var error: Error?
        do {
            _ = try await service.movieCertifications()
        } catch let err {
            error = err
        }

        let tmdbAPIError = try XCTUnwrap(error as? TMDbError)

        XCTAssertEqual(tmdbAPIError, .unknown)
    }

    func testTVSeriesCertificationsReturnsTVSeriesCertifications() async throws {
        let certifications = Certifications.gbAndUS
        let expectedResult = certifications.certifications
        let expectedRequest = TVSeriesCertificationsRequest()

        apiClient.addResponse(.success(certifications))

        let result = try await service.tvSeriesCertifications()

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastRequest as? TVSeriesCertificationsRequest, expectedRequest)
    }

    func testTVSeriesCertificationsWhenErrorsThrowsError() async throws {
        apiClient.addResponse(.failure(.unknown))

        var error: Error?
        do {
            _ = try await service.tvSeriesCertifications()
        } catch let err {
            error = err
        }

        let tmdbAPIError = try XCTUnwrap(error as? TMDbError)

        XCTAssertEqual(tmdbAPIError, .unknown)
    }

}
