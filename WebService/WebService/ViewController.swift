//
//  ViewController.swift
//  WebService
//
//  Created by Miguel Muñoz on 11/27/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var usuario: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    var url_entrar = ""
    var respuesta = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let session = UserDefaults.standard.object(forKey: "session") as? String{
            if session == "login"{
                self.performSegue(withIdentifier: "entrar", sender: self)
            }
        }
        
    }

    @IBAction func entrar(_ sender: UIButton) {
        
        let parametros : Parameters = [
            "usuario": usuario.text!,
            "pass" : pass.text!
        ]
        
        Alamofire.request(url_entrar, method: .post, parameters: parametros).responseJSON { (response) in
            
            print(response)
            
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                self.respuesta = (jsonData.value(forKey: "mensaje") as! String?)!
                
                if self.respuesta == "login completo" {
                    
                    UserDefaults.standard.set("login", forKey: "session")
                    
                    self.performSegue(withIdentifier: "entrar", sender: self)
                    
                }else{
                    print("no funcion el login")
                }
                
            }
            
        }
    }
    
    
}

