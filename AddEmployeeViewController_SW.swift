//
//  AddEmployeeViewController_SW.swift
//  AttendanceManagement
//
//  Created by Welltime on 23/05/2017.
//  Copyright © 2017 Welltime. All rights reserved.
//

import UIKit

class AddEmployeeViewController_SW: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    var timePickerView: UIDatePicker? = nil
    var timePickerView2: UIDatePicker? = nil
    
    var profile_img:UIImage? = nil
    
    var start_time:String = ""
    var keyboardToolbar:UIToolbar? = nil
    
    var end_time:String = ""
    @IBOutlet weak var img_view: UIImageView!
  
    @IBOutlet weak var txt_first_name: UITextField!
    var alert : UIAlertView = UIAlertView(title:nil , message: "Loading..." , delegate: nil, cancelButtonTitle: nil)
    
    @IBOutlet weak var txt_last_name: UITextField!
    
    
  
    @IBOutlet weak var txt_tel_num: UITextField!

    
    
    @IBOutlet weak var txt_mob_num: UITextField!
    
    
    
    @IBOutlet weak var txt_email_address: UITextField!

    
  
    
    
    
    @IBOutlet weak var txt_day: UITextField!
    
    

   
    @IBOutlet weak var txt_month: UITextField!
    
    
    
    @IBOutlet weak var txt_year: UITextField!
    
    
    @IBOutlet weak var txt_job_title: UITextField!
    
    @IBOutlet weak var txt_start_time: UITextField!
  
    
    @IBOutlet weak var txt_end_time: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if timePickerView == nil {
            timePickerView = UIDatePicker()
            timePickerView?.addTarget(self, action: #selector(self.dateChangedForTimePicker1), for: .valueChanged)
            timePickerView?.datePickerMode = .time
        }
        if timePickerView2 == nil {
            timePickerView2 = UIDatePicker()
            timePickerView2?.addTarget(self, action: #selector(self.dateChangedForTimePicker2), for: .valueChanged)
            timePickerView2?.datePickerMode = .time
        }
        
        self.txt_start_time.inputView = timePickerView
        
        self.txt_end_time.inputView = timePickerView2
        
        
        self.txt_first_name.delegate = self
        
        self.txt_last_name.delegate = self
        
        self.txt_tel_num.delegate = self
        
        self.txt_email_address.delegate = self
        
        self.txt_mob_num.delegate = self
        
        self.txt_day.delegate = self
        
        self.txt_month.delegate = self
        
        self.txt_year.delegate = self
        
        self.txt_job_title.delegate = self
        
        
        
        
        self.txt_mob_num.keyboardType = UIKeyboardType.numberPad
         self.txt_tel_num.keyboardType = UIKeyboardType.numberPad
        
        self.txt_day.keyboardType = UIKeyboardType.numberPad
        self.txt_month.keyboardType = UIKeyboardType.numberPad
        
        self.txt_year.keyboardType = UIKeyboardType.numberPad
        
        self.txt_email_address.keyboardType = UIKeyboardType.emailAddress
        
        
        if keyboardToolbar == nil {
            keyboardToolbar = UIToolbar(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(view.bounds.size.width), height: CGFloat(38.0)))
            keyboardToolbar?.barStyle = .blackTranslucent
            var spaceBarItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            var doneBarItem = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: .done, target: self, action: #selector(self.resignPickerView))
            doneBarItem.tintColor = UIColor.white
            keyboardToolbar?.items = [doneBarItem]
            //        self.nameTextField.inputAccessoryView = self.keyboardToolbar;
            //
            //        self.emailTextField.inputAccessoryView = self.keyboardToolbar;
            //
            //
            txt_start_time.inputAccessoryView = keyboardToolbar
           
            txt_end_time.inputAccessoryView = keyboardToolbar
            
        }

        // Do any additional setup after loading the view.
    }
    
    func sendDatatoA (image: UIImage) {
        profile_img = image
       img_view.image = image
        // data will come here inside of ViewControllerA
    }
    
    
    @IBAction func back_click(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func save_click(_ sender: Any) {
        
        if (self.txt_first_name.text == "") || (self.txt_last_name.text == "") || (self.start_time == "") || (self.end_time == ""){
            let alertview:UIAlertView = UIAlertView(title: "Invalid Data", message: "Enter all the required fields", delegate: self, cancelButtonTitle: "OK")
            alertview.show()
            return
            
            // either textfield 1 or 2's text is empty
        }
        
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
        
        let tenant_id = "1"
            //(UserDefaults.standard.value(forKey: "TENANT_ID") as? String)!
        var emp = Employee()
        emp.Fname = txt_first_name.text
        emp.Lname = txt_last_name.text
        emp.Email = txt_email_address.text
        emp.Mob_Num = txt_mob_num.text
        emp.JobTitle = txt_job_title.text
        
        
        /////
        
        var image_string = UIImagePNGRepresentation(self.profile_img!)?.base64EncodedString(options: .endLineWithCarriageReturn)
        image_string?.replacingOccurrences(of: " ", with: "+")
        image_string?.replacingOccurrences(of: "+", with: "%2B")
        
        
        ////////
        
        emp.ProfileImage = image_string
        emp.Tel_Num = txt_tel_num.text
        emp.DOB = "\(txt_day.text!)-\(txt_month.text!)-\(txt_year.text!)"
        emp.TenantId = tenant_id
        emp.StartTime = self.start_time
        emp.EndTime = self.end_time
        
        sendData(employee :emp)
        
    }
    
    
    @IBAction func take_picture(_ sender: Any) {
        
  takePhoto()
        
        
          }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: CGFloat(newWidth), height: CGFloat(newHeight)))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
      
        return newImage!
    }
    
    
    func takePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            img_view.contentMode = .scaleToFill
            img_view.image = pickedImage
            self.profile_img = resizeImage(image: pickedImage, newWidth: 200)
           
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func dateChangedForTimePicker1(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:00 a"
        start_time = dateFormatter.string(from: (timePickerView?.date)!)
        txt_start_time.text = start_time
        print("\(start_time)")
    }
    
    func dateChangedForTimePicker2(_ sender: Any) {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:00 a"
        end_time = dateFormatter.string(from: (timePickerView2?.date)!)
        
        if ((timePickerView2?.date)!<=(timePickerView?.date)!)
        {
            let alertview:UIAlertView = UIAlertView(title: "Input Error", message: "Start time should be less than End time", delegate: self, cancelButtonTitle: "OK")
            alertview.show()
            return
        }
        
       txt_end_time.text = end_time
        print("\(end_time)")
    }

    func sendData(employee: Employee)
    {
        
        
        alert.show()
        let postEndpoint: String = "http://wtatmanagmentmobile.somee.com/api/employee"
        let url = URL(string: postEndpoint)!
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
        
     
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("0", forHTTPHeaderField: "Content-Length")
        
        
        do {
            let dic = ["Fname":employee.Fname!,"Lname":employee.Lname!,"Email": employee.Email!,"TelNo":employee.Tel_Num! ,"MobNo":employee.Mob_Num!,"DOB":employee.DOB!
                ,"JobTitle":employee.JobTitle!,"ProfileImage":employee.ProfileImage!,"Tenant_Id":employee.TenantId!,"StartTime":employee.StartTime!,"EndTime":employee.EndTime!] as [String : Any]
            
            print("\(dic)")
            
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
            if let postString = String(data:data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
                // Print what we got from the call
                print("POST: " + postString)
                
                self.alert.dismiss(withClickedButtonIndex: -1, animated: true)
                
                
                    if(postString=="true")
                    {
                        
                        let alertview:UIAlertView = UIAlertView(title: "Success Alert", message: "Employee registered successfully", delegate: self, cancelButtonTitle: "OK")
                        alertview.show()}
                        
                    else if(postString=="false")
                    {
                        
                        let alertview:UIAlertView = UIAlertView(title: "Error", message: "Internal server error... Employee not registered", delegate: self, cancelButtonTitle: "OK")
                        alertview.show()}
                    
                     }
                    
            
            
        }).resume()
  
        

    }

    func resignPickerView(_ sender: Any) {
       self.txt_start_time.resignFirstResponder()
        self.txt_end_time.resignFirstResponder()
        //   [self resetLabelsColors];
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
