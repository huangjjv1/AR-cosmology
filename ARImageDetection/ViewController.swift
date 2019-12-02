//
//  ViewController.swift
//  ARImageDetection
//
//  Created by Willie Yam on 2018-07-09.
//  Copyright © 2018 Willie Yam. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    var planetNode=SCNNode()
//    var focusSquare: FocusSquare?
    @IBOutlet var sceneView: ARSCNView!
    @IBAction func placeScreenButtonTapped(_ sender: UIButton) {
        let configuration = ARImageTrackingConfiguration()
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: Bundle.main) else { return }
        configuration.trackingImages = referenceImages
        configuration.maximumNumberOfTrackedImages = 1
        sceneView.session.pause()
        sceneView.session.run(configuration)
    }
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        let scalePlus = SCNAction.scale(by: 1.3, duration: 2)
        planetNode.runAction(scalePlus)
    }
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        let scaleMinus = SCNAction.scale(by: 0.7, duration: 2)
        planetNode.runAction(scaleMinus)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin,ARSCNDebugOptions.showFeaturePoints]
        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
//        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: Bundle.main) else { return }
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
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> (SCNNode?) {
        let name = anchor.name!
        var node:SCNNode
        var iPhoneNode = SCNNode()
        (node,iPhoneNode) = spawningmodel(name: name)
        planetNode = iPhoneNode
        print(name)
//        guard focusSquare == nil else {
//            return
//        }
//        guard focusSquare == nil else {return}
//        let focusSquareLocal = FocusSquare()
//        sceneView.scene.rootNode.addChildNode(focusSquareLocal)
//        focusSquare = focusSquareLocal
        return node
    }
    func spawningmodel(name:String)->(SCNNode,SCNNode){
        let node = SCNNode()
        let plane = SCNPlane(width: 0.7, height: 0.35)
        let deviceScene = SKScene(fileNamed: name)
        var iPhoneNode=SCNNode()
        plane.firstMaterial?.diffuse.contents = deviceScene
        plane.firstMaterial?.isDoubleSided = true
        plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1), 0, 1, 0)

        let planeNode = SCNNode(geometry: plane)
        planeNode.eulerAngles.x = -.pi / 2
        
//        var iPhoneNode = SCNNode()
        let location = "art.scnassets/" + name + ".scn"
        let iPhoneScene = SCNScene(named:location)!
        iPhoneNode = iPhoneScene.rootNode.childNodes.first!
        iPhoneNode.position = SCNVector3(0, 0, 0.15)
        node.addChildNode(planeNode)
        planeNode.addChildNode(iPhoneNode)
        iPhoneNode.runAction(rotateObject())
        return (node,iPhoneNode)
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
