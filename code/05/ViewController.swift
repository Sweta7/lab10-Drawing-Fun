//
//  ViewController.swift
//  DrawingFun
//
//  Created by David Eyers on 18/09/17.
//  Copyright © 2017 David Eyers. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var stretchView: StretchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func openDocument(_ sender: AnyObject) {
        let panel = NSOpenPanel()
        panel.allowedFileTypes = NSImage.imageTypes()
        panel.beginSheetModal(for: stretchView.window!,
                              completionHandler: { (returnCode)-> Void in
                                if returnCode == NSModalResponseOK {
                                    let image = NSImage(byReferencing: panel.url!)
                                    self.stretchView.image = image
                                    self.stretchView.needsDisplay = true
                                    self.stretchView.downPoint = NSZeroPoint
                                    self.stretchView.currentPoint = NSPoint(x: image.size.width,
                                                                            y: image.size.height)
                                    
                                } } )
    }
   
}

