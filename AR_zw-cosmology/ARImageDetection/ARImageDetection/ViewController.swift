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
    
    var nowNode = SCNNode()
    
    var asyncPrevent = false

    @IBOutlet var sceneView: ARSCNView!
    
    @IBAction func placeScreenButtonTapped(_ sender: UIButton) {
        let anchors = sceneView.session.currentFrame!.anchors
        print(anchors)
        for anchor in anchors {
            if let someNode = sceneView.node(for: anchor){
                someNode.removeFromParentNode()
            }
            sceneView.session.remove(anchor: anchor)
        }
        nowNode.removeFromParentNode()
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        let scalePlus = SCNAction.scale(by: 2, duration: 2)
        nowNode.runAction(scalePlus)
    }
    
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        let scaleMinus = SCNAction.scale(by: 0.5, duration: 2)
        nowNode.runAction(scaleMinus)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeToDialog" {
            let toVC = segue.destination as! DialogViewController
            toVC.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
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
        configuration.isLightEstimationEnabled = true

        // Run the view's session
        sceneView.session.run(configuration)
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
    // MARK: - ARSCNViewDelegate
    func rotateObject() -> SCNAction {
        let action = SCNAction.rotateBy(x: 0, y: 0, z: CGFloat(GLKMathDegreesToRadians(360)), duration: 3)
        let repeatAction = SCNAction.repeatForever(action)
        return repeatAction
    }

    // Override to create and configure nodes for anchors added to the view's session.
