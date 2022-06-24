//
//  ViewController.swift
//  usdzInteractive
//
//  Created by Tunay Toksöz on 22.06.2022.
//

import UIKit
import SceneKit
import SceneKit.ModelIO
import MobileCoreServices
import UniformTypeIdentifiers

class ViewController: UIViewController, UIDocumentPickerDelegate, UINavigationControllerDelegate {
  
    
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var ScnView: SCNView!
    var usdzPath :URL = Bundle.main.url(forResource: "AirForce", withExtension: "usdz")!
    
    var value : Float = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sceneView = ScnView
        
      
        
        let url = usdzPath
        let asset = MDLAsset(url: url)
        // MDLTexture
        asset.loadTextures()
        
        
        let scene = SCNScene(mdlAsset: asset)
        scene.background.contents = UIImage(named: "way.hdr")
        
        scene.rootNode.position = SCNVector3(x: 0, y: 0, z: 0.0)
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        
        cameraNode.position = SCNVector3(x: value, y: value , z: 30 + value*1.5)
        
        scene.rootNode.addChildNode(cameraNode)
        
        
        sceneView!.scene = scene
        
        sceneView!.showsStatistics = true
        
        sceneView!.allowsCameraControl = true
        
        sceneView!.antialiasingMode = SCNAntialiasingMode.multisampling4X
        
        sceneView!.autoenablesDefaultLighting = true
        ScnView = sceneView
    }
    
    
    @IBAction func slider(_ sender: UISlider) {
        value = sender.value
        value = value * 25
        //print(value)
        viewDidLoad()
    }
    
    
    @IBAction func filepick2(_ sender: Any) {
        
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.usdz])
              documentPicker.delegate = self
              present(documentPicker, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
                    
                    let path = url as URL
                    let sec_path = path.startAccessingSecurityScopedResource()
                    print(path)
                    print(url)

                    print(path.lastPathComponent)

                    print(path.pathExtension)
                    usdzPath = path
                    viewDidLoad()
                   }

}

