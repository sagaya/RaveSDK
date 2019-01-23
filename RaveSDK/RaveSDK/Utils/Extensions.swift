//
//  Extensions.swift
//  GetBarter
//
//  Created by Segun Solaja on 5/23/17.
//  Copyright © 2017 Segun Solaja. All rights reserved.
//

import Foundation
import UIKit
import Accelerate
//import JTHamburgerButton
//import PopupDialog
//import SwiftKeychainWrapper
//import KeychainSwift
//import Lottie
import Contacts
//import CryptoSwift
//import SwiftyRSAa
//import CoreLocation
import AVFoundation
import Alamofire
enum PointCorners{
    case topLeft,topRight,bottomLeft,bottomRight
}

//let keychain = KeychainWrapper(serviceName: Bundle.main.bundleIdentifier!, accessGroup: "com.barter")
func dividerLayer(textField:UIView,color:UIColor = UIColor.white, lineWidth:CGFloat = 1){
    let layer = CALayer()
    layer.backgroundColor = color.cgColor
    layer.setValue("line", forKey: "line")
    layer.frame = CGRect(x: 0, y: textField.frame.height - lineWidth, width: textField.frame.width, height: lineWidth)
    textField.layer.addSublayer(layer)
}
func isValidEmail(testStr:String) -> Bool {
    print("validate emilId: \(testStr)")
    let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    let result = emailTest.evaluate(with: testStr)
    return result
}

func isValidPhone(value: String) -> Bool {
    let PHONE_REGEX = "^((\\+)|(0))[0-9]{6,14}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    let result =  phoneTest.evaluate(with: value)
    return result
}

func getPointOnCircle(_ radius:CGFloat,rectSize:CGSize, cornerPoint:PointCorners = .topRight) -> CGPoint{
    var point = CGPoint()
    switch cornerPoint {
    case .topLeft:
        let y = ceil(Double(radius) - (sin(Double.pi/4) * Double(radius)))
        point = CGPoint(x: CGFloat(y) ,y: CGFloat(y))
    case .topRight:
        let y = ceil(Double(radius) - (sin(Double.pi/4) * Double(radius)))
        let x = rectSize.width  - (CGFloat(y))
        point = CGPoint(x: x ,y: CGFloat(y))
    case .bottomLeft:
        let y = ceil(Double(radius) + (sin(Double.pi/4) * Double(radius)))
        let x = rectSize.width  - (CGFloat(y))
        point = CGPoint(x: x ,y: CGFloat(y))
    case .bottomRight:
        let y = ceil(Double(radius) + (sin(Double.pi/4) * Double(radius)))
        let dy = ceil(Double(radius) - (sin(Double.pi/4) * Double(radius)))
        let x = rectSize.width  - (CGFloat(dy))
        point = CGPoint(x: x ,y: CGFloat(y))
    
    }
    
    return point
    
}


func isFestivePeriod() -> Bool{
    
    let calendar = Calendar.current
    var components = calendar.dateComponents([.year,.month,.day], from: Date())
    let year = calendar.component(.year, from: Date())
    components.day = 20
    components.year = year
    components.month = 12
    
    let beginDate = calendar.date(from: components)
    
    let lastCalendar = Calendar.current
    var lastComponent = calendar.dateComponents([.year,.month,.day], from: Date())
    lastComponent.day = 31
    lastComponent.year = year
    lastComponent.month = 12
    
    let endDate = calendar.date(from: lastComponent)
    let now = Date()
    let range = beginDate!...endDate!
    if range.contains(now) {
        return true
    } else {

        return false
    }
    return false
}

