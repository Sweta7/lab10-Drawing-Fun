//
//  StretchView.swift
//  DrawingFun
//
//  Created by David Eyers on 20/09/16.
//  Updated for Xcode 8.3 and Swift 3.x in September 2017
//

import Cocoa

class StretchView: NSView {
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let bounds = self.bounds
        NSColor.green.set()
        NSBezierPath.fill(bounds)
    }
}
