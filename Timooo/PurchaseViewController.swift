//
//  PurchaseViewController.swift
//  Timooo
//
//  Created by Nikita Kolmogorov on 25/02/16.
//  Copyright © 2016 Borodutch Studio LLC. All rights reserved.
//

import UIKit

class PurchaseViewController: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    // MARK: - Variables -
    
    let productIDs = NSSet(object: "com.timooo.10apples")
    
    // MARK: - SKProductsRequestDelegate -
    
    func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        
        print("Received SKProductsResponse:\n\(response.products)")
        
        let product = response.products.first!
        
        let alert = UIAlertController(title: product.localizedTitle, message: product.localizedDescription, preferredStyle: .Alert)
        let buyAction = UIAlertAction(title: "Buy", style: .Default) { action in
            print("Started SKPaymentQueue")
            let payment = SKPayment(product: product)
            SKPaymentQueue.defaultQueue().addTransactionObserver(self)
            SKPaymentQueue.defaultQueue().addPayment(payment)
        }
        let cancel = UIAlertAction(title: "GOD NO", style: .Cancel) { action in
            // Do nothing
        }
        alert.addAction(cancel)
        alert.addAction(buyAction)
        presentViewController(alert, animated: true) {}
    }
    
    // MARK: - SKPaymentTransactionObserver -
    
    func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        print("SKPaymentTransactionObserver received:\n\(transactions.first!.transactionState.rawValue)")
        queue.finishTransaction(transactions.first!)
    }
    
    // MARK: - Actions -
    
    @IBAction func buyImmortalityTouched(sender: AnyObject) {
        if !SKPaymentQueue.canMakePayments() {
            showCannotMakePaymentsAlert()
            return
        }
        let productsRequest =
            SKProductsRequest(productIdentifiers: productIDs as! Set<String>)
        
        productsRequest.delegate = self
        productsRequest.start()
        print("Strarted SKProductsRequest")
    }
    
    @IBAction func restoreTouched(sender: AnyObject) {
        SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
    }

    // MARK: - General Functions -
    
    func showCannotMakePaymentsAlert() {
        let alert = UIAlertController(title: "Sorry bro", message: "You are not allowed not make payments", preferredStyle: .Alert)
        let cancel = UIAlertAction(title: "Okay", style: .Cancel) { action in
            // Do nothing
        }
        alert.addAction(cancel)
        presentViewController(alert, animated: true) {}
    }
}