// Usage: insert view.pushTransition right before changing content
extension UIView {
    func pushTransition(_ duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromTop
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}
func getPhoneContact() -> [(String,String)]{
    let contactStore = CNContactStore()
    var contacts = [CNContact]()
    var phoneNumbers:[(String,String)] = []
    let keys = [
        CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
        CNContactPhoneNumbersKey,
        CNContactEmailAddressesKey
        ] as [Any]
    let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
    do {
        try contactStore.enumerateContacts(with: request){
            (contact, stop) in
            // Array containing all unified contacts from everywhere
            contacts.append(contact)
            for phoneNumber in contact.phoneNumbers {
            
                if let number = phoneNumber.value as? CNPhoneNumber, let _ = phoneNumber.label {
                   // let localizedLabel = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: label)
                    let charactersAllow = CharacterSet(charactersIn: "+1234567890")
                    var trimmedLabel = number.stringValue.components(separatedBy: charactersAllow.inverted).joined().replacingOccurrences(of: " ", with: "")
                    print("\(contact.givenName) \(contact.familyName) tel:\(trimmedLabel) -- \(number.stringValue), email: \(contact.emailAddresses)")
                    let name = "\(contact.givenName) \(contact.familyName)"
                    if name.containsIgnoringCase(find: "Joe Ghana"){
                        print("this is demi")
                    }
                    if(NSPredicate(format: "SELF MATCHES %@", "^[+]{1}[0-9]{12,14}$").evaluate(with: trimmedLabel)){
                        trimmedLabel = String(trimmedLabel.dropFirst())
                    }
                    if(NSPredicate(format: "SELF MATCHES %@", "^[0]{1}[7|8|9]{1}[0-9]{9}$").evaluate(with: trimmedLabel)){
                        trimmedLabel = "234" + String(trimmedLabel.dropFirst())
                    }
                    if(NSPredicate(format: "SELF MATCHES %@", "^[0]{1}[7|8|9]{1}[0-9]{9}$").evaluate(with: trimmedLabel)){
                        trimmedLabel = "234" + String(trimmedLabel.dropFirst())
                    }
                    if(NSPredicate(format: "SELF MATCHES %@", "^[+]{1}(234)[7|8|9]{1}[0-9]{9}$").evaluate(with: trimmedLabel)){
                        trimmedLabel = String(trimmedLabel.dropFirst())
                    }
                    phoneNumbers.append((trimmedLabel,name))
                }
            }
        }
       // print(contacts)
    } catch {
        print("unable to fetch contacts")
    }
    return phoneNumbers
}



func convertStringToDictionary(json: String) -> [String: AnyObject]? {
    if let data = json.data(using: String.Encoding.utf8) {
        let json =  try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
        
        return json as? [String : AnyObject]
    }
    return nil
}

extension UIButton{
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 0.95
        pulse.toValue = 1.5
        pulse.initialVelocity = 0.2
        pulse.damping = 1.0
        layer.add(pulse, forKey: "pulse")
    }
    func smallPulse() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.5
        pulse.fromValue = 0.95
        pulse.toValue = 0.97
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: "pulse")
    }
}

//extension UILabel {
//    func shake() {
//        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
//        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
//        animation.duration = 0.6
//        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
//        layer.add(animation, forKey: "shake")
//        let generator = UIImpactFeedbackGenerator(style: .medium)
//        generator.impactOccurred()
//    }
//}



func playPopSound(){
    if let soundURL = Bundle.main.url(forResource: "Pop", withExtension: "caf") {
        var mySound: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &mySound)
        // Play
        AudioServicesPlaySystemSound(mySound);
    }
}
func playPop2Sound(){
    if let soundURL = Bundle.main.url(forResource: "Pop2", withExtension: "caf") {
        var mySound: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &mySound)
        // Play
        AudioServicesPlaySystemSound(mySound);
    }
}

func makeNavigationBarTransparent(navigationController:UINavigationController?){
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
    navigationController?.navigationBar.barTintColor = .white
    navigationController?.navigationBar.tintColor = .white
}


//func getSerialNumber() -> String{
//    let keychain = KeychainSwift()
//    if let serialNumber =  keychain.get("barter-serial"){
//        return serialNumber
//    }else{
//        let serial = "barter_ios_\(Int(arc4random()))_\(Date().timeIntervalSince1970)"
//        keychain.set(serial, forKey: "barter-serial")
//        return serial
//    }
//}
func giveHaptic(){
    let generator = UIImpactFeedbackGenerator(style: .medium)
    generator.impactOccurred()
}
func lightHaptic(){
    let generator = UIImpactFeedbackGenerator(style: .light)
    generator.impactOccurred()
}
 
//func getLocationManager<T: UIViewController>(_ controller:T)->CLLocationManager where T: CLLocationManagerDelegate{
//    let locationManager = CLLocationManager()
//    locationManager.delegate = controller
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    locationManager.distanceFilter = 1;
//
//    return locationManager
//}

