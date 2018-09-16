import Foundation

enum Currency: String {
    case RUR = "RUR"
    case USD = "USD"
    case EUD = "EUD"
}

protocol PrintProtocol {
    func printInfo()
}

class Account : PrintProtocol {
    var id: Int
    var balance: Double
    var currency: Currency?
    var description: String
    var offer: String?
    
    init(id: Int, balance: Double, currency: String, description: String, offer: String? = "deffault offer") {
        self.id = id
        self.balance = balance
        self.currency = Currency(rawValue: currency)
        self.description = description
        self.offer = offer
    }
    
    func printInfo() {
        print("Account: \nid: \(id) \nbalance: \(balance) \ncurrency: \(currency?.rawValue ?? "nil currency") \ndescription: \(description) \noffer: \(offer ?? "nil offer")")
    }
}

func ForDate(StringDate: String) -> Date? {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd"
    return dateFormatterGet.date(from: StringDate)
}

class ReissueInfo : PrintProtocol {
    var date: Date?
    var info: String
    var address: String
    
    init(sdate: String, info: String, address: String = "Головной офис"){
        self.date = ForDate(StringDate: sdate)
        self.info = info
        self.address = address
    }
    
    func printInfo() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd --- MM --- yyyy"
        let datee = dateFormatter.string(from: date! )
        print("Reissue Info \ndate: \(datee) \ninfo: \(info) \naddress: \(address)")
    }
}

class Card: PrintProtocol {
    var id: Int
    var balance: Double
    var currency: Currency?
    var reissueInfo: ReissueInfo?
    
    init(id: Int, balance: Double, currency: String, reissueInfo: ReissueInfo? = nil ){
        self.id = id
        self.balance = balance
        self.currency = Currency(rawValue: currency)
        self.reissueInfo = reissueInfo
    }
    
    func printInfo() {
        print("Card \ncard id: \(id) \nbalance: \(balance) \ncurrency: \(currency?.rawValue ?? "no currency") \n\( reissueInfo?.address ?? "no reissure")")
    }
}

class ServerResponce: PrintProtocol {
    var cards: [Card]
    var accounts: [Account]
    
    init(cardArray: [Card], accountArray: [Account]) {
        self.cards = cardArray
        self.accounts = accountArray
    }
    func printInfo() {
        print("Server Response \ncards: \(cards) \naccounts: \(accounts)")
    }
}

var ac1 = Account(id: 3, balance: 178.201, currency: "USD", description: "good ", offer: "good offer")
var ac2 = Account(id: 8, balance: 23.33, currency: "RUR", description: "excellent")

let accs = [ac1, ac2]

let reissueInfo = ReissueInfo(sdate: "2018-08-16",info: "info", address: "address")
let card1 = Card(id: 1, balance: 12.04, currency: "EUD", reissueInfo: reissueInfo)

let card2 = Card(id: 3, balance: 5555.04, currency: "RUR")

let cards = [card1, card2]

let response = ServerResponce(cardArray: cards, accountArray: accs)

var array = [PrintProtocol]()

array.append(contentsOf: cards)

array.append(contentsOf: accs)

array.append(response)

for i in array {
    i.printInfo()
    
}

