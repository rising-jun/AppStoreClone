//
//  AppStoreDTO.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/11.
//
import Foundation

struct DoodleDTO: Codable {
    let resultCount: Int
    let results: [DetailDTO]
}

final class DetailDTO: Codable {
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
    
    private(set) var titleImageData: Data?
    private(set) var currentVersionDate: String?
    private(set) var screenImageData: [Data] = []
    private(set) var screenImageIndex: Int = 0
    private(set) var moreDescriptionExpend: Bool = false
    private(set) var moreDescription: (() -> ())?
    private(set) var processedReviewRating: String?
    private(set) var processedAppSize: String?
    private(set) var moreSupportExpend: Bool = false
    private(set) var moreSupportDevice: (() -> ())?
    private(set) var allDevice: String = ""
}
extension DetailDTO: DetailEntityUsable {
    func getTitleEntityUsable() -> TitleEntityUsable {
        return self
    }
    
    func getNewFeatureEntityUsable() -> NewFeatureEntityUsable {
        return self
    }
    
    func getPreviewEntityUsable() -> PreviewEntityUsable {
        return self
    }
    
    func getDescriptionEntityUsable() -> DescriptionEntityUsable {
        return self
    }
    
    func getInfoEntityUsable() -> InfoEntityUsable {
        return self
    }
}
extension DetailDTO: TitleEntityUsable {
    func getTitle() -> String {
        return trackName
    }
    
    func getSubTitle() -> String {
        return artistName
    }
    
    func getImageURL() -> String {
        return artworkUrl512
    }
    
    func setTitleImage(data: Data) {
        titleImageData = data
    }
    
    func getTitleImage() -> Data? {
        return titleImageData
    }
}
extension DetailDTO: NewFeatureEntityUsable {
    func getVersion() -> String {
        return version
    }
    
    func getCurrentVersionDate() -> String {
        return currentVersionReleaseDate
    }
    
    func getReleaseNotes() -> String {
        return releaseNotes
    }
    
    func setCurrentVersionDate(_ date: String) {
        return self.currentVersionDate = "\(date) 전"
    }
    
    func getUpdatedDate() -> String? {
        return self.currentVersionDate
    }
}
extension DetailDTO: PreviewEntityUsable {
    func getImageURLs() -> [String] {
        return screenshotUrls
    }
    
    func getImageData() -> [Data] {
        return screenImageData
    }
    
    func getImageIndex() -> Int {
        return screenImageIndex
    }
    
    func appendImage(data: Data) {
        screenImageData.append(data)
    }
    
    func increaseImageIndex() {
        screenImageIndex += 1
    }
}
extension DetailDTO: DescriptionEntityUsable {
    func setMoreDescriptionAction(action: @escaping () -> ()) {
        moreDescription = action
    }
    
    func getMoreDescriptionAction() -> (() -> ())? {
        return moreDescription
    }
    
    func isExpendDescription() -> Bool {
        return moreDescriptionExpend
    }
    
    func getDescription() -> String {
        return resultDescription
    }
    
    func getSellerName() -> String {
        return sellerName
    }
    
    func expendDescription() {
        moreDescriptionExpend = true
    }
}
extension DetailDTO: InfoEntityUsable {
    func setAllDevice(_ device: String) {
        self.allDevice = device
    }
    
    func getAllDevice() -> String {
        return allDevice
    }
    
    func expendSupportDevice() {
        moreSupportExpend = true
    }
    
    func setMoreSupportDeviceAction(action: @escaping () -> ()) {
        self.moreSupportDevice = action
    }
    
    func getMoreSupportDeviceAction() -> (() -> ())? {
        return moreSupportDevice
    }
    
    func isExpendSupportDevice() -> Bool {
        return moreSupportExpend
    }
    
    func getArtistName() -> String {
        return artistName
    }
    
    func getSupportDevice() -> [String] {
        return supportedDevices
    }
    
    func getCategory() -> String {
        return primaryGenreName
    }
    
    func getFileSize() -> String {
        return fileSizeBytes
    }
    
    func getUserRating() -> String {
        return "\(averageUserRating)"
    }
    
    func setProcessedAppSize(_ appSize: String) {
        self.processedAppSize = appSize
    }
    
    func getProcessedAppSize() -> String? {
        return processedAppSize
    }
    
    func setProcessedReviewRating(_ rating: String) {
        self.processedReviewRating = rating
    }
    
    func getProcessedReviewRating() -> String? {
        return processedReviewRating
    }
}

protocol TitleEntityUsable {
    func getTitle() -> String
    func getSubTitle() -> String
    func getImageURL() -> String
    func getTitleImage() -> Data?
    func setTitleImage(data: Data)
}

protocol NewFeatureEntityUsable {
    func getVersion() -> String
    func getCurrentVersionDate() -> String
    func setCurrentVersionDate(_ date: String)
    func getReleaseNotes() -> String
    func getUpdatedDate() -> String?
}

protocol PreviewEntityUsable {
    func getImageURLs() -> [String]
    func getImageData() -> [Data]
    func appendImage(data: Data)
    func getImageIndex() -> Int
    func increaseImageIndex()
}

protocol DescriptionEntityUsable {
    func getDescription() -> String
    func getSellerName() -> String
    func expendDescription()
    func isExpendDescription() -> Bool
    func setMoreDescriptionAction(action: @escaping () -> ())
    func getMoreDescriptionAction() -> (() -> ())?
}

protocol InfoEntityUsable {
    func getArtistName() -> String
    func getSupportDevice() -> [String]
    func getCategory() -> String
    func getFileSize() -> String
    func getUserRating() -> String
    func setProcessedAppSize(_ appSize: String)
    func getProcessedAppSize() -> String?
    func setProcessedReviewRating(_ rating: String)
    func getProcessedReviewRating() -> String?
    func isExpendSupportDevice() -> Bool
    func expendSupportDevice()
    func setMoreSupportDeviceAction(action: @escaping () -> ())
    func getMoreSupportDeviceAction() -> (() -> ())?
    func setAllDevice(_ device: String)
    func getAllDevice() -> String
}

protocol DetailEntityUsable: TitleEntityUsable, NewFeatureEntityUsable, PreviewEntityUsable, DescriptionEntityUsable, InfoEntityUsable {
    func getTitleEntityUsable() -> TitleEntityUsable
    func getNewFeatureEntityUsable() -> NewFeatureEntityUsable
    func getPreviewEntityUsable() -> PreviewEntityUsable
    func getDescriptionEntityUsable() -> DescriptionEntityUsable
    func getInfoEntityUsable() -> InfoEntityUsable
}
