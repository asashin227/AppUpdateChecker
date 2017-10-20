//
//  AppUpdateChecker.swift
//  AppUpdateChecker
//
//  Created by Asakura Shinsuke on 2017/10/18.
//



public struct AppUpdateChecker {
    public enum AUCError: Error {
        case appNotFountOnAppStore
        case unknownVersion
        case itunesAPIError
    }
    
    public enum AppVersionResult {
        case existUpdate(newestVersion: String, storeScheme: URL)
        case noUpdate
        case error(Error)
    }
    
    public init() { }
    
    public func conferm(bundleId: String = Bundle.main.bundleIdentifier!, compleation: @escaping (AppVersionResult) -> Void) {
        ITunesAPI(bundleId: bundleId).loadData() {
            data in
            guard let data = data else {
                compleation(.error(AUCError.itunesAPIError))
                return
            }
            
            do {
                guard let info = try self.serialize(data: data) else {
                    compleation(.error(AUCError.appNotFountOnAppStore))
                    return
                }
                guard let version = try self.extractVersion(info: info),
                    let currentVersion = Bundle.main.currentVersion else {
                        compleation(.error(AUCError.unknownVersion))
                        return
                }
                if version <= currentVersion {
                    compleation(.noUpdate)
                    return
                }
                
                guard let scheme = try self.makeStoreScheme(info: info) else {
                    compleation(.error(AUCError.unknownVersion))
                    return
                }
                compleation(.existUpdate(newestVersion: version, storeScheme: scheme))
            } catch {
                compleation(.error(error))
            }
        }
    }
}

extension AppUpdateChecker {
    func serialize(data: Data) throws -> [String : Any]?  {
        guard let obj = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] else {
            return nil
        }
        return obj
    }
    
    func extractVersion(info: [String : Any]) throws -> String? {
        guard let resCount = info["resultCount"] as? Int else {
            throw AUCError.itunesAPIError
        }
        if resCount <= 0 {
            throw AUCError.appNotFountOnAppStore
        }
        
        guard let results = info["results"] as? [[String : Any]],
            let firstResult = results.first,
            let version = firstResult["version"] as? String else {
                throw AUCError.itunesAPIError
        }
        return version
    }
    
    func makeStoreScheme(info: [String : Any]) throws -> URL? {
        guard let resCount = info["resultCount"] as? Int else {
            throw AUCError.itunesAPIError
        }
        if resCount <= 0 {
            throw AUCError.appNotFountOnAppStore
        }
        
        guard let results = info["results"] as? [[String : Any]],
            let firstResult = results.first,
            let appIdNum = firstResult["trackId"] as? Int else {
                throw AUCError.itunesAPIError
        }
        return URL(string: "itms-apps://itunes.apple.com/app/id\(appIdNum)")
    }
}
