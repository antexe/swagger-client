// Models.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

protocol JSONEncodable {
    func encodeToJSON() -> Any
}

public enum ErrorResponse : Error {
    case Error(Int, Data?, Error)
}

open class Response<T> {
    open let statusCode: Int
    open let header: [String: String]
    open let body: T?

    public init(statusCode: Int, header: [String: String], body: T?) {
        self.statusCode = statusCode
        self.header = header
        self.body = body
    }

    public convenience init(response: HTTPURLResponse, body: T?) {
        let rawHeader = response.allHeaderFields
        var header = [String:String]()
        for (key, value) in rawHeader {
            header[key as! String] = value as? String
        }
        self.init(statusCode: response.statusCode, header: header, body: body)
    }
}

private var once = Int()
class Decoders {
    static fileprivate var decoders = Dictionary<String, ((AnyObject) -> AnyObject)>()

    static func addDecoder<T>(clazz: T.Type, decoder: @escaping ((AnyObject) -> T)) {
        let key = "\(T.self)"
        decoders[key] = { decoder($0) as AnyObject }
    }

    static func decode<T>(clazz: T.Type, discriminator: String, source: AnyObject) -> T {
        let key = discriminator;
        if let decoder = decoders[key] {
            return decoder(source) as! T
        } else {
            fatalError("Source \(source) is not convertible to type \(clazz): Maybe swagger file is insufficient")
        }
    }

    static func decode<T>(clazz: [T].Type, source: AnyObject) -> [T] {
        let array = source as! [AnyObject]
        return array.map { Decoders.decode(clazz: T.self, source: $0) }
    }

    static func decode<T, Key: Hashable>(clazz: [Key:T].Type, source: AnyObject) -> [Key:T] {
        let sourceDictionary = source as! [Key: AnyObject]
        var dictionary = [Key:T]()
        for (key, value) in sourceDictionary {
            dictionary[key] = Decoders.decode(clazz: T.self, source: value)
        }
        return dictionary
    }

    static func decode<T>(clazz: T.Type, source: AnyObject) -> T {
        initialize()
        if T.self is Int32.Type && source is NSNumber {
            return source.int32Value as! T;
        }
        if T.self is Int64.Type && source is NSNumber {
            return source.int64Value as! T;
        }
        if T.self is UUID.Type && source is String {
            return UUID(uuidString: source as! String) as! T
        }
        if source is T {
            return source as! T
        }
        if T.self is Data.Type && source is String {
            return Data(base64Encoded: source as! String) as! T
        }

        let key = "\(T.self)"
        if let decoder = decoders[key] {
           return decoder(source) as! T
        } else {
            fatalError("Source \(source) is not convertible to type \(clazz): Maybe swagger file is insufficient")
        }
    }

    static func decodeOptional<T>(clazz: T.Type, source: AnyObject?) -> T? {
        if source is NSNull {
            return nil
        }
        return source.map { (source: AnyObject) -> T in
            Decoders.decode(clazz: clazz, source: source)
        }
    }

    static func decodeOptional<T>(clazz: [T].Type, source: AnyObject?) -> [T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    static func decodeOptional<T, Key: Hashable>(clazz: [Key:T].Type, source: AnyObject?) -> [Key:T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [Key:T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    private static var __once: () = {
        let formatters = [
            "yyyy-MM-dd",
            "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ss'Z'",
            "yyyy-MM-dd'T'HH:mm:ss.SSS",
            "yyyy-MM-dd HH:mm:ss"
        ].map { (format: String) -> DateFormatter in
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return formatter
        }
        // Decoder for Date
        Decoders.addDecoder(clazz: Date.self) { (source: AnyObject) -> Date in
           if let sourceString = source as? String {
                for formatter in formatters {
                    if let date = formatter.date(from: sourceString) {
                        return date
                    }
                }
            }
            if let sourceInt = source as? Int64 {
                // treat as a java date
                return Date(timeIntervalSince1970: Double(sourceInt / 1000) )
            }
            fatalError("formatter failed to parse \(source)")
        } 

        // Decoder for [Activities]
        Decoders.addDecoder(clazz: [Activities].self) { (source: AnyObject) -> [Activities] in
            return Decoders.decode(clazz: [Activities].self, source: source)
        }
        // Decoder for Activities
        Decoders.addDecoder(clazz: Activities.self) { (source: AnyObject) -> Activities in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = Activities()
            instance.offset = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["offset"] as AnyObject?)
            instance.limit = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["limit"] as AnyObject?)
            instance.count = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["count"] as AnyObject?)
            instance.history = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["history"] as AnyObject?)
            return instance
        }


