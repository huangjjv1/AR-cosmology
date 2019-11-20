//
//  ViewController.swift
//  Detecting test
//
//  Created by Jin on 2019/11/17.
//  Copyright © 2019 Jin. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
//        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        guard let referenceImages = ARReferenceImage.referenceImages(
            inGroupNamed: "AR Resources", bundle: Bundle.main) else{ return }
        configuration.trackingImages = referenceImages
        configuration.maximumNumberOfTrackedImages = 1

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    

    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        if anchor is ARImageAnchor{
            let plane = SCNPlane(width: 0.7, height: 0.35)
            let PlanetScene = SKScene(fileNamed: "PlaneScene")
            plane.firstMaterial?.diffuse.contents = PlanetScene
            plane.firstMaterial?.isDoubleSided = true
            plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1), 0, 1, 0)
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x  = -.pi/2
            
            var planetNode = SCNNode()
            let planetScene = SCNScene(named: "art.scnassets/ball.scn")!
            planetNode = planetScene.rootNode.childNodes.first!
            planetNode.position = SCNVector3(0, 0, 0.2)
            
            node.addChildNode(planeNode)
            planeNode.addChildNode(planetNode)
            planetNode.runAction(rotateObject())
        }
        return node
    }
    func rotateObject() -> SCNAction{
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(360)), z: 0, duration: 3)
        let repeatAction = SCNAction.repeatForever(action)
        return repeatAction
        
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
