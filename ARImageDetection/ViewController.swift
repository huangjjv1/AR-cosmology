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
    var nodeName: String!
    var targetNumber = 1
    var targetName = String()
    var currentAnchorName = String()
    
    
    func giveClues(text:String,title:String) {
        let alert = UIAlertController(title: "Clues Box", message: "这是一个弹窗", preferredStyle: .alert)
//        let cancel = UIAlertAction(title: "Retuen", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "Got it", style: .default, handler: {
            ACTION in
            print("Got it!")
        })
        alert.addAction(ok)
        let textPrint = text
        alert.message = textPrint
        alert.title = title
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func reRecongnize(_ sender: Any) {
        viewWillDisappear(true)
        let anchors_all = sceneView.session.currentFrame!.anchors
        for anchor in anchors_all {
            sceneView.session.remove(anchor: anchor)
        }
        print(sceneView.session.currentFrame!.anchors)
        viewWillAppear(true)
        
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeToDetail" {
            let toViewController = segue.destination as! DetailViewController
            toViewController.nodeName = nodeName
        }
        
        if segue.identifier == "HomeToHint" {
            let toViewController = segue.destination as! HintViewController
            toViewController.nodeName = targetName
        }
    }
    //    var focusSquare: FocusSquare?
    open var userScore: Int = 0 {
           didSet {
               // ensure UI update runs on main thread
               DispatchQueue.main.async {
                   self.scoreLabel.text = "Your current score:" + String(self.userScore)
               }
           }
       }
    @IBAction func gameStart(_ sender: UIButton) {
        
        if self.scoreLabel.alpha == 0{
            self.scoreLabel.alpha = 100
            targetNumber = Int(arc4random() % 6 + 1)
            targetName = "target" + String(targetNumber)
            let text = "Please find the first target:" + targetName + "\nHere are some Clues ..."
            giveClues(text: text,title:"Game Start!")
            print("Please find the first target:",targetName)
        }else{
            self.scoreLabel.alpha = 0
            self.userScore = 0
            let text = "Game ends. Thank you!"
            giveClues(text: text,title:"Game Over")
            print("Game ends. Thank you!")
        }
    }
    @IBOutlet var sceneView: ARSCNView!
    @IBAction func placeScreenButtonTapped(_ sender: UIButton) {
//        let anchors = sceneView.session.currentFrame!.anchors
//            print(anchors)
//            for anchor in anchors {
//                if let someNode = sceneView.node(for: anchor){
//                    someNode.removeFromParentNode()
//                }
//                sceneView.session.remove(anchor: anchor)
//            }
//            nowNode.removeFromParentNode()
//        }
        
//        let name = anchors.last?.name
        currentAnchorName = sceneView.session.currentFrame!.anchors.last!.name!
        if currentAnchorName == targetName {
            self.userScore += 1
            print("bingo! right!")
            targetNumber = Int(arc4random() % 6 + 1)
            targetName = "target" + String(targetNumber)
            let text = "Please find the next target:" + targetName + "\nHere are some Clues ...\nOr press the game button to quit"
            giveClues(text: text,title:"You are right!")
            print("Please find the next:",targetName)
        }else{
            let text = "present target is :" + currentAnchorName + ", please go on to find" + targetName
            giveClues(text: text,title:"Not this one :)")
            print("present target is :",currentAnchorName)
            print("Not this one, please go on!, to find:",targetName)
        }
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
        self.userScore = 0
        self.scoreLabel.alpha = 0
        self.targetName = ""
        self.nodeName = ""
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
        currentAnchorName = name
        var node:SCNNode
        var iPhoneNode = SCNNode()
        (node,iPhoneNode) = spawningmodel(name: name)
        planetNode = iPhoneNode
//        print(name)
        nodeName = name
//        guard focusSquare == nil else {
//            return
//        }
//        guard focusSquare == nil else {return}
//        let focusSquareLocal = FocusSquare()
//        sceneView.scene.rootNode.addChildNode(focusSquareLocal)
//        focusSquare = focusSquareLocal
        let anchors = sceneView.session.currentFrame!.anchors
        for anchor in anchors {
            sceneView.session.remove(anchor: anchor)
        }
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
