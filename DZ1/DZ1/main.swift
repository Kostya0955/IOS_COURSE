import Foundation

protocol Print_Protocol {
    func printInfo()
}

enum Currency: String {
    case USD = "USD"
    case RUR = "RUR"
    case EUD = "EUD"
    
}

class Account : Print_Protocol {
    var id: Int
    var balance: Double
    var currency: Currency?
    var  description: String
    var offer: String?
    
    init(id: Int, balance: Double, currency: String, description: String, offer: String? = nil) {
        self.id = id
        self.balance = balance
        self.currency = Currency(rawValue: currency)
        self.description = description
        self.offer = offer
    }
    func printInfo(){
        print("User account \nuser id: \(id) \nbalance: \(balance) \ncurrency: \(currency?.rawValue ?? "incorrect currency" ) \noffer: \(offer ?? "offers don't exist")")
    }
}

func FromStringToDate(StringDate: String) -> Date? {
    let dateFormater = DateFormatter()
    dateFormater.dateStyle = .medium
    dateFormater.locale = Locale(identifier: "ru_RU")
    dateFormater.dateFormat = "dd MMMM yyyy"
    dateFormater.timeZone = TimeZone(secondsFromGMT: 0)
    return dateFormater.date(from: StringDate)
    
}

class ReissueInfo: Print_Protocol{
    var date: Date?
    var info: String
    var address: String
    
    init(strDate: String, information: String, address:String = "Головной офис") {
        date = FromStringToDate(StringDate: strDate)
        info = information
        self.address = address
    }
    
    func printInfo() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd --- MM --- yyyy"
        let strDateYeag = dateFormatter.string(from: date! )
        print("Reissue Info \ndate: \(strDateYeag) \ninfo: \(info) \naddress: \(address)")
    }
}
var a = ReissueInfo(strDate: "10 октября 2018",information: "sdad", address: "asdaszxczxc")


class Card: Print_Protocol {
    var reissueInfo: ReissueInfo?
    var id: Int
    var balance: Double
    var currency: Currency?
    
    init(id: Int, balance: Double, currency: String, reissueInfo: ReissueInfo? = nil ){
        self.id = id
        self.balance = balance
        self.currency = Currency(rawValue: currency)
        self.reissueInfo = reissueInfo
    }
    
    func printInfo() {
        print("Card \ncard id: \(id) \nbalance: \(balance) \ncurrency: \(currency?.rawValue ?? "incorrect currency")")
    }
}
var z = Card(id: 34, balance: 23.45, currency: "RUR", reissueInfo: a)
z.printInfo()

class ServerResponce: Print_Protocol {
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


let ac1 = Account(id: 1, balance: 194.2, currency: "RUR", description: "First user", offer: "good")

let ac2 = Account(id: 2, balance: 23.23, currency: "USD", description: "Second user")

let accs = [ac1, ac2]

let reissueInfo = ReissueInfo(strDate: "16 cенятбря 2018", information: "Information")
let card1 = Card(id: 3, balance: 5634.08, currency: "EUD", reissueInfo: reissueInfo)

let card2 = Card(id:4, balance: 34.04, currency: "RUR")

let cards = [card1, card2]

let response = ServerResponce(cardArray: cards, accountArray: accs)

var array = [Print_Protocol]()

array.append(contentsOf: cards)

array.append(contentsOf: accs)

array.append(response)

for i in array {
    i.printInfo()
    
}
