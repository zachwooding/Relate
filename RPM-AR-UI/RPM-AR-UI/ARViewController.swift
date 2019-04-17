import UIKit
import ARKit
import SceneKit

class ARViewController: UIViewController {
    
    @IBOutlet weak var arSceneView: ARSCNView!
    @IBOutlet var sceneView:SCNView! = SCNView()
    @IBOutlet weak var sceneHits: SCNScene!
    
    @IBOutlet var titleOfSession: UINavigationItem!
    @IBOutlet var timeLeftLabel: UILabel!
    
    var timer: Timer?
    var timeLeft: Double?
    
    var objectsOnScreen: Array<SCNNode> = Array()
    var objNode: SCNNode = SCNNode()
    var emptyNode: SCNNode = SCNNode()
    
    var objSelected: Objs!
    
    var sessionInfo: Session!
    
    var objDetailsScript: DetailViewController!
    
    var objPicked: Array<Objs> = Array()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emptyNode = objNode
        
        addTapGestureToSceneView()
        
        configureLighting()
        
        manageSession()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpSceneView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arSceneView.session.pause()
    }
    
    func setUpSceneView() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        arSceneView.session.run(configuration)
        arSceneView.delegate = self
        arSceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        //arSceneView.addSubview(sceneView)
        
        
    }
    
    
    
    func configureLighting() {
        arSceneView.autoenablesDefaultLighting = true
        arSceneView.automaticallyUpdatesLighting = true
    }
    
    //add 3D Objects to scene
    @objc func addObjectToScene(withGestureRecognizer recognizer: UIGestureRecognizer) {
        //checking # of objs on screen and that a Obj has been selected
        if(objectsOnScreen.count < 2 && objSelected != nil){
            
            //setting loaction for object
            let tapLocation = recognizer.location(in: arSceneView)
            let hitTestResults = arSceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
            
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
            arSceneView.scene.rootNode.addChildNode(sNode)
            sceneView.scene?.rootNode.addChildNode(sNode)
            //tracking objects on screen
            objectsOnScreen.append(sNode)
            
        }
//        else if(objectsOnScreen.count == 2){
//            let touchLocation = recognizer.location(in: sceneView)
//            let obj1 = objectsOnScreen[0]
//            let obj2 = objectsOnScreen[1]
//
//
//        }
        
    }
    
    func resetTracking(){
        let configuration=ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal
        
        arSceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        arSceneView.delegate = self
        arSceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        addTapGestureToSceneView()
        
    }
    
    @objc func selectObjectsOnScreen(withGestureRecognizer recog: UIGestureRecognizer){
        arSceneView.scene.rootNode.enumerateChildNodes{
            (node, stop) in node.removeFromParentNode()
            resetTracking()
            
            
        }
        
        //arSceneView.hitTest(<#T##point: CGPoint##CGPoint#>, types: <#T##ARHitTestResult.ResultType#>)
       
//        let touchLocation = recog.location(in: arSceneView)
//        let hitTestResult = ARViewController.ren
//        let pickedObj = hitTestResult.first
//        let tappedObj = pickedObj?.node
//        for _ in objectsOnScreen{
//            let screenObj0 = objectsOnScreen[0]
//            let screenObj1 = objectsOnScreen[1]
//            if tappedObj == screenObj0{
//                objectsOnScreen.remove(at: 1)
//                arSceneView.scene.rootNode.
//
//
//            }else if tappedObj == screenObj1{
//                objectsOnScreen.remove(at: 0)
//            }
//
//        }
        
        

    }
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ARViewController.addObjectToScene(withGestureRecognizer:)))
        arSceneView.addGestureRecognizer(tapGestureRecognizer)
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ARViewController.selectObjectsOnScreen(withGestureRecognizer:)))
        longPressGestureRecognizer.minimumPressDuration = 1.0;
        arSceneView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    
    @IBAction func backToArView(unwindSegue: UIStoryboardSegue){
        
        
    }
    
    @objc func onTimerFires(){
        timeLeft -= 1
        timeLeftLabel.text = "\(timeLeft)"
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: sessionInfo.time, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    
    func manageSession(){
        titleOfSession.title = sessionInfo.name

        timeLeft = Double(sessionInfo.time)
        timeLeftLabel.text = "\(timeLeft)"
    
        
        
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
    func renderer(_renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor:ARAnchor){
        
        node.removeFromParentNode()
        
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera){
        
    }
    
    
}

