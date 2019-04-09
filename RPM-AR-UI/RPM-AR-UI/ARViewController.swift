import UIKit
import ARKit
import SceneKit

class ARViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var sceneHits: SCNScene!
    
    
    var objectsOnScreen: Array<SCNNode> = Array()
    
    
    var objNode: SCNNode = SCNNode()
    var emptyNode: SCNNode = SCNNode()
    
    var objSelected: Objs!
    
    var objDetailsScript: DetailViewController!
    
    var objPicked: Array<Objs> = Array()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emptyNode = objNode
        
        addTapGestureToSceneView()
        
        configureLighting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpSceneView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func setUpSceneView() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
        
        sceneView.delegate = self
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        
    }
    
    
    
    func configureLighting() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }
    
    //add 3D Objects to scene
    @objc func addObjectToScene(withGestureRecognizer recognizer: UIGestureRecognizer) {
        //checking # of objs on screen and that a Obj has been selected
        if(objectsOnScreen.count < 2 && objSelected != nil){
            
            //setting loaction for object
            let tapLocation = recognizer.location(in: sceneView)
            let hitTestResults = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
            
            //setting obj x, y, z
            guard let hitTestResult = hitTestResults.first else { return }
            let translation = hitTestResult.worldTransform.translation
            let x = translation.x
            let y = translation.y
            let z = translation.z
            
            //For 3D Models
            //loading selected SCN
            guard let sceneObj = SCNScene(named: objSelected.sceneName, inDirectory: "art.scnassets"),
                let sNode = sceneObj.rootNode.childNode(withName: objSelected.id, recursively: false)
                else { return }

            //adding scene to view
            sNode.position = SCNVector3(x,y,z)
            sceneView.scene.rootNode.addChildNode(sNode)
            //tracking objects on screen
            objectsOnScreen.append(sNode)
        }else if(objectsOnScreen.count == 2){
            let touchLocation = recognizer.location(in: sceneView)
            let obj1 = objectsOnScreen[0]
            let obj2 = objectsOnScreen[1]
            
        
        }
        
    }
    
    
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ARViewController.addObjectToScene(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
}

extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}

extension UIColor {
    open class var transparentLightBlue: UIColor {
        return UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 0.50)
    }
}

extension ARViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // 1
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        // 2
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        let plane = SCNPlane(width: width, height: height)
        
        // 3
        plane.materials.first?.diffuse.contents = UIColor.transparentLightBlue
        
        // 4
        let planeNode = SCNNode(geometry: plane)
        
        // 5
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x,y,z)
        planeNode.eulerAngles.x = -.pi / 2
        
        // 6
        node.addChildNode(planeNode)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // 1
        guard let planeAnchor = anchor as?  ARPlaneAnchor,
            let planeNode = node.childNodes.first,
            let plane = planeNode.geometry as? SCNPlane
            else { return }
        
        // 2
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        plane.width = width
        plane.height = height
        
        // 3
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x, y, z)
    }
}
