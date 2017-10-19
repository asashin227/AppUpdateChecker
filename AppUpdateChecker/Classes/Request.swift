//
//  Request.swift
//  AppUpdateChecker
//
//  Created by Asakura Shinsuke on 2017/10/18.
//


public protocol Request {
    var baseURL: String { get }
    var path: String { get }
    var parameters: [String : String] { get }
}

extension Request {
    
    func loadData(compleation: ((Data?) -> Void)?) {
        guard let compleation = compleation,
        let url = makeURL() else { return }
        DispatchQueue.global().async {
            let mainQueue = DispatchQueue.main
            do {
                let data = try Data(contentsOf: url)
                mainQueue.async { compleation(data) }
            } catch {
                mainQueue.async { compleation(nil) }
            }
        }
    }
    
    private func makeURL() -> URL? {
        var urlString = baseURL + "/" + path
        if parameters.isEmpty {
            return URL(string: urlString)
        }
        urlString += "?"
        parameters.forEach() {
            key, value in
            urlString += key + "=" + value + "&"
        }
        urlString = String(urlString[..<urlString.index(urlString.startIndex, offsetBy: urlString.count - 1)])
        
        return URL(string: urlString)
    }
}