//func resetController(){
//    let storyBoard = UIStoryboard(name: "Main2", bundle: nil)
//    let signupSignInVC = storyBoard.instantiateViewController(withIdentifier: "signupNav") as! UINavigationController
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    appDelegate.window?.rootViewController = signupSignInVC
//}

//func showMessageDialog (_ title:String, message:String , image:UIImage?, axis:UILayoutConstraintAxis,viewController:UIViewController, handler:(() -> Void)?){
//    let popUp = PopupDialog(title: title, message: message, image: image, buttonAlignment: axis, transitionStyle: PopupDialogTransitionStyle.zoomIn, gestureDismissal: true, completion: handler)
//
//    if let  _ = handler{
//        let button =  DefaultButton(title: "OK"){
//           handler!()
//        }
//        popUp.addButtons([button])
//    }
//
//
//    _ = viewController.present(popUp, animated: true)
//}
//
enum Style{
    case  success , error
    
}
func showSnackBarWithMessage(msg: String, style:Style = .success,autoComplete:Bool = false, completion:(()-> Void)? = nil){
    if autoComplete{
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion?()
        }
    }
    let snack = SnackBar.shared
    snack.message = msg
    
    switch style{
    case .success:
        snack.statusColor = UIColor(hex: "#397A7F")
    case .error:
        snack.statusColor = UIColor(hex: "#9C4A47")
    }
    
    snack.show()
//    let action = MDCSnackbarMessageAction()
//    let actionHandler = completion
//    action.handler = actionHandler
//    action.title = "Okay"
//
//    if autoComplete{
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//             completion?()
//        }
//    }
//
//    let message = MDCSnackbarMessage()
//    message.text = msg
//    message.action = action
//    MDCSnackbarManager.buttonFont = UIFont.boldSystemFont(ofSize: 13)
//    MDCSnackbarManager.setButtonTitleColor(.white, for: .normal)
//    switch style{
//
//    case .success:
//        MDCSnackbarManager.snackbarMessageViewBackgroundColor = UIColor(hex: "#397A7F")
//    case .error:
//        MDCSnackbarManager.snackbarMessageViewBackgroundColor = UIColor(hex: "#9C4A47")
//
//    }
//    //MDCSnackbarManager.snackbarMessageViewBackgroundColor = UIColor(hex: "#417505")
//    MDCSnackbarManager.show(message)
}


func getFormattedPhone(phone:String , code:String) -> String{
    if (phone.hasPrefix(code) || phone.hasPrefix("+") ){
        return phone
    }else if(phone.first! == "0"){
        let ph = String(phone.dropFirst())
        return "\(code)\(ph)"
    }
    else{
       // let ph = String(phone.characters.dropFirst())
        return "\(code)\(phone)"
    }
}
func getDateFromString(_ str:String, withFormat:String) -> Date?{
    let dateFormatter  = DateFormatter()
    dateFormatter.dateFormat = withFormat
    let date = dateFormatter.date(from: str)
    return date
}
extension UIStackView {
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        if secondsAgo < minute {
            return "\(secondsAgo) seconds ago"
        }
            
        else if secondsAgo < hour {
            return "\(secondsAgo / minute) minutes ago"
        }
        else if secondsAgo < day {
            if (secondsAgo / hour == 1 ){
               return "\(secondsAgo / hour) hour ago"
            }else{
               return "\(secondsAgo / hour) hours ago"
            }

        }
        else if secondsAgo < week {
            return "\(secondsAgo / day) days ago"
        }
        return "\(secondsAgo / week) weeks ago"
    }
}
extension Array {
    func toDictionary<K,V>() -> [K:V] where Iterator.Element == (K,V) {
        return self.reduce([:]) {
            var dict:[K:V] = $0
            dict[$1.0] = $1.1
            return dict
        }
    }
}

extension Dictionary {
    mutating func merge<K, V>(_ dict: [K: V]){
        for (k, v) in dict {
            self.updateValue(v as! Value, forKey: k as! Key)
        }
    }
   
