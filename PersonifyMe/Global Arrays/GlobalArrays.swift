//
//  GlobalArrays.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 03/08/2023.
//

import Foundation

struct GlobalArrays {
    
    static var  currencySymbols: [String: String] = [
        "USD": "$",   // US Dollar
        "EUR": "€",   // Euro
        "JPY": "¥",   // Japanese Yen
        "GBP": "£",   // British Pound
        "AUD": "A$",  // Australian Dollar
        "CAD": "C$",  // Canadian Dollar
        "CHF": "CHF", // Swiss Franc
        "CNY": "¥",   // Chinese Yuan
        "SEK": "kr",  // Swedish Krona
        "NZD": "NZ$", // New Zealand Dollar
        "MXN": "$",   // Mexican Peso
        "SGD": "S$",  // Singapore Dollar
        "HKD": "HK$", // Hong Kong Dollar
        "NOK": "kr",  // Norwegian Krone
        "KRW": "₩",   // South Korean Won
        "TRY": "₺",   // Turkish Lira
        "RUB": "₽",   // Russian Ruble
        "INR": "₹",   // Indian Rupee
        "BRL": "R$",  // Brazilian Real
        "ZAR": "R",   // South African Rand
    ]
   
    
    static var countries = [
        ("🇦🇺 Australia", "AU"),
        ("🇦🇹 Austria", "AT"),
        ("🇧🇪 Belgium", "BE"),
        ("🇧🇷 Brazil", "BR"),
        ("🇧🇬 Bulgaria", "BG"),
        ("🇨🇦 Canada", "CA"),
        ("🇨🇾 Cyprus", "CY"),
        ("🇨🇿 Czech Republic", "CZ"),
        ("🇩🇰 Denmark", "DK"),
        ("🇪🇪 Estonia", "EE"),
        ("🇫🇮 Finland", "FI"),
        ("🇫🇷 France", "FR"),
        ("🇩🇪 Germany", "DE"),
        ("🇬🇷 Greece", "GR"),
        ("🇭🇰 Hong Kong", "HK"),
        ("🇭🇺 Hungary", "HU"),
        ("🇮🇳 India", "IN"),
        ("🇮🇪 Ireland", "IE"),
        ("🇮🇹 Italy", "IT"),
        ("🇯🇵 Japan", "JP"),
        ("🇱🇻 Latvia", "LV"),
        ("🇱🇹 Lithuania", "LT"),
        ("🇱🇺 Luxembourg", "LU"),
        ("🇲🇹 Malta", "MT"),
        ("🇲🇽 Mexico", "MX"),
        ("🇳🇱 Netherlands", "NL"),
        ("🇳🇿 New Zealand", "NZ"),
        ("🇳🇴 Norway", "NO"),
        ("🇵🇱 Poland", "PL"),
        ("🇵🇹 Portugal", "PT"),
        ("🇷🇴 Romania", "RO"),
        ("🇸🇬 Singapore", "SG"),
        ("🇸🇰 Slovakia", "SK"),
        ("🇸🇮 Slovenia", "SI"),
        ("🇪🇸 Spain", "ES"),
        ("🇸🇪 Sweden", "SE"),
        ("🇨🇭 Switzerland", "CH"),
        ("🇹🇭 Thailand", "TH"),
        ("🇬🇧 United Kingdom", "GB"),
        ("🇺🇸 United States", "US")
    ]
}

struct GlobalTexts{
    
    static var  returnPolicies = """
    \( "\u{2022}") Returns and exchanges 30 days
    \( "\u{2022}") Buyer can return or exchange this item
    \( "\u{2022}") Buyer must return item within 30 days of delivery
    \( "\u{2022}") Buyer is responsible for return postage costs
    \( "\u{2022}") Buyer is responsible for loss in value (as agreed upon with seller) if an item isn’t returned in original condition
    """

    static var placeHolder  = """
    New customized necklace gives you a totally unique look. It's your personal statement in perfectly crafted, solid bubble font. Pair it with other pendants or tennis necklaces for an even bolder statement.New customized necklace gives you a totally unique look. It’s your personal statement in perfectly crafted, solid bubble font. Pair it with other pendants or tennis necklaces for an even bolder statement.
    """
    
    static var productionDelivery  = """
    Shipping & Production Time

    Our current turnaround time for the production is about 7-10 business days upon ordering. Every item we make is custom made from the heart and well worth the wait. Once it's   ready we will ship your item as soon as possible with trackable number.
    """
    
}
