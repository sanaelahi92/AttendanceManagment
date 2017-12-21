//
//  MainViewController_SW.swift
//  AttendanceManagement
//
//  Created by Welltime on 28/05/2017.
//  Copyright © 2017 Welltime. All rights reserved.
//

import UIKit

class MainViewController_SW: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func create_profile(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc2: AddEmployeeViewController_SW = storyboard.instantiateViewController(withIdentifier: "AddEmpVC") as! AddEmployeeViewController_SW
        
        self.present(vc2, animated: true, completion: nil)
  
        
    }
    
    @IBAction func mark_attendance(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc2: EmployeeListViewController = storyboard.instantiateViewController(withIdentifier: "EmpListVC") as! EmployeeListViewController
        
        self.present(vc2, animated: true, completion: nil)
        
        
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
