//
//  TestViewController.swift
//  NPaySDKDemo
//
//  Created by Vu Pham on 10/08/2022.
//

import UIKit
//import NPayLibrary
import NPayFramework

class TestViewController: UIViewController, UITextFieldDelegate {
    var nLib: NPayManager?
    @IBOutlet var titleInfo: UILabel!
    @IBOutlet var blanceInfo: UILabel!
    @IBOutlet weak var urlPaymentTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nLib = NPayManager(vController: self, sdkCfgs: SDKConfigs(merchantCode: "NGuTdi", uid: "uid", brandColor: "-15356318", env: .stg))
        nLib?.delegate = self
        self.urlPaymentTxt.delegate = self
        self.urlPaymentTxt.clearButtonMode = .whileEditing
//        nLib?.getAccountInfo()
    }
    @IBAction func btnScanQR(_ sender: Any) {
        DispatchQueue.main.async {
            displayToastMessage("The function is not complete")
        }
//        nLib?.openWallet(action: Actions.OPEN_WALLET)
//        nLib?.openKYC()
    }
    
    @IBAction func btnDeposit(_ sender: Any) {
        nLib?.openWallet(action: Actions.DEPOSIT)
    }
    
    @IBAction func btnTransfer(_ sender: Any) {
        nLib?.openWallet(action: Actions.TRANSFER)
    }
    
    @IBAction func btnHistory(_ sender: Any) {
        DispatchQueue.main.async { [self] in
//            displayToastMessage("The function is not complete")
            self.nLib?.openWallet(action: Actions.HISTORY)
        }
    }
    @IBAction func btnPayBill(_ sender: Any) {
        DispatchQueue.main.async {
            displayToastMessage("Thanh toan hoa don")
            print("Thanh toan hoa don")
            self.nLib?.openWallet(action: Actions.SHOP)
        }
    }
    
    @IBAction func btnPayCardPhone(_ sender: Any) {
        nLib?.openWallet(action: Actions.TOPUP_PHONE_CARD)
    }
    
    @IBAction func btnPayCardGame(_ sender: Any) {
        DispatchQueue.main.async {
            displayToastMessage("The function is not complete")
        }
    }
    @IBAction func btnPayCardService(_ sender: Any) {
        nLib?.openWallet(action: Actions.BUY_SERVICES_CARD)
    }
    
    @IBAction func btnCardPhone(_ sender: Any) {
        nLib?.openWallet(action: Actions.BUY_PHONE_CARD)
    }
    @IBAction func btnPayData(_ sender: Any) {
        nLib?.openWallet(action: Actions.TOPUP_DATA_CARD)
    }
    
    @IBAction func btnPaymentGateway(_ sender: Any) {
        nLib?.paymentMerchant(urlPayment: "https://developers.9pay.vn/demo-portal")
//        nLib?.pay("https://stg-web.wallet.9pay.mobi/merchant/payment/j2DRYMMm")
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
       textField.resignFirstResponder()
       return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    @IBAction func paymentForMerchant(_ sender: Any) {
        if let urlPay = self.urlPaymentTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            guard URL(string: urlPay) != nil else {
                DispatchQueue.main.async {
                    displayToastMessage("Please input valid url!")
                }
                return
            }
            self.nLib?.paymentMerchant(urlPayment: urlPay)
        } else {
            DispatchQueue.main.async {
                displayToastMessage("Please input valid url!")
            }
            return
        }
        
    }
    
    
    @IBAction func openWalletSDK(_ sender: Any) {
        nLib?.openWallet(action: Actions.OPEN_WALLET)
    }
    @IBAction func getUserInfo(_ sender: Any) {
        nLib?.getAccountInfo()
    }
    @IBAction func refreshToken(_ sender: Any) {
        nLib?.refreshAccessToken()
    }
    @IBAction func logoutAction(_ sender: Any) {
        nLib?.logout()
    }
    @IBAction func loginAction(_ sender: Any) {
        nLib?.login()
    }
    @IBAction func closeAction(_ sender: Any) {
        nLib?.close()
    }
    @IBAction func payAction(_ sender: Any) {
        nLib?.pay("xxxx")
    }
    
}

extension TestViewController: LibListener {
    func getMerchantActionSuccess(actions: [String]) {
       print(actions)
    }
    
    func onLoginSuccessfull() {
        DispatchQueue.main.async {
            displayToastMessage("onLoginSuccessfull")
        }
    }
    
    func onPaySuccessful() {
        DispatchQueue.main.async {
            displayToastMessage("onPaySuccessful")
        }
    }
    
    func getInfoSuccess(phone: String, balance: String, ekycStatus: String) {
        print("getInfoSuccess \(phone) balance:\(balance) ekycStatus:\(ekycStatus)")
        titleInfo.text = "Xin chào, \(phone)"
        blanceInfo.text = balance
        DispatchQueue.main.async {
            displayToastMessage("GetInfoSuccess: \(phone)")
        }
    }
    
    func onError(errorCode: Int, message: String) {
        print("onError")
        DispatchQueue.main.async {
            displayToastMessage("Message: \(message): errorCode: \(errorCode)")
        }
    }
    
}

extension UIApplication {
    
   public var mainKeyWindow: UIWindow? {
       if #available(iOS 13, *) {
         return UIApplication.shared.connectedScenes
             .filter { $0.activationState == .foregroundActive }
             .first(where: { $0 is UIWindowScene })
             .flatMap { $0 as? UIWindowScene }?.windows
             .first(where: \.isKeyWindow)
       } else {
           return UIApplication.shared.windows.first { $0.isKeyWindow }
       }
   }
}

func displayToastMessage(_ message : String) {
        
        let toastView = UILabel()
        toastView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastView.textColor = UIColor.white
        toastView.textAlignment = .center
        toastView.font = UIFont.preferredFont(forTextStyle: .caption1)
        toastView.layer.cornerRadius = 25
        toastView.layer.masksToBounds = true
        toastView.text = message
        toastView.numberOfLines = 0
        toastView.alpha = 0
        toastView.translatesAutoresizingMaskIntoConstraints = false
        
        guard let window = UIApplication.shared.mainKeyWindow else {
           return
        }
    window.addSubview(toastView)
        
        let horizontalCenterContraint: NSLayoutConstraint = NSLayoutConstraint(item: toastView, attribute: .centerX, relatedBy: .equal, toItem: window, attribute: .centerX, multiplier: 1, constant: 0)
        
        let widthContraint: NSLayoutConstraint = NSLayoutConstraint(item: toastView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 275)
        
        let verticalContraint: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=200)-[loginView(==50)]-68-|", options: [.alignAllCenterX, .alignAllCenterY], metrics: nil, views: ["loginView": toastView])
        
        NSLayoutConstraint.activate([horizontalCenterContraint, widthContraint])
        NSLayoutConstraint.activate(verticalContraint)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            toastView.alpha = 1
        }, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(2 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                toastView.alpha = 0
            }, completion: { finished in
                toastView.removeFromSuperview()
            })
        })
    }
    