    init(_ slice: Slice<Dictionary>) {
            self = [:]
            
            for (key, value) in slice {
                self[key] = value
            }
    }
        

    
}
extension UIImage {
    convenience init(view: UIView, size:CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }
}
extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Int {
  var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
extension FloatingPoint {
  var degreesToRadians: Self { return self * .pi / 180 }
  var radiansToDegrees: Self { return self * 180 / .pi }
}


extension NSAttributedString {
    static func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString
    {
        let result = NSMutableAttributedString()
        result.append(left)
        result.append(right)
        return result
    }

}

extension UITextView {
    func hyperLink(originalText: String, hyperLinkTextAndURL: [(String,String)]) {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let attributedOriginalText = NSMutableAttributedString(string: originalText)
        hyperLinkTextAndURL.forEach { (text, url) in
            let linkRange = attributedOriginalText.mutableString.range(of: text)
            let fullRange = NSMakeRange(0, attributedOriginalText.length)
            attributedOriginalText.addAttribute(NSAttributedString.Key.link, value: url, range: linkRange)
            attributedOriginalText.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: fullRange)
            attributedOriginalText.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 14), range: fullRange)
//            self.linkTextAttributes = [
//                NSAttributedString.Key.foregroundColor.rawValue: UIColor(hex:"#1282E1"),
//                NSAttributedString.Key.font.rawValue: UIFont.boldSystemFont(ofSize: 14),
//                NSAttributedString.Key.underlineStyle.rawValue: NSUnderlineStyle.single.rawValue
//            ]
        }
       
        self.attributedText = attributedOriginalText
    }
}
extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        let border = CALayer()
        switch edge {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
        case .bottom:
            border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
        default:
            break
        }
        border.backgroundColor = color.cgColor
        addSublayer(border)
    }
}
extension Bundle {
    
    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T? {
        return Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T
    }
}
extension NSMutableAttributedString
{
    enum scripting : Int
    {
        case aSub = -1
        case aSuper = 1
    }
    
