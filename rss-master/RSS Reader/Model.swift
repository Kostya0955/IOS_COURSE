//
//  Model.swift
//  RSS Reader
//
//  Created by Ануфриев Артем on 11/12/2018.
//  Copyright © 2018 Ануфриев Артем. All rights reserved.
//

import UIKit

let defaults = UserDefaults.standard
let authKey = "userLoggedIn"
let timeKey = "timeKey"
let sortKey = "sortKey"
let langKey = "languageKey"
var userLoggedIn = false
var time: String?
var sorted: String?
var language: String?

let customBlueColor = UIColor(red: 21/255, green: 101/255, blue: 192/255, alpha: 1)
let customGreenColor = UIColor(red: 38/255, green: 196/255, blue: 133/255, alpha: 1)
let checkmarkImage = UIImage(named: "checkmark")
let addImage = UIImage(named: "add")

let timeIntervalArr = ["Today", "Last 7 days", "Last 30 days"]
let sortedByArr = ["Popularity", "Newest"]
let languageArr = ["Русский", "English", "Deutch"]

let sortedByDictionary = ["Popularity":"popularity", "Newest":"publishedAt"]
let languageDictionary = ["Русский":"ru", "English":"en", "Deutch":"de"]

struct FeedModel {
    var massNews = [article]()
}

var sourcesArr: [Sources] = []
var subs: [Subscriptions] = []

struct News: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [article]?
}

struct article: Decodable {
    let source: magazine?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct magazine: Decodable {
    let id: String?
    let name: String?
}

struct SourcesStruct: Decodable {
    let status: String?
    let sources: [Source]?
}

struct Source: Decodable {
    let id: String?
    let name: String?
    let description: String?
    let url: String?
    let category: String?
    let language: String?
    let country: String?
}
