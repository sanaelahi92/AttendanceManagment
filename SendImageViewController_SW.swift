//
//  SendImageViewController_SW.swift
//  AttendanceManagement
//
//  Created by Welltime on 23/05/2017.
//  Copyright © 2017 Welltime. All rights reserved.
//

import UIKit

class SendImageViewController_SW: UIViewController {
    
    var data:UIImage? = nil
    @IBOutlet weak var imageView: UIImageView!
var alert : UIAlertView = UIAlertView(title:nil , message: "Loading..." , delegate: nil, cancelButtonTitle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.imageView.image=self.data

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    @IBAction func send_click(_ sender: Any) {
        
        let viewBack:UIView = UIView(frame: CGRect(x: 83,y: 0,width: 100,height: 60))
        
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 50, y: 10, width: 57, height: 57))
        loadingIndicator.center = viewBack.center
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        viewBack.addSubview(loadingIndicator)
        viewBack.center = self.view.center
        alert.setValue(viewBack, forKey: "accessoryView")
        loadingIndicator.startAnimating()
        
        sendData()
        
    }
    
    @IBAction func cancel_click(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
   
   
    
    
    
    
    func sendData()
    {
               
        alert.show()
        let postEndpoint: String = "http://wtatmanagmentmobile.somee.com/api/attendance"
        let url = URL(string: postEndpoint)!
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
        var strEncoded = ""
       
//        var strEncoded = UIImagePNGRepresentation(data!)?.base64EncodedString(options: .endLineWithCarriageReturn)
//        strEncoded?.replacingOccurrences(of: " ", with: "+")
//        strEncoded?.replacingOccurrences(of: "+", with: "%2B")
//        print("image length: \((strEncoded?.characters.count ?? 0) % 4)")
        
                var image_string = UIImagePNGRepresentation(self.data!)?.base64EncodedString(options: .endLineWithCarriageReturn)
                image_string?.replacingOccurrences(of: " ", with: "+")
                image_string?.replacingOccurrences(of: "+", with: "%2B")
        
        
       let emp_id = 1
        //(UserDefaults.standard.value(forKey: "USER_ID") as? String)!
        let emp_name = "sana"
            //(UserDefaults.standard.value(forKey: "USER_NAME") as? String)!
        var status = "CHK_IN"
            //(UserDefaults.standard.value(forKey: "Status") as? String)!
        let tenant_id = "1"
            //(UserDefaults.standard.value(forKey: "TENANT_ID") as? String)!
        
        

        
        if (status == "") {
            status = "CHK_IN"
        }
        else if (status == "CHK_IN") {
            status = "CHK_OUT"
        }
        else if (status == "CHK_OUT") {
            status = "CHK_IN"
        }
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("0", forHTTPHeaderField: "Content-Length")
   
        
        do {
            let dic = ["Emp_Id":emp_id,"Emp_Name":emp_name,"Status":status,"Image": image_string ?? "","Tenant_Id":tenant_id] as [String : Any]
            
            let jsonData = try JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)
            //  let jsonObject: AnyObject = json.object
            request.httpBody = jsonData
            
        } catch {
            print("bad things happened")
        }
        
        
        // Make the POST call and handle it in a completion handler
        session.dataTask(with: request, completionHandler: { ( data: Data?, response: URLResponse?, error: Error?) -> Void in
            // Make sure we get an OK response
            guard let realResponse = response as? HTTPURLResponse   ,
                realResponse.statusCode == 200 else {
                    
                    self.alert.dismiss(withClickedButtonIndex: -1, animated: true)
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
            if let postString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue) as String? {
                // Print what we got from the call
                print("POST: " + postString)
                
                self.alert.dismiss(withClickedButtonIndex: -1, animated: true)
                
                
                if(postString=="true")
                {
                    
                    let alertview:UIAlertView = UIAlertView(title: "Success Alert", message: "Attendance noted successfully", delegate: self, cancelButtonTitle: "OK")
                    alertview.show()}
                    
                else if(postString=="false")
                {
                    
                    let alertview:UIAlertView = UIAlertView(title: "Error", message: "Internal server error... Attendance not noted", delegate: self, cancelButtonTitle: "OK")
                    alertview.show()}
                
            }
            
            
        
        
            
            
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