    func characterSubscriptAndSuperscript(string:String,
                                          characters:[Character],
                                          type:scripting,
                                          fontSize:CGFloat,
                                          scriptFontSize:CGFloat,
                                          offSet:Int,
                                          length:[Int],
                                          alignment:NSTextAlignment)-> NSMutableAttributedString
    {
        let paraghraphStyle = NSMutableParagraphStyle()
        // Set The Paragraph aligmnet , you can ignore this part and delet off the function
        paraghraphStyle.alignment = alignment
        
        var scriptedCharaterLocation = Int()
        //Define the fonts you want to use and sizes
        let stringFont = UIFont.boldSystemFont(ofSize: fontSize)
        let scriptFont = UIFont.boldSystemFont(ofSize: scriptFontSize)
        // Define Attributes of the text body , this part can be removed of the function
        let attString = NSMutableAttributedString(string:string, attributes: [NSAttributedString.Key.font:stringFont,NSAttributedString.Key.foregroundColor:UIColor.black,NSAttributedString.Key.paragraphStyle: paraghraphStyle])
        
        // the enum is used here declaring the required offset
        let baseLineOffset = offSet * type.rawValue
        // enumerated the main text characters using a for loop
        for (i,c) in string.enumerated()
        {
            // enumerated the array of first characters to subscript
            for (theLength,aCharacter) in characters.enumerated()
            {
                if c == aCharacter
                {
                    // Get to location of the first character
                    scriptedCharaterLocation = i
                    //Now set attributes starting from the character above
                    attString.setAttributes([NSAttributedString.Key.font:scriptFont,
                                             // baseline off set from . the enum i.e. +/- 1
                        NSAttributedString.Key.baselineOffset:baseLineOffset,
                        NSAttributedString.Key.foregroundColor:UIColor.black],
                                            // the range from above location
                        range:NSRange(location:scriptedCharaterLocation,
                                      // you define the length in the length array
                            // if subscripting at different location
                            // you need to define the length for each one
                            length:length[theLength]))
                    
                }
            }
        }
        return attString}
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    func currencyAttributedDecimalPlaces(_ mainTextSize:Float = 24.0, _ decimalTextSize:Float = 13.0, _ currencyTextSize:Float = 13.0 ,withColor:UIColor = UIColor(hex: "#4A4A4A")) -> NSAttributedString{
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(mainTextSize), weight: UIFont.Weight.semibold),
            NSAttributedString.Key.kern: 0.3
            ], range: NSRange(location: self.count - 3, length: 1))
        attributedString.addAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(decimalTextSize), weight: UIFont.Weight.semibold),
            NSAttributedString.Key.kern: 0.2,
            NSAttributedString.Key.foregroundColor: withColor
            ], range: NSRange(location: self.count - 2, length: 2))
        attributedString.addAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(currencyTextSize), weight: UIFont.Weight.semibold),
            NSAttributedString.Key.kern: 0.1,
            NSAttributedString.Key.baselineOffset:5,
            NSAttributedString.Key.foregroundColor: withColor
            ], range: NSRange(location:0, length: 1))
        return attributedString
    }
    func attributedDecimalPlaces(_ mainTextSize:Float = 36.0, _ decimalTextSize:Float = 15.0 ) -> NSAttributedString{
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(mainTextSize), weight: UIFont.Weight.semibold),
            NSAttributedString.Key.kern: 0.3
            ], range: NSRange(location: self.count - 3, length: 1))
        attributedString.addAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(decimalTextSize), weight: UIFont.Weight.semibold),
            NSAttributedString.Key.kern: 0.2
            ], range: NSRange(location: self.count - 2, length: 2))
        return attributedString
    }

    
    func toNaira(_ withFraction:Int = 0) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = withFraction
        formatter.locale = Locale(identifier: "ig_NG")
        if self == ""{
            return formatter.string(from: NSNumber(value: 0))!
        }else{
            let val = (self as NSString).doubleValue
            return formatter.string(from: NSNumber(value: val))!
        }
    }
    
    func toCurrency(_ withFraction:Int = 0, identifier:String = "ig_NG" ) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = withFraction
        
        formatter.locale = Locale(identifier: identifier)
        if self == ""{
            return formatter.string(from: NSNumber(value: 0))!
        }else{
            let val = (self as NSString).doubleValue
            return formatter.string(from: NSNumber(value: val))!
        }
    }
    func toCountryLocalCurrency(code:String, fraction:Int = 2) -> String{
        var str:String = ""
        switch code {
        case "NGN":
            str = self.toCurrency(fraction)
        case "USD":
            str = self.toCurrency(fraction,identifier:"en_US")
        case "GBP":
            str = self.toCurrency(fraction,identifier:"en_GB")
        case "KES":
            str = self.toCurrency(fraction,identifier:"kam_KE")
        case "GHS":
            str = self.toCurrency(fraction,identifier:"ak_GH")
        case "ZAR":
            str = self.toCurrency(fraction, identifier: "en_ZA")
        default:
            str = self.toCurrency(fraction)
        }
        return str
    }
    func countryLocalCurrency(code:String, fraction:Int = 2) -> String{
        var str:String = ""
        switch code {
        case "NG":
            str = self.toCurrency(fraction)
        case "US":
            str = self.toCurrency(fraction,identifier:"en_US")
        case "GB":
            str = self.toCurrency(fraction,identifier:"en_GB")
        case "KE":
            str = self.toCurrency(fraction,identifier:"kam_KE")
        case "GH":
            str = self.toCurrency(fraction,identifier:"ak_GH")
        case "ZA":
            str = self.toCurrency(fraction, identifier: "en_ZA")
        default:
            str = self.toCurrency(fraction)
        }
        return str
    }

  
    
}



extension UILabel {
    func addCharactersSpacing(spacing:CGFloat, text:String) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttributes([NSAttributedString.Key.kern : spacing], range: NSMakeRange(0, text.count))
        self.attributedText = attributedString
    }
    
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        
        // (Swift 4.1 and 4.0) Line spacing attribute
        //attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }


}

