//
//  CanvasSokoban.swift
//  sokobanVictor
//
//  Created by Victor Lee on 11/5/20.
//

import UIKit
import SpriteKit

@IBDesignable
class CanvasSokoban: UIView {
    
    private var model: Model?
    private var playerImage = UIImage(named: "character2d")
    private var wall = UIImage(named: "wall2d")
    private var floor = UIImage(named: "floor2d")
    private var box = UIImage(named: "box2d")
    private var target = UIImage(named: "target2d")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    public func connectToModel(model: Model) {
        self.model = model
    }
    
    public func update() {
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        
        let desktop: [[Int]] = model!.getDesktop()
        
        //Draw Desktop
        var xDesktop = 8.0
        var yDesktop = 50.0
        let widthDesktop = 28.5
        let heightDesktop = 30.0
        let offset = 3.0
        
        
        for i in 0..<desktop.count  {
            for j in 0..<desktop[i].count  {
                let element = desktop[i][j]
                if(element == Helper.character) {
                    playerImage?.draw(at: CGPoint(x: xDesktop, y: yDesktop))
                   
                } else if element == Helper.wall {
                    wall?.draw(at: CGPoint(x: xDesktop, y: yDesktop))
            
                }else if element == Helper.box {

                    box?.draw(at: CGPoint(x: xDesktop, y: yDesktop))
                    
                }else if element == Helper.goal  {

                    target?.draw(at: CGPoint(x: xDesktop, y: yDesktop))
                    
                }else if element == Helper.floor {

                    floor?.draw(at: CGPoint(x: xDesktop, y: yDesktop))
                    
                }

                xDesktop = xDesktop + widthDesktop + offset
            }
            xDesktop = 8.0
            yDesktop = yDesktop + heightDesktop + offset
        }
    }
}
