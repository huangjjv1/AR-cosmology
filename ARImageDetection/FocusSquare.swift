//
//  FocusSquare.swift
//  AR Detection
//
//  Created by Jin on 2019/11/25.
//
// this was supposed to display a dynamic square in the middle of the sreen, but actually we don't have to use it
// We use a static button instead to refresh the screen. We leave it here just in case we need a dynamic verion in the future.
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
