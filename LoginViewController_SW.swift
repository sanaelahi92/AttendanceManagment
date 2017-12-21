//
//  LoginViewController_SW.swift
//  AttendanceManagement
//
//  Created by Welltime on 24/05/2017.
//  Copyright © 2017 Welltime. All rights reserved.
//

import UIKit

class LoginViewController_SW: UIViewController {
  var alert : UIAlertView = UIAlertView(title:nil , message: "Loading..." , delegate: nil, cancelButtonTitle: nil)
    
    var valid:Bool = false
    
    @IBOutlet weak var txt_email: UITextField!
    
    @IBOutlet weak var txt_password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func login_click(_ sender: Any) {
        
        
        var email = self.txt_email.text
        
        var password = self.txt_password.text
        
        if (self.txt_email.text == "") || (self.txt_password.text == "") {
            let alertview:UIAlertView = UIAlertView(title: "Invalid Data", message: "Enter all the required fields", delegate: self, cancelButtonTitle: "OK")
            alertview.show()
            return
            
            // either textfield 1 or 2's text is empty
        }

        checkCredentials(email: email!, password: password!)
        
    }
    
    
    func checkCredentials(email: String, password: String)
    {
        
        
        alert.show()
        let postEndpoint: String = "http://wtatmanagmentmobile.somee.com/api/credentials?username=\(email)&password=\(password)"
        let url = URL(string: postEndpoint)!
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
        
        //.sharedSession
        //        let json = JSON(["SearchStartDate":"2016-08-01T00:00:00Z", "SearchEndDate":"2016-08-30T00:00:00Z","Service":["ServiceCode":1,"DefaultDuration":"PT30M"],"Customer":["CustomerType":["CustomerTypeCode":"P"]]])
        //        print(json)
        
        
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        do {
            //  let jsonObject: AnyObject = json.object
            //            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(jsonObject, options: NSJSONWritingOptions())
            
        } catch {
            print("bad things happened")
        }
        
        
        // Make the POST call and handle it in a completion handler
        session.dataTask(with: request, completionHandler: { ( data: Data?, response: URLResponse?, error: Error?) -> Void in
            // Make sure we get an OK response
            guard let realResponse = response as? HTTPURLResponse   ,
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    
                    let realResp = response as? HTTPURLResponse
                    
                    
                    if(realResp?.statusCode == 403)
                    {   let alertview:UIAlertView = UIAlertView(title: "Invalid Key", message: nil, delegate: self, cancelButtonTitle: "OK")
                        alertview.show()
                        return
                        
                        
                        
                    }
                        
                    else if(realResp?.statusCode == 400 || realResp?.statusCode == 500)
                    {
                        
                        
                        let alertview:UIAlertView = UIAlertView(title: "Server Error", message: "Sorry ... Server is down at the moment", delegate: self, cancelButtonTitle: "OK")
                        alertview.show()
                        return
                        
                        
                    }
                    
                    
                    
                    
                    
                    return
                    
                    //////
                    
                    
            }
            
            // Read the JSON
            if let postString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue) as? String {
                // Print what we got from the call
                print("POST: " + postString)
                 self.alert.dismiss(withClickedButtonIndex: -1, animated: true)
                
                
                do{
                    let nudgesJSONResult = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    
                    
                    if let json = nudgesJSONResult as? NSObject
                    {
                        
                            let status = json.value(forKey: "Status") as! Bool
                            
                            if(status)
                            {
                        
                            let tenant_id = json.value(forKey: "Tenant_Id")
                            UserDefaults.standard.set(true, forKey: "TENANT_ID")
                                
                                
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let vc2: MainViewController_SW = storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainViewController_SW 
                                
                                self.present(vc2, animated: true, completion: nil)
                                
                            }
                            else{
                            
                                let message = json.value(forKey: "Message")
                                let alertview:UIAlertView = UIAlertView(title: nil, message: message as! String?, delegate: self, cancelButtonTitle: "OK")
                                alertview.show()
                                return
                            
                            }
                            
                        }
                    
                }
                    
                catch {
                    print("Error with Json: \(error)")
                  
                    let alertview:UIAlertView = UIAlertView(title: nil, message: "Server Down atm.. Please try later" as! String?, delegate: self, cancelButtonTitle: "OK")
                    alertview.show()
                    return

                    
                }
            }
            
           
            self.alert.dismiss(withClickedButtonIndex: -1, animated: true)
            
            
            
        }).resume()
        
        

    }

   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