//    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
//        let node = SCNNode()
//        let animator = SCNAction.scale(by: 10, duration: 3)
//        if anchor is ARImageAnchor {
//            guard let imageAnchor = anchor as? ARImageAnchor,
//            let imageName = imageAnchor.referenceImage.name else { return node }
//            switch imageName {
//            case "iPhoneX":
//                var iPhoneNode = SCNNode()
//                let iPhoneScene = SCNScene(named: "art.scnassets/iPhoneX.scn")!
//                iPhoneNode = iPhoneScene.rootNode.childNodes.first!
//                iPhoneNode.position = SCNVector3(0, 0, 0)
//                iPhoneNode.eulerAngles.x = -.pi / 2
//
//                let min = iPhoneNode.boundingBox.min
//                let max = iPhoneNode.boundingBox.max
//                iPhoneNode.pivot = SCNMatrix4MakeTranslation(
//                    min.x + (max.x - min.x)/2,
//                    min.y + (max.y - min.y)/2,
//                    min.z + (max.z - min.z)/2)
//
//                let iPhoneLight = iPhoneScene.rootNode.childNodes.filter({ $0.name == "spot" }).first!
//
//                node.addChildNode(iPhoneNode)
//                iPhoneNode.addChildNode(iPhoneLight)
//                iPhoneNode.runAction(rotateObject())
//                iPhoneNode.runAction(animator)
//                nowNode = iPhoneNode
//            case "tree":
//                let scene = SCNScene(named: "art.scnassets/tree.scn")!
//                let treeNode = scene.rootNode.childNodes.first!
//                let scaleFactor  = 0.001
//                treeNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
//                treeNode.position = SCNVector3(0, 0, 0)
//                treeNode.eulerAngles.x = -.pi / 2
//                let min = treeNode.boundingBox.min
//                let max = treeNode.boundingBox.max
//                treeNode.pivot = SCNMatrix4MakeTranslation(
//                    min.x + (max.x - min.x)/2,
//                    min.y + (max.y - min.y)/2,
//                    min.z + (max.z - min.z)/2)
//
//                node.addChildNode(treeNode)
//                treeNode.runAction(rotateObject())
//                treeNode.runAction(animator)
//                nowNode = treeNode
//            case "book":
//                let scene = SCNScene(named: "art.scnassets/book.scn")!
//                let bookNode = scene.rootNode.childNodes.first!
//                let scaleFactor  = 0.025
//                bookNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
//                bookNode.position = SCNVector3(0, 0, 0)
//                let min = bookNode.boundingBox.min
//                let max = bookNode.boundingBox.max
//                bookNode.pivot = SCNMatrix4MakeTranslation(
//                    min.x + (max.x - min.x)/2,
//                    min.y + (max.y - min.y)/2,
//                    min.z + (max.z - min.z)/2)
//
//                node.addChildNode(bookNode)
//                bookNode.runAction(rotateObject())
//                bookNode.runAction(animator)
//                nowNode = bookNode
//            case "mountain":
//                let scene = SCNScene(named: "art.scnassets/mountain.scn")!
//                let mountainNode = scene.rootNode.childNodes.first!
//                let scaleFactor  = 0.025
//                mountainNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
//                mountainNode.position = SCNVector3(0, 0, 0)
//                mountainNode.eulerAngles.x = -.pi / 2
//                let min = mountainNode.boundingBox.min
//                let max = mountainNode.boundingBox.max
//                mountainNode.pivot = SCNMatrix4MakeTranslation(
//                    min.x + (max.x - min.x)/2,
//                    min.y + (max.y - min.y)/2,
//                    min.z + (max.z - min.z)/2)
//
//                node.addChildNode(mountainNode)
//                mountainNode.runAction(rotateObject())
//                mountainNode.runAction(animator)
//                nowNode = mountainNode
//            default:
//                break
//            }
//        }
//        return node
//    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if asyncPrevent == false {
            asyncPrevent = true
        } else {
            sceneView.session.remove(anchor: anchor)
            return
        }
        let animator = SCNAction.scale(by: 10, duration: 3)
        if anchor is ARImageAnchor {
            guard let imageAnchor = anchor as? ARImageAnchor,
            let imageName = imageAnchor.referenceImage.name else { return }
            switch imageName {
            case "iPhoneX":
                var iPhoneNode = SCNNode()
                let iPhoneScene = SCNScene(named: "art.scnassets/iPhoneX.scn")!
                iPhoneNode = iPhoneScene.rootNode.childNodes.first!
                iPhoneNode.position = SCNVector3(0, 0, 0)
                iPhoneNode.eulerAngles.x = -.pi / 2
                
                let min = iPhoneNode.boundingBox.min
                let max = iPhoneNode.boundingBox.max
                iPhoneNode.pivot = SCNMatrix4MakeTranslation(
                    min.x + (max.x - min.x)/2,
                    min.y + (max.y - min.y)/2,
                    min.z + (max.z - min.z)/2)
                
                let iPhoneLight = iPhoneScene.rootNode.childNodes.filter({ $0.name == "spot" }).first!

                node.addChildNode(iPhoneNode)
                iPhoneNode.addChildNode(iPhoneLight)
                iPhoneNode.runAction(rotateObject())
                iPhoneNode.runAction(animator)
                nowNode = iPhoneNode
            case "tree":
                let scene = SCNScene(named: "art.scnassets/tree.scn")!
                let treeNode = scene.rootNode.childNodes.first!
                let scaleFactor  = 0.001
                treeNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
                treeNode.position = SCNVector3(0, 0, 0)
                treeNode.eulerAngles.x = -.pi / 2
                let min = treeNode.boundingBox.min
                let max = treeNode.boundingBox.max
                treeNode.pivot = SCNMatrix4MakeTranslation(
                    min.x + (max.x - min.x)/2,
                    min.y + (max.y - min.y)/2,
                    min.z + (max.z - min.z)/2)
                
                node.addChildNode(treeNode)
                treeNode.runAction(rotateObject())
                treeNode.runAction(animator)
                nowNode = treeNode
            case "book":
                let scene = SCNScene(named: "art.scnassets/book.scn")!
                let bookNode = scene.rootNode.childNodes.first!
                let scaleFactor  = 0.025
                bookNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
                bookNode.position = SCNVector3(0, 0, 0)
                let min = bookNode.boundingBox.min
                let max = bookNode.boundingBox.max
                bookNode.pivot = SCNMatrix4MakeTranslation(
                    min.x + (max.x - min.x)/2,
                    min.y + (max.y - min.y)/2,
                    min.z + (max.z - min.z)/2)
                
                node.addChildNode(bookNode)
                bookNode.runAction(rotateObject())
                bookNode.runAction(animator)
                nowNode = bookNode
            case "mountain":
                let scene = SCNScene(named: "art.scnassets/mountain.scn")!
                let mountainNode = scene.rootNode.childNodes.first!
                let scaleFactor  = 0.025
                mountainNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
                mountainNode.position = SCNVector3(0, 0, 0)
                mountainNode.eulerAngles.x = -.pi / 2
                let min = mountainNode.boundingBox.min
                let max = mountainNode.boundingBox.max
                mountainNode.pivot = SCNMatrix4MakeTranslation(
                    min.x + (max.x - min.x)/2,
                    min.y + (max.y - min.y)/2,
                    min.z + (max.z - min.z)/2)
                
                node.addChildNode(mountainNode)
                mountainNode.runAction(rotateObject())
                mountainNode.runAction(animator)
                nowNode = mountainNode
            default:
                break
            }
        }
        asyncPrevent = false
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
    
    
    let fadeDuration: TimeInterval = 0.3
    let rotateDuration: TimeInterval = 3
    let waitDuration: TimeInterval = 0.5
    lazy var fadeAndSpinAction: SCNAction = {
        return .sequence([
            .fadeIn(duration: fadeDuration),
            .rotateBy(x: 0, y: 0, z: CGFloat.pi * 360 / 180, duration: rotateDuration),
            .wait(duration: waitDuration),
            .fadeOut(duration: fadeDuration)
            ])
    }()
    
    lazy var fadeAction: SCNAction = {
        return .sequence([
            .fadeOpacity(by: 0.8, duration: fadeDuration),
            .wait(duration: waitDuration),
            .fadeOut(duration: fadeDuration)
            ])
    }()
    
    lazy var treeNode: SCNNode = {
        guard let scene = SCNScene(named: "tree.scn"),
        let node = scene.rootNode.childNode(withName: "tree", recursively: false) else { return SCNNode() }
        let scaleFactor = 0.005
        node.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        node.eulerAngles.x = -.pi / 2
        return node
    }()
    
    lazy var bookNode: SCNNode = {
        guard let scene = SCNScene(named: "book.scn"),
            let node = scene.rootNode.childNode(withName: "book", recursively: false) else { return SCNNode() }
        let scaleFactor  = 0.1
        node.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        return node
    }()
    
    lazy var mountainNode: SCNNode = {
        guard let scene = SCNScene(named: "mountain.scn"),
            let node = scene.rootNode.childNode(withName: "mountain", recursively: false) else { return SCNNode() }
        let scaleFactor  = 0.25
        node.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        node.eulerAngles.x += -.pi / 2
        return node
    }()
    
    lazy var iPhoneNode: SCNNode = {
        guard let scene = SCNScene(named: "iPhoneX.scn") else { return SCNNode() }
//        let scaleFactor  = 0.25
//        node.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        var node = SCNNode()
        node = scene.rootNode.childNodes.first!
        node.position = SCNVector3(0, 0, 0.15)
        node.eulerAngles.x += -.pi / 2
        let iPhoneLight = scene.rootNode.childNodes.filter({ $0.name == "spot" }).first!
        node.addChildNode(iPhoneLight)
        return node
    }()
    
    func getNode(withImageName name: String) -> SCNNode {
        var node = SCNNode()
        switch name {
        case "Book":
            node = bookNode
        case "Snow Mountain":
            node = mountainNode
        case "Trees In the Dark":
            node = treeNode
        default:
            break
        }
        return node
    }
}

extension ViewController: DialogViewControllerDelegate {
    func screenImageButtonTapped(image: UIImage) {
        nowNode.geometry?.firstMaterial?.diffuse.contents = image
    }
}
