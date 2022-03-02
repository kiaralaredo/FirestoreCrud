//
//  GuardarViewController.swift
//  FirestoreCrud
//
//  Created by Colimasoft on 02/03/22.
//

import UIKit
import FirebaseFirestore

class GuardarViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var titulo: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    let generos = ["Acción",  "Aventuras", "Ciencia Ficción", "Terror", "Drama"]
    var genero = ""
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return generos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return generos[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genero =  generos[row]
        print(genero)
    }
    
    @IBAction func guardar(_ sender: UIButton) {
        let campos: [String:Any] = ["titulo": titulo.text ?? "sin titulo", "genero": genero]
        db.collection("peliculas").addDocument(data: campos) { (error) in
            if let error = error {
                print("Fallo al guardar", error.localizedDescription)
            }else{
                print("Guardo correctamente")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
