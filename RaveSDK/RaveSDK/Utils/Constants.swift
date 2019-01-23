//
//  Constants.swift
//  GetBarter
//
//  Created by Olusegun Solaja on 30/07/2018.
//  Copyright © 2018 Olusegun Solaja. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
enum DateFilter:String {
    case thisMonth = "Last 30 Days"
    case yesterday = "Yesterday"
    case today = "Today"
    case thisWeek = "Last 7 Days"
    case allTime = "All Time"
}
class Constants: NSObject {
    var acceptableStatusCodes:[Int] = Array(200..<300)
    
    override init() {
        acceptableStatusCodes.append(400)
        acceptableStatusCodes.append(500)
        acceptableStatusCodes.append(502)
        acceptableStatusCodes.append(1002)
        acceptableStatusCodes.append(1005)
    }
    static let merchantId = Bundle.main.infoDictionary!["MERCHANT_ID"] as! String
    static let merchantSecret = Bundle.main.infoDictionary!["MERCHANT_SECRET"] as! String

    //Live
    static let staffPubKey = Bundle.main.infoDictionary!["STAFF_PUBLIC_KEY"] as! String
    static let staffSecretKey = Bundle.main.infoDictionary!["STAFF_SECRET_KEY"] as! String
    
    static let pubKey = Bundle.main.infoDictionary!["PUBLIC_KEY"] as! String
    static let secretKey = Bundle.main.infoDictionary!["SECRET_KEY"] as! String
 
    

   
    static let isRaveStaging =  Bundle.main.infoDictionary!["IS_LIVE"] as? String == .some("1") ? false : true
    static let contactListMaxCount = 2000
    static let shared = Constants()
 
   

    static let gender = ["Male","Female"]
    static let supportedCountryCurrencies = [(name: "Nigeria", countryCode: "NG", currencyCode: "NGN", phoneCode: "+234"),
                            (name: "Kenya", countryCode: "KE", currencyCode: "KES", phoneCode: "+254"),
                            (name: "Ghana", countryCode: "GH", currencyCode: "GHS", phoneCode: "+233"),
                            (name: "United States of America", countryCode: "US", currencyCode: "USD", phoneCode: "+1"),
                            (name: "Uganda", countryCode: "UG", currencyCode: "UGX", phoneCode: "+256"),
                            (name: "Tanzania", countryCode: "TZ", currencyCode: "TZS", phoneCode: "+255"),
                            (name: "United Kingdom", countryCode: "GB", currencyCode: "GBP", phoneCode: "+44"),
                            (name: "Europe", countryCode: "EU", currencyCode: "EUR", phoneCode: "+49")]
    
    
    static let UUIDValue = UIDevice.current.identifierForVendor!.uuidString
    static let airtime = (billerCode:"BIL099" , itemCode:"AT099")
    static let frequencies = [("One time",0),("Hourly",1),
                               ("Daily",2),("Weekly",3),
                               ("Monthly",4),("Yearly",5)]
    static let imageBaseURL = "https://flutterwavebarterdata.blob.core.windows.net/barter-images"
    static let brands = ["asos","airbnb","amazon","digital ocean","facebook",
                         "google","heroku","itunes","lyft","spotify","uber","netflix","namecheap",
                         "udacity","hbo"]
    static let brandColor = ["asos":"#141414","amazon":"#141414","uber":"#141414","itunes":"#141414",
                             "airbnb":"#FD5C63","digital ocean":"#141414","facebook":"#295295",
                             "google":"#141414","heroku":"#421B98","lyft":"#EA2B8C","spotify":"#1DB954",
                             "netflix":"#B1060F","namecheap":"#141414","udacity":"#02B3E4","hbo":"#141414"]
    static let accountType = ["Savings","Current"]
   
