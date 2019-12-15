//
//  FocusSquare.swift
//  AR Detection
//
//  Created by Jin on 2019/11/25.
//

import SceneKit

class FocusSquare :SCNNode{
    override init() {
        super.init()
        let plane = SCNPlane(width: 0.1, height: 0.1)
        plane.firstMaterial?.diffuse.contents = UIImage(named: "close")
        plane.firstMaterial?.isDoubleSided = true
        geometry = plane
        eulerAngles.x = GLKMathDegreesToRadians(-90)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
