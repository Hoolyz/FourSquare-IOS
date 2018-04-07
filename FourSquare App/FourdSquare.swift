// To parse the JSON, add this file to your project and do:
//
//   let fourSquare = try FourSquare(json)

import Foundation

class FourSquare: Decodable {
    let meta: Meta?
    let response: Response?
    
    enum CodingKeys: String, CodingKey {
        case meta = "meta"
        case response = "response"
    }
    
    init(meta: Meta?, response: Response?) {
        self.meta = meta
        self.response = response
    }
}

class Meta: DeDecodable {
    let code: Int?
    let requestID: String?
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case requestID = "requestId"
    }
    
    init(code: Int?, requestID: String?) {
        self.code = code
        self.requestID = requestID
    }
}

class Response: Decodable {
    let venues: [Venue]?
    
    enum CodingKeys: String, CodingKey {
        case venues = "venues"
    }
    
    init(venues: [Venue]?) {
        self.venues = venues
    }
}

class Venue: Decodable {
    let contact: Contact?
    let venueChains: [JSONAny]?
    let hereNow: HereNow?
    let hasPerk: Bool?
    let verified: Bool?
    let name: String?
    let url: String?
    let venueRatingBlacklisted: Bool?
    let location: Location?
    let referralID: String?
    let specials: Specials?
    let id: String?
    let categories: [Category]?
    let beenHere: BeenHere?
    let stats: Stats?
    
    enum CodingKeys: String, CodingKey {
        case contact = "contact"
        case venueChains = "venueChains"
        case hereNow = "hereNow"
        case hasPerk = "hasPerk"
        case verified = "verified"
        case name = "name"
        case url = "url"
        case venueRatingBlacklisted = "venueRatingBlacklisted"
        case location = "location"
        case referralID = "referralId"
        case specials = "specials"
        case id = "id"
        case categories = "categories"
        case beenHere = "beenHere"
        case stats = "stats"
    }
    
    init(contact: Contact?, venueChains: [JSONAny]?, hereNow: HereNow?, hasPerk: Bool?, verified: Bool?, name: String?, url: String?, venueRatingBlacklisted: Bool?, location: Location?, referralID: String?, specials: Specials?, id: String?, categories: [Category]?, beenHere: BeenHere?, stats: Stats?) {
        self.contact = contact
        self.venueChains = venueChains
        self.hereNow = hereNow
        self.hasPerk = hasPerk
        self.verified = verified
        self.name = name
        self.url = url
        self.venueRatingBlacklisted = venueRatingBlacklisted
        self.location = location
        self.referralID = referralID
        self.specials = specials
        self.id = id
        self.categories = categories
        self.beenHere = beenHere
        self.stats = stats
    }
}

class BeenHere: Decodable {
    let lastCheckinExpiredAt: Int?
    
    enum CodingKeys: String, CodingKey {
        case lastCheckinExpiredAt = "lastCheckinExpiredAt"
    }
    
    init(lastCheckinExpiredAt: Int?) {
        self.lastCheckinExpiredAt = lastCheckinExpiredAt
    }
}

class Category: Decodable {
    let id: String?
    let name: String?
    let pluralName: String?
    let shortName: String?
    let icon: Icon?
    let primary: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case pluralName = "pluralName"
        case shortName = "shortName"
        case icon = "icon"
        case primary = "primary"
    }
    
    init(id: String?, name: String?, pluralName: String?, shortName: String?, icon: Icon?, primary: Bool?) {
        self.id = id
        self.name = name
        self.pluralName = pluralName
        self.shortName = shortName
        self.icon = icon
        self.primary = primary
    }
}

class Icon: Decodable {
    let iconPrefix: String?
    let suffix: String?
    
    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case suffix = "suffix"
    }
    
    init(iconPrefix: String?, suffix: String?) {
        self.iconPrefix = iconPrefix
        self.suffix = suffix
    }
}

class Contact: Decodable {
    let phone: String?
    let formattedPhone: String?
    let twitter: String?
    let instagram: String?
    let facebook: String?
    let facebookUsername: String?
    let facebookName: String?
    
    enum CodingKeys: String, CodingKey {
        case phone = "phone"
        case formattedPhone = "formattedPhone"
        case twitter = "twitter"
        case instagram = "instagram"
        case facebook = "facebook"
        case facebookUsername = "facebookUsername"
        case facebookName = "facebookName"
    }
    
    init(phone: String?, formattedPhone: String?, twitter: String?, instagram: String?, facebook: String?, facebookUsername: String?, facebookName: String?) {
        self.phone = phone
        self.formattedPhone = formattedPhone
        self.twitter = twitter
        self.instagram = instagram
        self.facebook = facebook
        self.facebookUsername = facebookUsername
        self.facebookName = facebookName
    }
}

