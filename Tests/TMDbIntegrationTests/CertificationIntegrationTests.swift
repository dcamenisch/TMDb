//
//  CertificationIntegrationTests.swift
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

import TMDb
import XCTest

final class CertificationIntegrationTests: XCTestCase {

    var certificationService: (any CertificationService)!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let apiKey = try tmdbAPIKey()
        certificationService = TMDbClient(apiKey: apiKey).certifications
    }

    override func tearDown() {
        certificationService = nil
        super.tearDown()
    }

    func testMovieCertifications() async throws {
        let certifications = try await certificationService.movieCertifications()

        let gbCertifications = try XCTUnwrap(certifications["GB"])

        XCTAssertEqual(gbCertifications.count, 7)
    }

    func testTVSeriesCertifications() async throws {
        let certifications = try await certificationService.tvSeriesCertifications()

        let gbCertifications = try XCTUnwrap(certifications["GB"])

        XCTAssertEqual(gbCertifications.count, 7)
    }

}
