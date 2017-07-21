//
// Error.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class Error: JSONEncodable {

    open var code: Int?
    open var message: String?
    open var fields: String?
    

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["code"] = self.code as AnyObject
        nillableDictionary["message"] = self.message as AnyObject
        nillableDictionary["fields"] = self.fields as AnyObject
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary as AnyObject
    }
}