    static let transactionFilter:[DateFilter] = [.thisMonth,.yesterday,.today,.thisWeek,.allTime]
    //static let serialNumber = getSerialNumber()
    static let countries = ["BD": "880", "BE": "32", "BF": "226", "BG": "359", "BA": "387", "BB": "+1-246", "WF": "681", "BL": "590", "BM": "+1-441", "BN": "673", "BO": "591", "BH": "973", "BI": "257", "BJ": "229", "BT": "975", "JM": "+1-876", "BV": "", "BW": "267", "WS": "685", "BQ": "599", "BR": "55", "BS": "+1-242", "JE": "+44-1534", "BY": "375", "BZ": "501", "RU": "7", "RW": "250", "RS": "381", "TL": "670", "RE": "262", "TM": "993", "TJ": "992", "RO": "40", "TK": "690", "GW": "245", "GU": "+1-671", "GT": "502", "GS": "", "GR": "30", "GQ": "240", "GP": "590", "JP": "81", "GY": "592", "GG": "+44-1481", "GF": "594", "GE": "995", "GD": "+1-473", "GB": "44", "GA": "241", "SV": "503", "GN": "224", "GM": "220", "GL": "299", "GI": "350", "GH": "233", "OM": "968", "TN": "216", "JO": "962", "HR": "385", "HT": "509", "HU": "36", "HK": "852", "HN": "504", "HM": " ", "VE": "58", "PR": "+1-787 and 1-939", "PS": "970", "PW": "680", "PT": "351", "SJ": "47", "PY": "595", "IQ": "964", "PA": "507", "PF": "689", "PG": "675", "PE": "51", "PK": "92", "PH": "63", "PN": "870", "PL": "48", "PM": "508", "ZM": "260", "EH": "212", "EE": "372", "EG": "20", "ZA": "27", "EC": "593", "IT": "39", "VN": "84", "SB": "677", "ET": "251", "SO": "252", "ZW": "263", "SA": "966", "ES": "34", "ER": "291", "ME": "382", "MD": "373", "MG": "261", "MF": "590", "MA": "212", "MC": "377", "UZ": "998", "MM": "95", "ML": "223", "MO": "853", "MN": "976", "MH": "692", "MK": "389", "MU": "230", "MT": "356", "MW": "265", "MV": "960", "MQ": "596", "MP": "+1-670", "MS": "+1-664", "MR": "222", "IM": "+44-1624", "UG": "256", "TZ": "255", "MY": "60", "MX": "52", "IL": "972", "FR": "33", "IO": "246", "SH": "290", "FI": "358", "FJ": "679", "FK": "500", "FM": "691", "FO": "298", "NI": "505", "NL": "31", "NO": "47", "NA": "264", "VU": "678", "NC": "687", "NE": "227", "NF": "672", "NG": "234", "NZ": "64", "NP": "977", "NR": "674", "NU": "683", "CK": "682", "XK": "", "CI": "225", "CH": "41", "CO": "57", "CN": "86", "CM": "237", "CL": "56", "CC": "61", "CA": "1", "CG": "242", "CF": "236", "CD": "243", "CZ": "420", "CY": "357", "CX": "61", "CR": "506", "CW": "599", "CV": "238", "CU": "53", "SZ": "268", "SY": "963", "SX": "599", "KG": "996", "KE": "254", "SS": "211", "SR": "597", "KI": "686", "KH": "855", "KN": "+1-869", "KM": "269", "ST": "239", "SK": "421", "KR": "82", "SI": "386", "KP": "850", "KW": "965", "SN": "221", "SM": "378", "SL": "232", "SC": "248", "KZ": "7", "KY": "+1-345", "SG": "65", "SE": "46", "SD": "249", "DO": "+1-809 and 1-829", "DM": "+1-767", "DJ": "253", "DK": "45", "VG": "+1-284", "DE": "49", "YE": "967", "DZ": "213", "US": "1", "UY": "598", "YT": "262", "UM": "1", "LB": "961", "LC": "+1-758", "LA": "856", "TV": "688", "TW": "886", "TT": "+1-868", "TR": "90", "LK": "94", "LI": "423", "LV": "371", "TO": "676", "LT": "370", "LU": "352", "LR": "231", "LS": "266", "TH": "66", "TF": "", "TG": "228", "TD": "235", "TC": "+1-649", "LY": "218", "VA": "379", "VC": "+1-784", "AE": "971", "AD": "376", "AG": "+1-268", "AF": "93", "AI": "+1-264", "VI": "+1-340", "IS": "354", "IR": "98", "AM": "374", "AL": "355", "AO": "244", "AQ": "", "AS": "+1-684", "AR": "54", "AU": "61", "AT": "43", "AW": "297", "IN": "91", "AX": "+358-18", "AZ": "994", "IE": "353", "IbD": "62", "UA": "380", "QA": "974", "MZ": "258"]
    
    class func baseURL () -> String{
        return Bundle.main.infoDictionary!["API_ENDPOINTS"] as! String
        
        //Live Pilot
//        return "https://pilot-barter.azurewebsites.net/api/v1"
        //Test
//        return "http://confluence-dev.azurewebsites.net/api/v1"
    }
    
