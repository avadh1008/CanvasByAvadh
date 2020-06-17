//
//  ViewController.swift
//  CanvasByAvadh
//
//  Created by Avadh Mewada on 6/16/20.
//  Copyright © 2020 Avadh Mewada. All rights reserved.
//

import UIKit
import PencilKit
class ViewController: UIViewController {

    var someCanva = PKCanvasView()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        NavigationBarUpdate()
        self.view.backgroundColor = UIColor.white
    }
    func NavigationBarUpdate(){
        let someView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 35, width: view.frame.size.width, height: view.frame.size.width / 2))
        
        view.addSubview(someView)
        view.addSubview(navBar)
        
        let Undo = UIBarButtonItem(title: "Undo", style: .plain, target: self, action: #selector(UndoTapped))
        let Redo = UIBarButtonItem(title: "Redo", style: .plain, target: self, action: #selector(RedoTapped))
        let image = UIBarButtonItem(title: "Image", style: .plain, target: self, action:#selector(createImage))
        
        let clear = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(cleanSpace))
        let navItem = UINavigationItem(title: "My Canvas")
        
        navItem.leftBarButtonItems = [Undo, Redo]
        navItem.rightBarButtonItems = [image,clear]
        navBar.barTintColor = UIColor.systemBlue
        navBar.tintColor = .white
        
        someView.backgroundColor = UIColor.white
        navBar.setItems([navItem], animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SetupCanvasView()
    }
    
    private func SetupCanvasView(){
        someCanva = PKCanvasView(frame: CGRect(x: 0, y: 100, width: view.frame.size.width, height: view.frame.height - 35))
        someCanva.backgroundColor = UIColor.white
        view.addSubview(someCanva)
        if let window = view.window, let toolPicker = PKToolPicker.shared(for: window){
            toolPicker.setVisible(true, forFirstResponder: someCanva)
            toolPicker.addObserver(someCanva)
        
            someCanva.becomeFirstResponder()
        }
    }
    
    @objc func RedoTapped(){
        
        print("RedoTapped")
    }
    @objc func UndoTapped(){
        print("UndoTapped")
    }
    @objc func createImage(){
        let image = UIGraphicsImageRenderer(bounds: someCanva.bounds).image { _ in
            view.drawHierarchy(in: someCanva.bounds, afterScreenUpdates: true)
        }
    }
    @objc func cleanSpace(){
        someCanva.drawing = PKDrawing()
        print("cleanSpaceTapped")
    }
}
