//
//  MoviesLoaderTests.swift
//  MovieQuizTests
//
//  Created by Ринат Чембулатов on 04.07.2026.
//
import XCTest
@testable import MovieQuiz

class MoviesLoaderTests: XCTestCase {
    
   
    func testSuccessLoading() throws {
        // Given
        let stubNetworkClient = StubNetworkClient(emulateError: false)
        let loader = MoviesLoader(networkClient: stubNetworkClient)
        
        // When
        let expectation = expectation(description: "Loading expectation")
        
        loader.loadMovies { result in
            // Then
            switch result {
            case .success(let movies):
                XCTAssertEqual(movies.items.count, 2)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Unexpected failure: \(error)")
            }
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testFailureLoading() throws {
        // Given
        let stubNetworkClient = StubNetworkClient(emulateError: true)
        let loader = MoviesLoader(networkClient: stubNetworkClient)
        
        // When
        let expectation = expectation(description: "Loading expectation")
        
        loader.loadMovies { result in
            // Then
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            case .success(_):
                XCTFail("Unexpected success: expected error but got data")
            }
        }
        
        waitForExpectations(timeout: 1)
    }

    struct StubNetworkClient: NetworkRouting {
        enum TestError: Error { case test }
        let emulateError: Bool
        
        func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void) {
            if emulateError {
                handler(.failure(TestError.test))
            } else {
                handler(.success(expectedResponse))
            }
        }
        
        private var expectedResponse: Data {
            """
            {
               "errorMessage" : "",
               "items" : [
                  { "fullTitle" : "Prey (2022)", "imDbRating" : "7.2", "image" : "https://example.com/1.jpg" },
                  { "fullTitle" : "The Gray Man (2022)", "imDbRating" : "6.5", "image" : "https://example.com/2.jpg" }
                ]
              }
            """.data(using: .utf8) ?? Data()
        }
    }
}
