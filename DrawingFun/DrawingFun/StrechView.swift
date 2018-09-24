//
//  StrechView.swift
//  DrawingFun
//
//  Created by Sweta Kumari on 9/19/18.
//  Copyright © 2018 Sweta Kumari. All rights reserved.
//

import Cocoa

class StrechView: NSView {

    var path = NSBezierPath()
    @objc dynamic var opacity:Float = 0.5
    @objc dynamic var image:NSImage = NSImage()
    
    // where the mouse is first clicked
    var downPoint = NSPoint()
    // where it is dragged to, and released
    var currentPoint = NSPoint()
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        srandom(2)
        path.lineWidth = 3.0
        var p:NSPoint = self.randomPoint()
        path.move(to: p)
        
        for _ in 0...14 {
            p = self.randomPoint()
            path.line(to: p)
        }
        path.close()
    }
    
    func randomPoint()->NSPoint {
        let r:NSRect = self.bounds
        let nx = r.origin.x + CGFloat(Int(arc4random()) % Int(r.size.width))
        let ny = r.origin.y + CGFloat(Int(arc4random()) % Int(r.size.height))
        return NSPoint(x: nx, y: ny)
    }
  
    // To resize window
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let bounds = self.bounds
        NSColor.green.set()
        NSBezierPath.fill(bounds)
        
        NSColor.white.set()
        path.stroke()
        // draw image
        var imageRect = NSRect()
        imageRect.origin = NSZeroPoint
        imageRect.size = image.size
        let drawingRect = imageRect
        image.draw(in: drawingRect, from: imageRect,
                   operation: NSCompositingOperation.sourceOver,
                   fraction: CGFloat(opacity))
    }
    
    override var intrinsicContentSize: NSSize {
        return NSSize(width: 400, height: 400)
    }
    
    override func mouseDown(with theEvent: NSEvent) {
        let p = theEvent.locationInWindow
        downPoint = convert(p, from: nil)
        currentPoint = downPoint
        self.needsDisplay = true
        Swift.print("mouseDown in \(self.className) at \(p)")
        nextResponder?.mouseDown(with: theEvent)
    }
    override func mouseDragged(with theEvent: NSEvent) {
        let p = theEvent.locationInWindow
        currentPoint = convert(p, from: nil)
        self.autoscroll(with: theEvent)
        self.needsDisplay = true
    }
    override func mouseUp(with theEvent: NSEvent) {
        let p = theEvent.locationInWindow
        currentPoint = convert(p, from: nil)
        self.needsDisplay = true
    }
    func currentRect()->NSRect{
        let minX = min(downPoint.x, currentPoint.x)
        let maxX = max(downPoint.x, currentPoint.x)
        let minY = min(downPoint.y, currentPoint.y)
        let maxY = max(downPoint.y, currentPoint.y)
        
        return NSMakeRect(minX, minY, maxX-minX, maxY-minY)
    }
}

