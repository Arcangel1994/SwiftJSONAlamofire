//
//  MostrarViewController.swift
//  WebService
//
//  Created by Miguel Muñoz on 11/27/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import Alamofire

struct Contacto: Codable {
    let nombre : String
    let email : String
    let id: String
}

class MostrarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tabla: UITableView!
    
    var contactos = [Contacto]()
    
    let url = URL(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datos()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        datos()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let contacto = contactos[indexPath.row]
        
        cell.textLabel?.text = contacto.nombre
        cell.detailTextLabel?.text = contacto.email
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "editar", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editar" {
            
            if let id = tabla.indexPathForSelectedRow{
            
            let fila = contactos[id.row]
            
                let destino = segue.destination as! EditarViewController
                    destino.contacto = fila
                
            }
        }
    }

    @IBAction func regresar(_ sender: UIBarButtonItem) {
        
        UserDefaults.standard.removeObject(forKey: "session")
        dismiss(animated: true, completion: nil)
        
    }
    
    func datos(){
        
        Alamofire.request(self.url!).responseJSON {
            (respose) in
            
            let result = respose.data
            
            do{
                
                self.contactos = try JSONDecoder().decode([Contacto].self, from: result!)
                
                DispatchQueue.main.async {
                    self.tabla.reloadData()
                }
                
            }catch{
                print("Error al conectar")
            }
            
        }
        
    }
    
}
