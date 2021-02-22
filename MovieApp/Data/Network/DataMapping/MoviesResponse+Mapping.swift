//
//  MoviesResponse+Mapping.swift
//  MovieApp
//
//  Created by wilder campos on 21/02/21.
//

import Foundation

// MARK: - Data Transfer Object

struct MoviesResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case movies = "results"
    }
    let page: Int
    let totalPages: Int
    let movies: [Movie]
}

extension MoviesResponse {
    struct Movie: Decodable {
        let id: Int
        let title: String?
        let genre: Genre?
        let posterPath: String?
        let average: Double
        let overview: String?
        let releaseDate: String?
        
        private enum CodingKeys: String, CodingKey {
            case id
            case title
            case genre
            case posterPath = "poster_path"
            case average = "vote_average"
            case overview
            case releaseDate = "release_date"
        }
        
        enum Genre: String, Decodable {
            case adventure
            case scienceFiction = "science_fiction"
        }
    }
}

// MARK: - Mappings to Domain

extension MoviesResponse {
    func toDomain() -> MoviesPage {
        return .init(page: page,
                     totalPages: totalPages,
                     movies: movies.map { $0.toDomain() })
    }
}

extension MoviesResponse.Movie {
    func toDomain() -> Movie {
        return .init(id: Movie.Identifier(id),
                     title: title,
                     genre: genre?.toDomain(),
                     average: average,
                     posterPath: posterPath,
                     overview: overview,
                     releaseDate: dateFormatter.date(from: releaseDate ?? ""))
    }
}

extension MoviesResponse.Movie.Genre {
    func toDomain() -> Movie.Genre {
        switch self {
        case .adventure: return .adventure
        case .scienceFiction: return .scienceFiction
        }
    }
}

// MARK: - Private

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
}()