    class func relativeURL()->Dictionary<String,String>{
        return ["REGISTER":"/barter/signup",
                "LOGIN":"/barter/login",
                "LOGIN_CHECK":"/barter/login/check",
                "REFRESH_TOKEN":"/barter/refresh-token/:token",
                "CONFIRM_MOBILE_NUMBER":"/barter/signup/confirm-mobile-number",
                "LINK_BARTER_USER":"/barter/social-signup",
                "BILL_CATEGORIES":"/barter/bills/categories",
                "FEATURED_BILL_CATEGORIES":"/barter/bills/categories/featured",
                "BILL_PRODUCT_DETAIL":"/barter/bills/products/:productId",
                "BILL_ACCOUNT_RESOLVE":"/barter/bills/resolve/:itemCode/:billerCode",
                "PAY_BILLS":"/barter/bills/pay",
                "PIN":"/barter/profile/pin",
                "VALIDATE_BVN":"/barter/profile/bvn/validate",
                "COMPLETE_VALIDATE_BVN":"/barter/profile/bvn/validate/complete",
                "FORGOT_PASSWORD":"/barter/profile/forgot-password",
                "FORGOT_PASSWORD_COMPLETE":"/barter/profile/forgot-password/complete",
                "CHANGE_PASSWORD":"/barter/profile/change-password",
                "FIND_PEOPLE":"/barter/people/find",
                "PEOPLE_RESOLVE":"/barter/people/resolve/simple",
                "SEND_MONEY":"/barter/send/money",
                "CONVERSION_RATES":"/barter/send/money/rates/convert",
                "INIT_FUND_WALLET":"/barter/wallets/fund/:amountInMinor",
                "COMPLETE_FUND_WALLET":"/barter/wallets/fund/end/:reference",
                "INIT_REQUEST_MONEY":"/barter/request/money",
                "COMPLETE_REQUEST_MONEY":"/barter/request/money/complete",
                "TRANSACTIONS":"/barter/spendings/new",
                "GET_TAGS":"/barter/spendings/tags",
                "MONEY_REQUEST_TO_YOU":"/barter/request/money/to-you",
                "TAG_TRANSACTION":"/barter/spendings/transaction/tag",
                "ME":"/barter/profile/me",
                "PROFILE_UPDATE":"/barter/profile/update",
                "PROFILE_PHOTO_UPDATE":"/barter/profile/photo/update",
                "BANKS":"/barter/banks/:country",
                "ACCOUNT_RESOLVE":"/barter/send/money/account/resolve",
                "BENEFICIARIES":"/barter/send/money/beneficiaries",
                "GET_SUMMARY_TAG":"/barter/spendings/tag/summary",
                "GET_CARDS":"/barter/cards",
                "CREATE_CARD":"/barter/cards/create",
                "CARD_TRANSACTIONS":"/barter/cards/transactions",
                "TERMINATE_CARD":"/barter/cards/terminate/:id",
                "FUND_CARD":"/barter/cards/fund",
                "FREEZE_CARD":"/barter/cards/status/:blockOperation/:id",
                "CONFIRM_TERMINATE_CARD":"/barter/cards/terminate/confirm/:cardId",
                "LOAN_CREDIT_ELIGIBILTY":"/barter/loan/eligibility/:amountInMinor",
                "APPLY_LOAN":"/barter/loan/apply",
                "ADD_ACCOUNT":"/barter/profile/account/add",
                "RECURRING_TRANSACTIONS":"/barter/spendings/new/recurring",
                "RELATED_TRANSACTIONS":"/barter/spendings/new/related/:referenceId",
                "RECURRING_ACTIONS":"/barter/spendings/new/recurring/action",
                "MERCHANT_RESOLVE":"/barter/pay/merchant/resolve/:id",
                "RECENT_MERCHANTS":"/barter/pay/merchant/recent",
                "MERCHANT_PAY":"/barter/pay/merchant",
                "COUNTRIES":"/barter/countries",
                "GET_JUMIO_REFERENCE":"/barter/verify/reference",
                "JUMIO_REFERENCE_UPDATE":"/barter/verify/update",
                "PAY_WITH_MVISA":"/barter/pay/merchant/mvisa",
                "FEATURED_MERCHANTS":"/barter/merchants/featured",
                "RECENT_BILLS":"/barter/bills/recent",
                "ADD_NOTE":"/barter/spendings/note/manage",
                "GET_PEOPLE_TO_INVITE":"/barter/contacts/invitations",
                "INVITE_PERSON":"/barter/contacts/invite",
                "GET_PLANS":"/barter/plans",
                "CHANGE_PLAN":"/barter/plan/change",
                "UPDATE_NOTE":"/barter/spendings/note/manage",
                "DELETE_BENEFICIARY":"/barter/send/money/beneficiaries/delete/:id",
                "VOICE_CALL":"/barter/otp/voice/request",
                "SEND_MONEY_CONVERSION":"/barter/send/money/people/resolve",
                "RESOLVE_BRANCH_CODE":"/barter/banks/branches/:id",
                "ADD_NFC_CARD":"/barter/nfc/customer/updatecardid"
            ]
    }
    
    
    class func getWhatsappOTP(){
        var url = URL(string: "https://api.whatsapp.com/send?phone=+2348138885554&text=otp")!
        if !UIApplication.shared.canOpenURL(url){
            url = URL(string: "https://itunes.apple.com/ng/app/whatsapp-messenger/id310633997?mt=8")!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }else{
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
    func makeNavigationBarTransparent(_ controller: UIViewController){
        controller.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        controller.navigationController?.navigationBar.shadowImage = UIImage()
        controller.navigationController?.navigationBar.isTranslucent = true
        controller.navigationController?.navigationBar.barTintColor = .white
        controller.navigationController?.navigationBar.tintColor = .white
    }
    
   

}