class HereNow: Decodable {
    let count: Int?
    let summary: String?
    let groups: [Group]?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case summary = "summary"
        case groups = "groups"
    }
    
    init(count: Int?, summary: String?, groups: [Group]?) {
        self.count = count
        self.summary = summary
        self.groups = groups
    }
}

class Group: Decodable {
    let type: String?
    let name: String?
    let count: Int?
    let items: [JSONAny]?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case name = "name"
        case count = "count"
        case items = "items"
    }
    
    init(type: String?, name: String?, count: Int?, items: [JSONAny]?) {
        self.type = type
        self.name = name
        self.count = count
        self.items = items
    }
}

class Location: Decodable {
    let lat: Double?
    let lng: Double?
    let labeledLatLngs: [LabeledLatLng]?
    let distance: Int?
    let cc: String?
    let state: String?
    let country: String?
    let formattedAddress: [String]?
    
    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lng = "lng"
        case labeledLatLngs = "labeledLatLngs"
        case distance = "distance"
        case cc = "cc"
        case state = "state"
        case country = "country"
        case formattedAddress = "formattedAddress"
    }
    
    init(lat: Double?, lng: Double?, labeledLatLngs: [LabeledLatLng]?, distance: Int?, cc: String?, state: String?, country: String?, formattedAddress: [String]?) {
        self.lat = lat
        self.lng = lng
        self.labeledLatLngs = labeledLatLngs
        self.distance = distance
        self.cc = cc
        self.state = state
        self.country = country
        self.formattedAddress = formattedAddress
    }
}

class LabeledLatLng: Decodable {
    let label: String?
    let lat: Double?
    let lng: Double?
    
    enum CodingKeys: String, CodingKey {
        case label = "label"
        case lat = "lat"
        case lng = "lng"
    }
    
    init(label: String?, lat: Double?, lng: Double?) {
        self.label = label
        self.lat = lat
        self.lng = lng
    }
}

class Specials: Decodable {
    let count: Int?
    let items: [JSONAny]?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case items = "items"
    }
    
    init(count: Int?, items: [JSONAny]?) {
        self.count = count
        self.items = items
    }
}

class Stats: Decodable {
    let tipCount: Int?
    let usersCount: Int?
    let checkinsCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case tipCount = "tipCount"
        case usersCount = "usersCount"
        case checkinsCount = "checkinsCount"
    }
    
    init(tipCount: Int?, usersCount: Int?, checkinsCount: Int?) {
        self.tipCount = tipCount
        self.usersCount = usersCount
        self.checkinsCount = checkinsCount
    }
}

// MARK: Convenience initializers

extension FourSquare {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(FourSquare.self, from: data)
        self.init(meta: me.meta, response: me.response)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Meta {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Meta.self, from: data)
        self.init(code: me.code, requestID: me.requestID)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Response {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Response.self, from: data)
        self.init(venues: me.venues)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Venue {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Venue.self, from: data)
        self.init(contact: me.contact, venueChains: me.venueChains, hereNow: me.hereNow, hasPerk: me.hasPerk, verified: me.verified, name: me.name, url: me.url, venueRatingBlacklisted: me.venueRatingBlacklisted, location: me.location, referralID: me.referralID, specials: me.specials, id: me.id, categories: me.categories, beenHere: me.beenHere, stats: me.stats)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension BeenHere {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(BeenHere.self, from: data)
        self.init(lastCheckinExpiredAt: me.lastCheckinExpiredAt)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Category {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Category.self, from: data)
        self.init(id: me.id, name: me.name, pluralName: me.pluralName, shortName: me.shortName, icon: me.icon, primary: me.primary)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Icon {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Icon.self, from: data)
        self.init(iconPrefix: me.iconPrefix, suffix: me.suffix)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Contact {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Contact.self, from: data)
        self.init(phone: me.phone, formattedPhone: me.formattedPhone, twitter: me.twitter, instagram: me.instagram, facebook: me.facebook, facebookUsername: me.facebookUsername, facebookName: me.facebookName)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension HereNow {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(HereNow.self, from: data)
        self.init(count: me.count, summary: me.summary, groups: me.groups)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Group {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Group.self, from: data)
        self.init(type: me.type, name: me.name, count: me.count, items: me.items)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Location {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Location.self, from: data)
        self.init(lat: me.lat, lng: me.lng, labeledLatLngs: me.labeledLatLngs, distance: me.distance, cc: me.cc, state: me.state, country: me.country, formattedAddress: me.formattedAddress)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension LabeledLatLng {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(LabeledLatLng.self, from: data)
        self.init(label: me.label, lat: me.lat, lng: me.lng)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Specials {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Specials.self, from: data)
        self.init(count: me.count, items: me.items)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Stats {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Stats.self, from: data)
        self.init(tipCount: me.tipCount, usersCount: me.usersCount, checkinsCount: me.checkinsCount)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: Encode/decode helpers

class JSONNull: Decodable {
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

class JSONAny: Decodable {
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