extension VSTextField {
    func addCharactersSpacing(spacing:CGFloat) {
        let attributedString = NSMutableAttributedString(string: self.text)
        attributedString.addAttributes([NSAttributedString.Key.kern : spacing], range: NSMakeRange(0, self.text.count))
        self.attributedText = attributedString
    }
}
extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
        
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [CIContextOption.workingColorSpace: kCFNull])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: CIFormat.RGBA8, colorSpace: nil)
        
        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
    
    func resizeImageUsingVImage(size:CGSize) -> UIImage? {
        let cgImage = self.cgImage!
        var format = vImage_CGImageFormat(bitsPerComponent: 8, bitsPerPixel: 32, colorSpace: nil, bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.first.rawValue), version: 0, decode: nil, renderingIntent: CGColorRenderingIntent.defaultIntent)
        var sourceBuffer = vImage_Buffer()
        defer {
            free(sourceBuffer.data)
        }
        var error = vImageBuffer_InitWithCGImage(&sourceBuffer, &format, nil, cgImage, numericCast(kvImageNoFlags))
        guard error == kvImageNoError else { return nil }
        // create a destination buffer
        let scale = self.scale
        let destWidth = Int(size.width)
        let destHeight = Int(size.height)
        let bytesPerPixel = self.cgImage!.bitsPerPixel/8
        let destBytesPerRow = destWidth * bytesPerPixel
        let destData = UnsafeMutablePointer<UInt8>.allocate(capacity: destHeight * destBytesPerRow)
        defer {
            destData.deallocate(capacity: destHeight * destBytesPerRow)
        }
        var destBuffer = vImage_Buffer(data: destData, height: vImagePixelCount(destHeight), width: vImagePixelCount(destWidth), rowBytes: destBytesPerRow)
        // scale the image
        error = vImageScale_ARGB8888(&sourceBuffer, &destBuffer, nil, numericCast(kvImageHighQualityResampling))
        guard error == kvImageNoError else { return nil }
        // create a CGImage from vImage_Buffer
        var destCGImage = vImageCreateCGImageFromBuffer(&destBuffer, &format, nil, nil, numericCast(kvImageNoFlags), &error)?.takeRetainedValue()
        guard error == kvImageNoError else { return nil }
        // create a UIImage
        let resizedImage = destCGImage.flatMap { UIImage(cgImage: $0, scale: 0.0, orientation: self.imageOrientation) }
        destCGImage = nil
        return resizedImage
    }
}
extension UITableView {
    func reloadData(with animation: UITableView.RowAnimation) {
        reloadSections(IndexSet(integersIn: 0..<numberOfSections), with: animation)
    }
}

 extension UIColor {
  convenience init(hex: String) {
    var red:   CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue:  CGFloat = 0.0
    var alpha: CGFloat = 1.0
    var hex:   String = hex
    
    if hex.hasPrefix("#") {
      let index   = hex.index(hex.startIndex, offsetBy: 1)
      hex         = hex.substring(from: index)
    }
    
    let scanner = Scanner(string: hex)
    var hexValue: CUnsignedLongLong = 0
    if scanner.scanHexInt64(&hexValue) {
      switch (hex.count) {
      case 3:
        red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
        green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
        blue  = CGFloat(hexValue & 0x00F)              / 15.0
      case 4:
        red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
        green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
        blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
        alpha = CGFloat(hexValue & 0x000F)             / 15.0
      case 6:
        red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
        green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
        blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
      case 8:
        red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
        green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
        blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
        alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
      default:
        print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
      }
    } else {
      print("Scan hex error")
    }
    self.init(red:red, green:green, blue:blue, alpha:alpha)
  }
}
extension UIView{
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        let layer = self.layer
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowPath = UIBezierPath.init(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
        
        
        let backgroundCGColor = self.backgroundColor?.cgColor
        self.backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}
extension Notification.Name {
    static let percentage = Notification.Name("uploadPercentage")
    static let current_badge_count = Notification.Name("current_badge_count")
}

extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
extension UIView{
    func fillSuperView(){
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    func centerInView(size: CGSize){
        anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: size, centerX: superview?.centerXAnchor, centerY: superview?.centerYAnchor)
    }
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero, centerX:NSLayoutXAxisAnchor? = nil, centerY:NSLayoutYAxisAnchor? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let centerX = centerX{
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let centerY = centerY{
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
extension UITextField{
    func addLabelTop(text: String){
        var label = UILabel()
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor(hex: "#4a4a4a")
        addSubview(label)
        addleftViewSpace()
        label.anchor(top: nil, leading: leadingAnchor, bottom: topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 3, right: 0), size: .init(width: frame.width, height: 30))
    }
    func addleftViewSpace(){
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 0, y: 0, width: 5, height: frame.height))
        leftView = iconContainerView
        leftViewMode = .always
    }
}
