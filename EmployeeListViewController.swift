//
//  EmployeeListViewController.swift
//  AttendanceManagement
//
//  Created by Welltime on 24/05/2017.
//  Copyright © 2017 Welltime. All rights reserved.
//

import UIKit

class EmployeeListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbl_view: UITableView!
    
  
    var tableData = Array<Any>();
     var Fname = Array<Any>();
     var Lname = Array<Any>();
     var Status = Array<Any>();
     var Id = Array<Any>();
    
    var emp_list = [[String]]()
    
     var alert : UIAlertView = UIAlertView(title:nil , message: "Loading..." , delegate: nil, cancelButtonTitle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.tbl_view.register(Employee_SWTableViewCell.self, forCellReuseIdentifier:  "Employee_SWCell")
        let viewBack:UIView = UIView(frame: CGRect(x: 83,y: 0,width: 100,height: 60))
        
        
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 50, y: 10, width: 57, height: 57))
        loadingIndicator.center = viewBack.center
        loadingIndicator.hidesWhenStopped = true
        self.emp_list.removeAll()
        
        
     
          loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        viewBack.addSubview(loadingIndicator)
        viewBack.center = self.view.center
        alert.setValue(viewBack, forKey: "accessoryView")
        loadingIndicator.startAnimating()
        
        loadData()

        
        
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func back_click(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///// ******************* TableView Delegate Methods ****************** //////////
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.emp_list.count;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        UserDefaults.standard.set(self.emp_list[indexPath.row][3], forKey: "USER_ID")
        
        UserDefaults.standard.set(self.emp_list[indexPath.row][2], forKey: "Status")
        
        UserDefaults.standard.set(self.emp_list[(indexPath as NSIndexPath).row][0] + " " + self.emp_list[(indexPath as NSIndexPath).row][1], forKey: "USER_NAME")
        
      
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc2: StartViewController_SW = storyboard.instantiateViewController(withIdentifier: "StartVC") as! StartViewController_SW
       
       self.present(vc2, animated: true, completion: nil)
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cell: Employee_SWTableViewCell!
         
        
        cell = tableView.dequeueReusableCell(withIdentifier: "Employee_SWCell", for: indexPath) as! Employee_SWTableViewCell
        
        
       
        
        cell.lbl_name.text = emp_list[(indexPath as NSIndexPath).row][0] + " " + emp_list[(indexPath as NSIndexPath).row][1]
    
        
        cell.lbl_status.text = self.emp_list[(indexPath as NSIndexPath).row][2]
        
      
        
        
        return cell

        
        
    }
    

    
    
    
func loadData()
{
    
    
    alert.show()
    let tenant_id = 1
        //(UserDefaults.standard.value(forKey: "TENANT_ID") as? String)!
    let postEndpoint: String = "http://wtatmanagmentmobile.somee.com/api/employee?tenant_id=\(tenant_id)"
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
                self.alert.dismiss(withClickedButtonIndex: -1, animated: true)
                
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
            self.emp_list.removeAll()
            
            self.alert.dismiss(withClickedButtonIndex: -1, animated: true)
            
            do{
                let nudgesJSONResult = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                
            
                if let json = nudgesJSONResult as? NSArray
                {
                    for item in json {
                        var emp = [String]()
                        if let Fname = (item as AnyObject).value(forKey: "Fname") {emp.append(Fname as! String)  }
                        
                        if let Lname = (item as AnyObject).value(forKey: "Lname") {emp.append(Lname as! String)}
                        
                        
                        if let Status = (item as AnyObject).value(forKey: "Status") {
                            emp.append(Status as! String)}
                        
                        
                        
                        if let Id = (item as AnyObject).value(forKey: "Id") { emp.append("\(Id)")}
                        
                        self.emp_list.append(emp)
                        
                    }
                }
                
                print(self.emp_list)
            }
                
            catch {
                print("Error with Json: \(error)")
                
                self.alert.dismiss(withClickedButtonIndex: -1, animated: true)
            }
        }
        
        if(self.emp_list.count<=0)
        {
            let alertview:UIAlertView = UIAlertView(title: "No record found ..", message: nil, delegate: self, cancelButtonTitle: "OK")
            alertview.show()
            return
            
            
        }
        self.alert.dismiss(withClickedButtonIndex: -1, animated: true)
        
        
        self.tbl_view.reloadData()
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
