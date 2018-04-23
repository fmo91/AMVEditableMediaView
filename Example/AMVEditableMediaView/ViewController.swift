//
//  ViewController.swift
//  AMVEditableMediaView
//
//  Created by zorroseph on 04/23/2018.
//  Copyright (c) 2018 zorroseph. All rights reserved.
//

import UIKit
import AMVEditableMediaView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let persona = Estudiante()
        print(persona.saludar())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

public class Estudiante : Persona {
    public override func saludar() {
        print("Hola Señor")
    }
}
