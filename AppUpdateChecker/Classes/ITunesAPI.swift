//
//  ITunesAPI.swift
//  AppUpdateChecker
//
//  Created by Asakura Shinsuke on 2017/10/18.
//


struct ITunesAPI: Request {
    var baseURL: String {
        return "https://itunes.apple.com"
    }
    var path: String {
        return "lookup"
    }
    var parameters: [String : String] {
        return ["bundleId" : bundleId]
    }
    var bundleId: String
}
