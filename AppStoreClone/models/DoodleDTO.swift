//
//  AppStoreDTO.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/11.
//
import Foundation

struct DoodleDTO: Codable {
    let resultCount: Int
    let results: [ResultDTO]
}

struct ResultDTO: Codable {
    let isGameCenterEnabled: Bool
    let supportedDevices: [String]
    let advisories, features: [String]
    let screenshotUrls: [String]
    let ipadScreenshotUrls, appletvScreenshotUrls: [String]
    let artworkUrl60, artworkUrl512, artworkUrl100: String
    let artistViewURL: String
    let kind: String
    let currentVersionReleaseDate: String
    let releaseNotes: String
    let isVppDeviceBasedLicensingEnabled: Bool
    let resultDescription, bundleID, sellerName, primaryGenreName: String
    let primaryGenreID: Int
    let genreIDS: [String]
    let releaseDate: String
    let currency, fileSizeBytes, minimumOSVersion, trackCensoredName: String
    let languageCodesISO2A: [String]
    let formattedPrice, contentAdvisoryRating: String
    let averageUserRatingForCurrentVersion: Double
    let userRatingCountForCurrentVersion: Int
    let averageUserRating: Double
    let trackViewURL: String
    let trackContentRating, trackName: String
    let trackID, artistID: Int
    let artistName: String
    let genres: [String]
    let price: Int
    let version, wrapperType: String
    let userRatingCount: Int

    enum CodingKeys: String, CodingKey {
        case isGameCenterEnabled, supportedDevices, advisories, features, screenshotUrls, ipadScreenshotUrls, appletvScreenshotUrls, artworkUrl60, artworkUrl512, artworkUrl100
        case artistViewURL = "artistViewUrl"
        case kind, currentVersionReleaseDate, releaseNotes, isVppDeviceBasedLicensingEnabled
        case resultDescription = "description"
        case bundleID = "bundleId"
        case sellerName, primaryGenreName
        case primaryGenreID = "primaryGenreId"
        case genreIDS = "genreIds"
        case releaseDate, currency, fileSizeBytes
        case minimumOSVersion = "minimumOsVersion"
        case trackCensoredName, languageCodesISO2A, formattedPrice, contentAdvisoryRating, averageUserRatingForCurrentVersion, userRatingCountForCurrentVersion, averageUserRating
        case trackViewURL = "trackViewUrl"
        case trackContentRating, trackName
        case trackID = "trackId"
        case artistID = "artistId"
        case artistName, genres, price, version, wrapperType, userRatingCount
    }
}

