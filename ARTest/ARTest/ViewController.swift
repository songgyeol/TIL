//
//  ViewController.swift
//  ARTest
//
//  Created by 송결 on 2022/06/01.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    //객체생성
    let scene = SCNScene()
    
    //객체생성, SCNBox 에는 width, height, length, chamferRadius 네가지 속성이 존재. 이때 속성의 단위는 meter
    let box : SCNGeometry = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SCNMaterial 객체 생성후 속성 추가
        /*material은 큐브(여기서는 box)에 붙일 수 있는 것으로 색깔이 될 수도,
        이미지가 될 수도 있음. 위의 예에서는 빨간색 색상을 적용*/
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red
        
        
        // SCNNode 객체 생성 후 속성 추가
        /*극적으로 SceneKit 에서는 다양한 material 과 모양이 적용된 노드들을 가지고 SceneKitView에 적용할 것이기 때문에 가장 중요한 부분이라고 할 수 있음.
        node의 geometry와 적용될 materials 가 앞서 생성한 box와 material 이라고 설정하고 위치를 정해줌.
         3D 공간에서 작업할 것이므로 Vector 를 사용하며 x, y, z 좌표를 지정해줌. 이도 meter 법 적용.
         x — 좌/우
         y — 상/하
         z — 앞/뒤*/
        let node = SCNNode()
        node.geometry = box
        node.geometry?.materials = [material]
        node.position = SCNVector3(0, 0.1, -0.5)
        
        //scene의 rootNode 에 생성한 node 를 childNode로서 추가
        scene.rootNode.addChildNode(node)
        
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
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
