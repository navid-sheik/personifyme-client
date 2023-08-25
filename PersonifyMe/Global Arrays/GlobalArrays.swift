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
    
    static var personlization = """
    Craft your unique item in minutes with these quick steps:
    \n  •Find Your Item: Pick your desired custom-made item.
    \n  •Select Options: Choose customization features.
    \n  •Personalization Box: Input your word, name, or initials.
    \n  •Optional Font: Specify a font number if available.
    \n  •Review and Checkout: Confirm details and proceed to payment.
    
    """
    
    
    
    
    static var ourguarantee = """
    At Shop Personify, your satisfaction is our utmost priority. We proudly stand by the quality and craftsmanship of each handcrafted, custom-made item we produce. Should you encounter any defects in craftsmanship or experience breakage, rest assured that we will either repair or replace your item. If your package gets lost in transit and doesn't arrive within the expected delivery time, simply email us and we'll start the remaking process for your order at no extra cost. For any other concerns, we're just an email or chat away and aim to resolve your issues as quickly as possible. Thank you for choosing Shop Personify, where your peace of mind is our guarantee.
    """
    
    static var productionDelivery  = """
    Our current turnaround time for the production is about 7-10 business days upon ordering. Every item we make is custom made from the heart and well worth the wait. Once it's   ready we will ship your item as soon as possible with trackable number.
    """
    
    
    static var faq = """
    Frequently Asked Questions (FAQs):
    \n• What is the Personalization Box?
    \n  It's a text field where you can enter the word, name, or initials you'd like to have featured on your custom item.
    \n• How do I specify a font?
    \n  If font options are available for your selected item, you can specify your preferred font by entering its number in the Personalization Box.
    \n• What if I forget to add some details during the ordering process?
    \n  Don't worry, just contact our customer service team via email or chat. We aim to respond within 24 hours to help finalize your order details.
    \n• What is covered in your guarantee?
    \n  We offer a guarantee on craftsmanship and breakage. If your item has defects or breaks, we will either repair or replace it. Additionally, if your package is lost in transit, we'll remake your order at no additional cost.
    \n• How long does it take to receive my order?
    \n  Shipping times vary depending on location and the shipping method chosen during checkout. Once your order is shipped, you'll receive a tracking number to monitor its progress.
    \n• Can I make changes to my order after it's been placed?
    \n  We start the crafting process quickly, so any changes must be communicated within a short timeframe. Contact us immediately if you need to make adjustments.
    \n• How can I track my order?
    \n  Once your order is dispatched, you'll receive a tracking number via email, which you can use to monitor your package's journey.
    \n• Do you ship internationally?
    \n  Yes, we do offer international shipping. Shipping rates and times vary by country and will be detailed during checkout.
    \n• What payment methods do you accept?
    \n  We accept all major credit cards, PayPal, and other popular payment methods which will be listed at checkout.
    \n• How do I contact customer service?
    \n  Our customer service team is reachable via email or chat and aims to respond within 24 hours for any queries or concerns you may have.

    """
}
