//
//  ModelUA.swift
//  Chenge
//
//  Created by Aleksander Kulikov on 09.04.2021.
//http://www.cbr.ru/scripts/XML_daily.asp?date_req=02/03/2002
//Украина
// https://bank.gov.ua/NBU_Exchange/exchange?date=19.12.2017
//<?xml version="1.0" encoding="windows-1251"?> <CURRENCYCOURSE>
//<ROW>
// <StartDate>06.02.2018</StartDate>
// <TimeSign>0000</TimeSign>
// <CurrencyCode>356</CurrencyCode>
// <CurrencyCodeL>INR</CurrencyCodeL>
// <Units>1000</Units>
// <Amount>432.7827</Amount>
// </ROW>
 
 //<NumCode>036</NumCode>
 //<CharCode>AUD</CharCode>-----
 //<Nominal>1</Nominal>   1*16.0102----
 //<Name>¿‚ÒÚ‡ÎËÈÒÍËÈ ‰ÓÎÎ‡</Name>
 //<Value>16,0102</Value>-------

 
import UIKit

class Currencye {
    var CurrencyCode: String?
    var CurrencyCodeL: String?
   // var Name: String?
    
    var Units: String?
    var UnitsDouble: Double?
    
    var Amount: String?
    var AmountDouble: Double?
    
    var imageFlag:UIImage? {
        if let CharCode = CurrencyCodeL {
            return UIImage(named: CharCode)
        }
        return nil
    }
    
    
    class func ua () -> Currencye {
        let r = Currencye ()
        r.CurrencyCodeL = "UAH"
       // r.Name = "Росийский рубль"
        r.Units = "1"
        r.UnitsDouble = 1
        r.Amount = "1"
        r.AmountDouble = 1
        
        return r
        
    }
    
}

class ModelUA: NSObject, XMLParserDelegate {
    static let shared = ModelUA()
    
    var currencies: [Currencye] = []
    var currentDate: String = ""
    
    var fromCurrency: Currencye = Currencye.ua()
    var toCurrency: Currencye = Currencye.ua()
    
    func convert(amount: Double?) -> String {
        if amount == nil {
            return ""
        }
        let d = ( (fromCurrency.UnitsDouble! * fromCurrency.AmountDouble!) / (toCurrency.UnitsDouble! * toCurrency.AmountDouble!) ) * amount!
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
        
        var strUrl = "https://bank.gov.ua/NBU_Exchange/exchange?date="
        
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
        
        currencies = [Currencye.ua()]
        
        let parser = XMLParser(contentsOf: urlForXML)
        parser?.delegate = self
        parser?.parse()
        
        print("Данные обновлены")
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dataRefreshed"), object: self)
        
        for c in currencies {
            if c.CurrencyCodeL == fromCurrency.CurrencyCodeL {
                fromCurrency = c
            }
            
            if c.CurrencyCodeL == toCurrency.CurrencyCodeL {
                toCurrency = c
            }
        }
    }
    var currentCurrency: Currencye?
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "ValCurs" {
            if let currentDateString = attributeDict["Date"] {
                currentDate = currentDateString
            }
        }
        
        if elementName == "ROW" {
            currentCurrency = Currencye()
        }
        
    }
    
    var currentCharacters: String = ""
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentCharacters = string
    }

    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if  elementName == "CurrencyCode" {
            currentCurrency?.CurrencyCode = currentCharacters
            }
        
        if  elementName == "CurrencyCodeL" {
            currentCurrency?.CurrencyCodeL = currentCharacters
            }
        
      /*  if  elementName == "Name" {
            currentCurrency?.Name = currentCharacters
            }*/
        
        if  elementName == "Units" {
            currentCurrency?.Units = currentCharacters
            currentCurrency?.UnitsDouble = Double(currentCharacters.replacingOccurrences(of: ",", with: "."))
            }
        
        if  elementName == "Amount" {
            currentCurrency?.Amount = currentCharacters
            currentCurrency?.AmountDouble = Double(currentCharacters.replacingOccurrences(of: ",", with: "."))
            }
        
        if elementName == "ROW" {
            currencies.append(currentCurrency!)
            }
    }
}

