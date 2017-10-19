//
//  Bundle+Versions.swift
//  AppUpdateChecker
//
//  Created by Asakura Shinsuke on 2017/10/19.
//

extension Bundle {
    var currentVersion: String? {
        guard let version = object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            return nil
        }
        return version
    }
}
