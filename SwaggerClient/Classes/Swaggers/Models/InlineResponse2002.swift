//
// InlineResponse2002.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class InlineResponse2002: JSONEncodable {
    /** First name of the Uber user. */
    public var firstName: String?
    /** Last name of the Uber user. */
    public var lastName: String?
    /** Email address of the Uber user */
    public var email: String?
    /** Image URL of the Uber user. */
    public var picture: String?
    /** Promo code of the Uber user. */
    public var promoCode: String?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["first_name"] = self.firstName
        nillableDictionary["last_name"] = self.lastName
        nillableDictionary["email"] = self.email
        nillableDictionary["picture"] = self.picture
        nillableDictionary["promo_code"] = self.promoCode
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
