//
//  DukeStorageModel.swift
//  SharingLedger
//
//  Created by mac on 2023/3/29.
//

import Foundation

var simpleSaveURL: URL = getDocumentsDirectory()
let simpleSaveFilename = "simpleSave.json"

let initJsonFilename = "ECE564Cohort.json"

var password = "sx80:20c290ea52cca984496ddd617455d6f6563a412107918ea51107b50131d92fcf"
var getAllHttpString = "https://ece564sp23.colab.duke.edu/entries/all"


class DukeStorageModel: ObservableObject {
    
    static var dukestorageModel = DukeStorageModel()
    
    //?? publish can be dict ??
    @Published var personDict: [String: DukePerson] = InitloadDataFromDisk()

    
    //this is for Replace
    func getDataFromServer(storageModel: StorageModel){
        //var res : [String : DukePerson] = [:]
        //let decoder = JSONDecoder()
        print("start get data from server")
        let getAllHttp_URL = URL(string: getAllHttpString)!
        var urlRequest = URLRequest(url: getAllHttp_URL)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let passWordData = password.data(using: String.Encoding.utf8)!
        let base64EncodedCredential = passWordData.base64EncodedString()
        let authString = "Basic " + base64EncodedCredential
        
        var res: [String: DukePerson] = [:]
        
        let session : URLSession = {
            let config = URLSessionConfiguration.default
            config.httpAdditionalHeaders = ["Authorization": authString]
            
            let session = URLSession(configuration: config, delegate: nil, delegateQueue: .main)
            return session
        }()
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if let _ = error {
                //print("Request error: ", error)
                fatalError("Error: Request to server fail")
            }
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                print("status Code:" + String(response.statusCode))
                guard let data = data else { return }
                print(data)
                //DispatchQueue.main.async {
                    do {
                        let decodedPeople = try JSONDecoder().decode([DukePerson].self, from: data)
                        print(decodedPeople[0])
                        
                        for person in decodedPeople {
                            //self.setRoleToLower(person: person)
                            //self.setPersonDukeRole(person: person)
                            print(person.netid)
                            res[person.netid] = person
                            
                        }
                        self.personDict = res
                        //this is update
                        storageModel.initFromDukeStorageModel(dukeStorageModel: self)
                        
                        //TODO: init for test ********** delete when finish
                        storageModel.initForTest()
                        
                        print(self.personDict["ys331"] as Any)
                        
                    } catch let error {
                        print("Error decoding: ", error)
                        fatalError("Error: docode data from server.")
                    }
                //}
            }
            else{
                //print("no data from server, load from sandbox or file")
                //self.load()
                fatalError("Error: not authorazied")
            }
        }
        
        task.resume()
        print("hahahahhahaha")
        print(res)
    }
    
    
    func loadDataFromDisk() -> [String: DukePerson]{
        let decoder = JSONDecoder()
        var addedPeople = [DukePerson]()
        let tempData: Data
        
        
        let simpleURL: URL = simpleSaveURL.appendingPathComponent(simpleSaveFilename)
        
        do {
            print("Init from sandbox")
            tempData = try Data(contentsOf: simpleURL)
        }catch let error as NSError {
            print("Could not init from sandbox")
            print(error)
            if let initurl = Bundle.main.url(forResource: initJsonFilename, withExtension: nil) {
                do {
                    tempData = try Data(contentsOf: initurl)
                    
                } catch {
                    print("error:\(error)")
                    fatalError("Couldn't read Json File in main bundle.")
                }
            }else{
                print("error: Json file can not be found")
                fatalError("Json file can not be found")
            }
            
        }
        print("Read Already --------")
        if let decoded = try? decoder.decode([DukePerson].self, from: tempData) {
            print(decoded[0].netid)
            addedPeople = decoded
            
            var res: [String: DukePerson] = [:]
            for person in addedPeople {
                res[person.netid] = person
            }
            return res
        }
        else{
            print("error: decode result is nil")
            fatalError("Decoder can not decode properly")
        }
       
        
    }
    
    func saveToSandbox() -> Bool {
        print("Start to save to the sandbox")
        var outputData = Data()
        let encoder = JSONEncoder()
        
        var peopleList = [DukePerson]()
        for (_, val) in personDict {
            peopleList.append(val)
        }
        print(peopleList)
        if let encoded = try? encoder.encode(peopleList) {
            if let json = String(data: encoded, encoding: .utf8) {
                print(json)
                outputData = encoded
            }
            else { return false }
            
            do {
                let simpleURL: URL = simpleSaveURL.appendingPathComponent(simpleSaveFilename)
                    try outputData.write(to: simpleURL)
            } catch let error as NSError {
                print (error)
                return false
            }
            print("success: save to sandbox")
            return true
        }
        else { return false }
    }
    
}

// this is used for initization with sandbox or Json file, not automaticly download from server
func InitloadDataFromDisk() -> [String: DukePerson]{
    let decoder = JSONDecoder()
    var addedPeople = [DukePerson]()
    let tempData: Data
    
    
    let simpleURL: URL = simpleSaveURL.appendingPathComponent(simpleSaveFilename)
    
    do {
        print("Init from sandbox")
        tempData = try Data(contentsOf: simpleURL)
    }catch let error as NSError {
        print("Could not init from sandbox")
        print(error)
        if let initurl = Bundle.main.url(forResource: initJsonFilename, withExtension: nil) {
            do {
                tempData = try Data(contentsOf: initurl)
                
            } catch {
                print("error:\(error)")
                fatalError("Couldn't read Json File in main bundle.")
            }
        }else{
            print("error: Json file can not be found")
            fatalError("Json file can not be found")
        }
        
    }
    print("Read Already --------")
    if let decoded = try? decoder.decode([DukePerson].self, from: tempData) {
        print(decoded[0].netid)
        addedPeople = decoded
        
        var res: [String: DukePerson] = [:]
        for person in addedPeople {
            res[person.netid] = person
        }
        return res
    }
    else{
        print("error: decode result is nil")
        fatalError("Decoder can not decode properly")
    }
   
    
}