        // Decoder for [Activity]
        Decoders.addDecoder(clazz: [Activity].self) { (source: AnyObject) -> [Activity] in
            return Decoders.decode(clazz: [Activity].self, source: source)
        }
        // Decoder for Activity
        Decoders.addDecoder(clazz: Activity.self) { (source: AnyObject) -> Activity in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = Activity()
            instance.uuid = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["uuid"] as AnyObject?)
            return instance
        }


        // Decoder for [InlineResponse200]
        Decoders.addDecoder(clazz: [InlineResponse200].self) { (source: AnyObject) -> [InlineResponse200] in
            return Decoders.decode(clazz: [InlineResponse200].self, source: source)
        }
        // Decoder for InlineResponse200
        Decoders.addDecoder(clazz: InlineResponse200.self) { (source: AnyObject) -> InlineResponse200 in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = InlineResponse200()
            instance.productId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["product_id"] as AnyObject?)
            instance.description = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["description"] as AnyObject?)
            instance.displayName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["display_name"] as AnyObject?)
            instance.capacity = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["capacity"] as AnyObject?)
            instance.image = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["image"] as AnyObject?)
            return instance
        }


        // Decoder for [InlineResponse2001]
        Decoders.addDecoder(clazz: [InlineResponse2001].self) { (source: AnyObject) -> [InlineResponse2001] in
            return Decoders.decode(clazz: [InlineResponse2001].self, source: source)
        }
        // Decoder for InlineResponse2001
        Decoders.addDecoder(clazz: InlineResponse2001.self) { (source: AnyObject) -> InlineResponse2001 in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = InlineResponse2001()
            instance.productId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["product_id"] as AnyObject?)
            instance.currencyCode = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["currency_code"] as AnyObject?)
            instance.displayName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["display_name"] as AnyObject?)
            instance.estimate = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["estimate"] as AnyObject?)
            instance.lowEstimate = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["low_estimate"] as AnyObject?)
            instance.highEstimate = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["high_estimate"] as AnyObject?)
            instance.surgeMultiplier = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["surge_multiplier"] as AnyObject?)
            return instance
        }


        // Decoder for [InlineResponse2002]
        Decoders.addDecoder(clazz: [InlineResponse2002].self) { (source: AnyObject) -> [InlineResponse2002] in
            return Decoders.decode(clazz: [InlineResponse2002].self, source: source)
        }
        // Decoder for InlineResponse2002
        Decoders.addDecoder(clazz: InlineResponse2002.self) { (source: AnyObject) -> InlineResponse2002 in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = InlineResponse2002()
            instance.firstName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["first_name"] as AnyObject?)
            instance.lastName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["last_name"] as AnyObject?)
            instance.email = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["email"] as AnyObject?)
            instance.picture = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["picture"] as AnyObject?)
            instance.promoCode = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["promo_code"] as AnyObject?)
            return instance
        }


        // Decoder for [InlineResponse2003]
        Decoders.addDecoder(clazz: [InlineResponse2003].self) { (source: AnyObject) -> [InlineResponse2003] in
            return Decoders.decode(clazz: [InlineResponse2003].self, source: source)
        }
        // Decoder for InlineResponse2003
        Decoders.addDecoder(clazz: InlineResponse2003.self) { (source: AnyObject) -> InlineResponse2003 in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = InlineResponse2003()
            instance.offset = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["offset"] as AnyObject?)
            instance.limit = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["limit"] as AnyObject?)
            instance.count = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["count"] as AnyObject?)
            instance.history = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["history"] as AnyObject?)
            return instance
        }


        // Decoder for [InlineResponse2003History]
        Decoders.addDecoder(clazz: [InlineResponse2003History].self) { (source: AnyObject) -> [InlineResponse2003History] in
            return Decoders.decode(clazz: [InlineResponse2003History].self, source: source)
        }
        // Decoder for InlineResponse2003History
        Decoders.addDecoder(clazz: InlineResponse2003History.self) { (source: AnyObject) -> InlineResponse2003History in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = InlineResponse2003History()
            instance.uuid = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["uuid"] as AnyObject?)
            return instance
        }


        // Decoder for [InlineResponseDefault]
        Decoders.addDecoder(clazz: [InlineResponseDefault].self) { (source: AnyObject) -> [InlineResponseDefault] in
            return Decoders.decode(clazz: [InlineResponseDefault].self, source: source)
        }
        // Decoder for InlineResponseDefault
        Decoders.addDecoder(clazz: InlineResponseDefault.self) { (source: AnyObject) -> InlineResponseDefault in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = InlineResponseDefault()
            instance.code = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["code"] as AnyObject?)
            instance.message = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["message"] as AnyObject?)
            instance.fields = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["fields"] as AnyObject?)
            return instance
        }


        // Decoder for [ModelError]
        Decoders.addDecoder(clazz: [ModelError].self) { (source: AnyObject) -> [ModelError] in
            return Decoders.decode(clazz: [ModelError].self, source: source)
        }
        // Decoder for ModelError
        Decoders.addDecoder(clazz: ModelError.self) { (source: AnyObject) -> ModelError in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = ModelError()
            instance.code = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["code"] as AnyObject?)
            instance.message = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["message"] as AnyObject?)
            instance.fields = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["fields"] as AnyObject?)
            return instance
        }


        // Decoder for [PriceEstimate]
        Decoders.addDecoder(clazz: [PriceEstimate].self) { (source: AnyObject) -> [PriceEstimate] in
            return Decoders.decode(clazz: [PriceEstimate].self, source: source)
        }
        // Decoder for PriceEstimate
        Decoders.addDecoder(clazz: PriceEstimate.self) { (source: AnyObject) -> PriceEstimate in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = PriceEstimate()
            instance.productId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["product_id"] as AnyObject?)
            instance.currencyCode = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["currency_code"] as AnyObject?)
            instance.displayName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["display_name"] as AnyObject?)
            instance.estimate = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["estimate"] as AnyObject?)
            instance.lowEstimate = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["low_estimate"] as AnyObject?)
            instance.highEstimate = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["high_estimate"] as AnyObject?)
            instance.surgeMultiplier = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["surge_multiplier"] as AnyObject?)
            return instance
        }


        // Decoder for [Product]
        Decoders.addDecoder(clazz: [Product].self) { (source: AnyObject) -> [Product] in
            return Decoders.decode(clazz: [Product].self, source: source)
        }
        // Decoder for Product
        Decoders.addDecoder(clazz: Product.self) { (source: AnyObject) -> Product in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = Product()
            instance.productId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["product_id"] as AnyObject?)
            instance.description = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["description"] as AnyObject?)
            instance.displayName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["display_name"] as AnyObject?)
            instance.capacity = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["capacity"] as AnyObject?)
            instance.image = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["image"] as AnyObject?)
            return instance
        }


        // Decoder for [Profile]
        Decoders.addDecoder(clazz: [Profile].self) { (source: AnyObject) -> [Profile] in
            return Decoders.decode(clazz: [Profile].self, source: source)
        }
        // Decoder for Profile
        Decoders.addDecoder(clazz: Profile.self) { (source: AnyObject) -> Profile in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = Profile()
            instance.firstName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["first_name"] as AnyObject?)
            instance.lastName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["last_name"] as AnyObject?)
            instance.email = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["email"] as AnyObject?)
            instance.picture = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["picture"] as AnyObject?)
            instance.promoCode = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["promo_code"] as AnyObject?)
            return instance
        }
    }()

    static fileprivate func initialize() {
        _ = Decoders.__once
    }
}
