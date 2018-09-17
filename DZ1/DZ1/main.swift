import Foundation

protocol Print_Protocol {
    func printInfo()
}

enum Currency: String {
    case USD = "USD"
    case RUR = "RUR"
    case EUD = "EUD"
    
}
class Information {
    
    var id: Int
    var balance: Double
    var currency: Currency?
    
    init(id: Int, balance: Double, currency: String) {
        self.id=id
        self.balance = balance
        self.currency = Currency ( rawValue: currency)
    }
}
class Account : Information, Print_Protocol {
   
    var  description: String
    var offer: String?
    
    init(id: Int, balance: Double, currency: String, description: String, offer: String? = nil) {
        
       
        self.description = description
        self.offer = offer
        super.init(id: id, balance: balance, currency: currency)
    }
   
    func printInfo(){
        print("Account \nid:  \(id) \nbalance: \(balance) \ncurrency: \(currency?.rawValue ?? "no currency" ) \noffer: \(offer ?? "no offers")")
    }
}

func FromStringToDate(StringDate: String) -> Date? {
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "dd MMMM yyyy"
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
        dateFormatter.dateFormat = "dd --- mm --- yyyy"
        let strDate = dateFormatter.string(from: date! )
        print("Reissue Information \ndate: \(strDate) \ninfo: \(info) \naddress: \(address)")
    }
}



class Card: Information, Print_Protocol {
    var reissueInfo: ReissueInfo?
  
    
    init(id: Int, balance: Double, currency: String, reissueInfo: ReissueInfo? = nil ){
        super.init(id: id, balance: balance, currency: currency)
        self.reissueInfo = reissueInfo
    }
    
    func printInfo() {
        print("Card \nid: \(id) \nbalance: \(balance) \nreissue: \(reissueInfo?.address ?? "no reissue") \ncurrency: \(currency?.rawValue ?? "no currency")")
    }
}

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

let ac1 = Account(id: 1, balance: 1946.2, currency: "RUR", description: "First user", offer: "this is offer")

let ac2 = Account(id: 2, balance: 237.23, currency: "USD", description: "Second user")

let accs:[Account] = [ac1, ac2]

let reissueInfo = ReissueInfo(strDate: "16 cенятбря 2018", information: "Information")
let card1 = Card(id: 3, balance: 56734.08, currency: "EUD", reissueInfo: reissueInfo)

let card2 = Card(id:4, balance: 346.04, currency: "RUR")

let cards:[Card] = [card1, card2]

let response = ServerResponce(cardArray: cards, accountArray: accs)

var array = [Print_Protocol]()

array.append(contentsOf: cards as? [Print_Protocol] ?? [])

array.append(contentsOf: accs as? [Print_Protocol] ?? [])

array.append(response)

for i in array {
    i.printInfo()
    
}
