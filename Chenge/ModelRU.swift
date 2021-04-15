//
//  Model.swift
//  Chenge
//
//  Created by Aleksander Kulikov on 30.11.2020.
/*
import UIKit
//<NumCode>036</NumCode>
//<CharCode>AUD</CharCode>-----
//<Nominal>1</Nominal>   1*16.0102
//<Name>¿‚ÒÚ‡ÎËÈÒÍËÈ ‰ÓÎÎ‡</Name>
//<Value>16,0102</Value>-------
//http://www.cbr.ru/scripts/XML_daily.asp?date_req=02/03/2002


class Currency {
    var NumCode: String?
    var CharCode: String?
    var Name: String?
    
    var Nominal: String?
    var NominalDouble: Double?
    
    var Value: String?
    var ValueDouble: Double?
    
    var imageFlag:UIImage? {
        if let CharCode = CharCode {
            return UIImage(named: CharCode)
        }
        return nil
    }
    
    
    class func rouble () -> Currency {
        let r = Currency ()
        r.CharCode = "RUR"
        r.Name = "Росийский рубль"
        r.Nominal = "1"
        r.NominalDouble = 1
        r.Value = "1"
        r.ValueDouble = 1
        
        return r
        
    }
    
}

class ModelRU: NSObject, XMLParserDelegate {
    static let shared = ModelRU()
    
    var currencies: [Currency] = []
    var currentDate: String = ""
    
    var fromCurrency: Currency = Currency.rouble()
    var toCurrency: Currency = Currency.rouble()
    
    func convert(amount: Double?) -> String {
        if amount == nil {
            return ""
        }
        let d = ( (fromCurrency.NominalDouble! * fromCurrency.ValueDouble!) / (toCurrency.NominalDouble! * toCurrency.ValueDouble!) ) * amount!
        print(d)
        return String(d)
    }
    
    
    var pathForXML: String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]+"/data.xml"
        
        if FileManager.default.fileExists(atPath: path) {
            return path
        }
        return Bundle.main.path(forResource: "data", ofType: "xml" )!
    }
    
    
    var urlForXML: URL {
        return URL(fileURLWithPath: pathForXML)
    }
    
// Загрузка XML с cbr.ru и сохранение его в каталоге
    func loadXMLFile(date: Date?) {
        
        var strUrl = "https://www.cbr.ru/scripts/XML_daily.asp?date_req="
        
        if date != nil {
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd/MM/yyyy"
            strUrl = strUrl+dateFormater.string(from: date!)
        }
        let url = URL(string: strUrl)
        
        var globalError: String?
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]+"/data.xml"
                
                let urlForSave = URL(fileURLWithPath: path)
                
                do {
                    try data?.write(to: urlForSave)
                    print("Фаил загрузил")
                    self.parseXML()
                    
                } catch {
                    print("Errorrr:\(error.localizedDescription)")
                    globalError = error.localizedDescription
                }
            } else {
                print("Error when loadXML:"+error!.localizedDescription)
                globalError = error?.localizedDescription
            }
            if let globalError = globalError {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"ErrorWhenXMLloading"), object: self, userInfo: ["ErrorName":globalError]) }
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startLoadXML"), object: self)
        
        task.resume()
        
    }
    // распарсить XML и положить его в currencies: [Currency] и отправить уведомление о том что данные обновленны
    func parseXML() {
        
        currencies = [Currency.rouble()]
        
        let parser = XMLParser(contentsOf: urlForXML)
        parser?.delegate = self
        parser?.parse()
        
        print("Данные обновлены")
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dataRefreshed"), object: self)
        
        for c in currencies {
            if c.CharCode == fromCurrency.CharCode {
                fromCurrency = c
            }
            
            if c.CharCode == toCurrency.CharCode {
                toCurrency = c
            }
        }
    }
    var currentCurrency: Currency?
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "ValCurs" {
            if let currentDateString = attributeDict["Date"] {
                currentDate = currentDateString
            }
        }
        
        if elementName == "Valute" {
            currentCurrency = Currency()
        }
        
    }
    
    var currentCharacters: String = ""
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentCharacters = string
    }

    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if  elementName == "NumCode" {
            currentCurrency?.NumCode = currentCharacters
            }
        
        if  elementName == "CharCode" {
            currentCurrency?.CharCode = currentCharacters
            }
        
        if  elementName == "Name" {
            currentCurrency?.Name = currentCharacters
            }
        
        if  elementName == "Nominal" {
            currentCurrency?.Nominal = currentCharacters
            currentCurrency?.NominalDouble = Double(currentCharacters.replacingOccurrences(of: ",", with: "."))
            }
        
        if  elementName == "Value" {
            currentCurrency?.Value = currentCharacters
            currentCurrency?.ValueDouble = Double(currentCharacters.replacingOccurrences(of: ",", with: "."))
            }
        
        if elementName == "Valute" {
            currencies.append(currentCurrency!)
            }
        
    }
    
 }*/
