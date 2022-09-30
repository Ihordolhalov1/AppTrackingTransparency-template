//
//  ViewController.swift
//  AppTrackingTransparency template
//
//  Created by Ihor Dolhalov on 29.09.2022.
//


import Foundation
import AppTrackingTransparency
//import AdSupport

import UIKit



class FirstViewController: UIViewController {
    
   
    
  /*  override func viewWillAppear(_ animated: Bool) {
        ATTrackingManager.requestTrackingAuthorization {status in
            switch status {
            case .notDetermined:
                print ("notDetermined")
            case .restricted:
                print ("restricted")
            case .denied:
                print ("denied")
            case .authorized:
                print ("authorized before")
                    // Переходим на второй контроллер
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
                self.present(viewController, animated: true, completion: nil)
                self.performSegue(withIdentifier: "secondVCSegue", sender: nil)
           
            @unknown default:
                print ("unknown")
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "secondVCSegue" {
            let DVC = segue.destination as! SecondViewController
            self.present(DVC, animated: true, completion: nil)
        }
    }
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
   */
    
    override func viewDidLoad() {
        super.viewDidLoad()
      /*  let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        self.present(viewController, animated: true, completion: nil)
        
        self.performSegue(withIdentifier: "secondVCSegue", sender: nil) */
        
        /* РАЗБЛОКИРОВАТЬ
        ATTrackingManager.requestTrackingAuthorization {status in
            switch status {
            case .notDetermined:
                print ("notDetermined")
            case .restricted:
                print ("restricted")
            case .denied:
                print ("denied")
            case .authorized:
                print ("authorized before")
                    // Переходим на второй контроллер
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
                self.present(viewController, animated: true, completion: nil)
                
                self.performSegue(withIdentifier: "secondVCSegue", sender: nil)
           
            @unknown default:
                print ("unknown")
            }
        } */
       
      //  if ATTrackingManager.AuthorizationStatus == .authorized {
            
      //  }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pressedContinue(_ sender: UIButton) {
        requestTrackingAuthorization()
       
    }
    
    
    
    private func requestTrackingAuthorization() {
        guard #available(iOS 14, *) else { return }
        
        ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                  DispatchQueue.main.async {
                      ATTrackingManager.requestTrackingAuthorization {status in
                          switch status {
                              // Проверяем status
                          case .notDetermined:
                              print ("notDetermined")
                          case .restricted:
                              print ("restricted")
                          case .denied:
                              let alertController = UIAlertController(title: nil, message: "Sorry, we need your agreement. Please go to settings to allow or exit the application", preferredStyle: .alert)
                              let allowAction = UIAlertAction(title: "Allow", style: .default) {_ in
                                  //Переход в настройки приложения
                                  if let url = URL(string: UIApplication.openSettingsURLString) {
                                      if UIApplication.shared.canOpenURL(url) {
                                          UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                      }
                                  }
                                  
                              }
                              let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
                              alertController.addAction(allowAction)
                              alertController.addAction(cancelAction)
                              self.present(alertController, animated: true)
                              print ("denied")
                          case .authorized:
                              print ("authorized")
                                  // Переходим на второй контроллер
                              self.performSegue(withIdentifier: "secondVCSegue", sender: nil)
                          @unknown default:
                              print ("unknown")
                          }
                      }
                      
                     
                  }
        })
    }
}
