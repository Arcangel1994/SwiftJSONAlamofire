//
//  RegristrarViewController.swift
//  WebService
//
//  Created by Miguel Muñoz on 11/27/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import Alamofire

class RegristrarViewController: UIViewController, UINavigationControllerDelegate,UIImagePickerControllerDelegate{


    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var respuesta: UILabel!
    @IBOutlet weak var galleria: UIButton!
    
    var url_registrar = "http://localhost/"
    
    var imagen = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    @IBAction func registrar(_ sender: UIButton) {
        
        /*let parametros  : Parameters = [
            "Usuario" : user.text!,
            "Password": pass.text!,
            "Nombre": name.text!,
            "Email": email.text!
        ]
        
        Alamofire.request(url_registrar, method: .post, parameters: parametros).responseJSON { (response) in
            
            print(response)
            
            if let result = response.result.value {
                
                let jsonData = result as! NSDictionary
                self.respuesta.text = jsonData.value(forKey: "mensaje") as! String?
                
            }
            
        }*/
        
        let parametros  : Parameters = [
            "Usuario" : user.text!,
            "Password": pass.text!,
            "Nombre": name.text!,
            "Email": email.text!
        ]
        
        let imagenFinal = imagen.pngData()
        let nombreImagen = UUID().uuidString
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(imagenFinal!, withName: "imagen", fileName: "\(nombreImagen).png", mimeType: "image/png")
            
            for (key, val) in parametros {
                multipartFormData.append((val as AnyObject).data(using : String.Encoding.utf8.rawValue)!, withName: key)
            }
            
        }, to: url_registrar) { (resultado) in
            
            switch resultado {
                
            case .success(let upload, _, _):
                upload.responseJSON(completionHandler: { (response) in
                    print(response)

                    if let result = response.result.value {
                        
                        let jsonData = result as! NSDictionary
                        self.respuesta.text = jsonData.value(forKey: "mensaje") as! String?
                        
                    }
                    
                })
            case .failure(let error):
                print("error", error)
            }
            
        }
        
    }//Termina registrar
    
    
    @IBAction func regresar(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func galeriafoto(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagenTomada = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        imagen = imagenTomada!
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
