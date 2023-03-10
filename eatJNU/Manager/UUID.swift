//
//  UUID.swift
//  eatJNU
//
//  Created by 정나영 on 2023/03/10.
//

import UIKit

class ViewController: UIViewController {
    let account = UIDevice.current.identifierForVendor?.uuidString ?? "" // 기기의 UUID
    let service = Bundle.main.bundleIdentifier ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad - 기존에 있던 패스워드 지우기")
        print("어카운트: \(account), 서비스: \(service)")
        deletePassword()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewDidLoad - 새로 패스워드를 저장하기")
        savePassword()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewWillAppear - 새로 저장한 패스워드 불러오기")
        getPassword()
    }
    
    func savePassword() {
        do {
            try KeychainManager.save(
                service: service,
                account: account,
                password: "내가 저장하고 싶은 패스워드".data(using: .utf8) ?? Data() // 여기에 여러분이 저장하고자 하는 중요 정보를 넣으시면 됩니다
            )
        } catch {
            print(error)
        }
    }
    
    func getPassword() {
        guard let data = KeychainManager.get(
            service: service,
            account: account
        ) else {
            print("getPassword() - 불러올 수 있는 패스워드가 없습니다")
            return
        }
        
        let password = String(decoding: data, as: UTF8.self)
        print("getPassword() - 불러온 패스워드: \(password)")
    }
    
    func deletePassword() {
        guard let data = KeychainManager.get(
            service: service,
            account: account
        ) else {
            print("deletePassword() - 불러올 수 있는 패스워드가 없습니다")
            return
        }
        
        KeychainManager.delete(service: service, account: account, password: data)
    }
}

class KeychainManager {
    enum KeychainError: Error {
        case duplicateEntry
        case unknown(OSStatus)
    }
    
    static func save(service: String, account: String, password: Data) throws {
        let query: [String: AnyObject] = [
                kSecClass as String: kSecClassGenericPassword, // 키체인 아이템 클래스 타입
                kSecAttrService as String: service as AnyObject, // 서비스 아이디 -> 앱 번들 아이디
                kSecAttrAccount as String: account as AnyObject, // 저장할 아이템의 계정 이름
                kSecValueData as String: password as AnyObject // 저장할 아이템의 데이터
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil) // 키체인에 하나 이상의 항목을 추가할 때 사용
        guard status != errSecDuplicateItem  else {
            throw KeychainError.duplicateEntry
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
        print("save() - status: \(status)")
    }
    
    static func get(service: String, account: String) -> Data? {
        let query: [String: AnyObject] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service as AnyObject,
                kSecAttrAccount as String: account as AnyObject,
                kSecReturnData as String: kCFBooleanTrue,
                kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        // 검색 쿼리와 일치하는 키체인 항목을 하나 이상 반환하는 기능, 특정 키 체인 항목의 속성을 복사할 수 있음
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        print("get() - status: \(status)")
        return result as? Data
    }
    
    static func delete(service: String, account: String, password: Data) {
        let query: [String: AnyObject] = [
                kSecClass as String: kSecClassGenericPassword, // 키체인 아이템 클래스 타입
                kSecAttrService as String: service as AnyObject, // 서비스 아이디 -> 앱 번들 아이디
                kSecAttrAccount as String: account as AnyObject, // 저장할 아이템의 계정 이름
                kSecValueData as String: password as AnyObject // 저장할 아이템의 데이터
        ]
        
        let passwordToDelete = String(decoding: password, as: UTF8.self)
        print("delete() - 삭제할 패스워드 - \(passwordToDelete)")
        
        let status = SecItemDelete(query as CFDictionary)
        print("delete() - status: \(status)")
    }
}
