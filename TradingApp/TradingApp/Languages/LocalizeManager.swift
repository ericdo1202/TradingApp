//
//  LocalizeManager.swift
//  TradingApp
//
//  Created by Duoc Do on 2/6/25.
//

import Foundation

enum LanguageType:String {
    case Vietamese
    case English
    case Korean

    var rawValue: String{
        switch self {
        case .Vietamese:
            return "vi"
        case .English:
            return "en"
        case .Korean:
            return "ko"
        }
    }
}

class LocalizeManager: NSObject {
    class func localizedStringForKey(key k: String, languageCode: LanguageType = .English) -> String{
        if let path = Bundle.main.path(forResource: languageCode.rawValue, ofType: "lproj"), let bundle = Bundle(path: path){
            return NSLocalizedString(k, tableName: nil, bundle: bundle,value: "", comment: "")
        }

        return k
    }
}
