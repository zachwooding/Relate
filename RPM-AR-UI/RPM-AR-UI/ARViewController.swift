import UIKit
import ARKit
import SceneKit
import AVFoundation

class ARViewController: UIViewController {
    
    //scenes being used
    @IBOutlet weak var arSceneView: ARSCNView!
    //@IBOutlet var sceneView:SCNView! = SCNView()
    //@IBOutlet weak var sceneHits: SCNScene!
    
    //displays of session info
    @IBOutlet var titleOfSession: UINavigationItem!
    @IBOutlet var timeLeftLabel: UILabel!
    
    //timer setup
    var timer: Timer?
    var timeLeft: Double? = 1000.0
    
    //control for whats on screen
    var objectsOnScreen: Array<SCNNode> = Array()
    //var emptyNode: SCNNode = SCNNode()
    
    //object picked from details
    var objSelected: Objs!
    var objDetailsScript: DetailViewController!
    
    //all objects listed in ObjectList
    var allObjs: Array<Objs> = Array()
    
    //session data and saving sessions
    var savedSessions: Array<Session>!
    var sessionInfo: Session!
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let objListControl = ObjectList()
        allObjs = objListControl.get()
        
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
        //arSceneView.scene.rootNode.addChildNode(emptyNode)
       //arSceneView.scene.rootNode.addChildNode(emptyNode)
        
        
    }
    
    
    
    func configureLighting() {
        arSceneView.autoenablesDefaultLighting = true
        arSceneView.automaticallyUpdatesLighting = true
    }
    
    //add 3D Objects to scene
    @objc func addObjectToScene(withGestureRecognizer recognizer: UIGestureRecognizer) {
        //checking # of objs on screen and that a Obj has been selected
        var isOnScreen = false
        for obj in objectsOnScreen{
            if objSelected.name == obj.name{
                isOnScreen = true
                break
            }
        }
        if(objSelected != nil && objectsOnScreen.count < 2 && isOnScreen == false){
            
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
            //tracking objects on screen
            objectsOnScreen.append(sNode)
            
        }
        
    }
    
    //selecting objects that are on screen
    @objc func selectObjectsOnScreen(withGestureRecognizer recog: UIGestureRecognizer){
        
        //setting the location touched
        let touchLocation = recog.location(in: arSceneView)
        
        //checking for object hit
        let hitTestResult = arSceneView.hitTest(touchLocation, options: nil)
        
        //getting all objects on screen
        let objArray = arSceneView.scene.rootNode.childNodes
        
        //checking if object has already been removed
        var isRemoved = false
        
        var objPickedName = ""
        var objNotPickedName = ""
        //iterating through hit objects
        for pickedObj in hitTestResult{
            
            //iterating through objects on screen
            for obj in objArray{
                
                //checking names of objects that have been hit vs objects on screen.
                //also checking if objects are named to prevent nil object errors
                //this will work because all objects that the user can add will be named
                if pickedObj.node.name != obj.name && obj.name != nil && pickedObj.node.name != nil{
                    
                    //finding the object that is named in the stored array to double check
                    for onScreenObj in objectsOnScreen{
                        
                        //object that is not selected is found here
                        if obj.name == onScreenObj.name{
                            objPickedName = pickedObj.node.name!
                            //sending name to text to speech method
                            readObj(sceneObj: pickedObj.node.name!)
                            
                            objNotPickedName = onScreenObj.name!
                            //removing object that was not selected
                            objectsOnScreen.remove(at: objectsOnScreen.index(of: onScreenObj)!)
                            
                            //matching the selected object with Objs object for session storage
                            for theObj in allObjs{
                                
                                //storing selected object
                                if theObj.name == objPickedName{
                                    sessionInfo.objsPicked.append(theObj)
                                }
                                
                                //storing not selected
                                if theObj.name == objNotPickedName{
                                    sessionInfo.objsNotPicked.append(theObj)
                                }
                            }
                        }
                    }
                    
                    //break loop because object was found
                    arSceneView.scene.rootNode.childNode(withName: obj.name!, recursively: false)!.removeFromParentNode()
                    isRemoved = true
                    break
                }
                
                //break loop because object was removed
                if isRemoved{
                    break
                }
            }

        }
        
        

    }
    
    //removing all objects from screen with a double tap
    @objc func removeAllObjectsOnScreen(withGestureRecognizer recog: UIGestureRecognizer){
        //double tap to remove all objects off screen
        for node in arSceneView.scene.rootNode.childNodes{
            //searching for objects that are named
            if node.name != nil {
                //removing obj
                node.removeFromParentNode()
            }
        }
        
    }
    
    //adding tap gestures
    func addTapGestureToSceneView() {
        
        //tap to add objects
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ARViewController.addObjectToScene(withGestureRecognizer:)))
        arSceneView.addGestureRecognizer(tapGestureRecognizer)
        
        //long press to select object
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ARViewController.selectObjectsOnScreen(withGestureRecognizer:)))
        longPressGestureRecognizer.minimumPressDuration = 1.0;
        arSceneView.addGestureRecognizer(longPressGestureRecognizer)
        
        //double tap to remove all objects
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(ARViewController.removeAllObjectsOnScreen(withGestureRecognizer:)))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
    }
    
    //segue from detailed view
    @IBAction func backToArView(unwindSegue: UIStoryboardSegue){
        
        
    }
    
    //text to speech
    func readObj(sceneObj: String){
        
        //setting string to say
        let speechUtterance = AVSpeechUtterance(string: sceneObj)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechUtterance.rate = 0.4
        //speechUtterance.pitchMultiplier = 0.25
        //speechUtterance.volume = 0.75
        
        //speeking
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(speechUtterance)
        
    }
    
    //Timer functionality
    @objc func onTimerFires(){
        timeLeft! -= 1.0
        
        //setting timer label
        let(h,m,s) = timeCon(seconds: Int(timeLeft!))
        timeLeftLabel.text = String(h) + ":" + String(m) + ":" + String(s)
    }
    
    //starting timer
    @IBAction func startTimer(){
        if timer == nil {
             timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        }
       
    }
    
    //pause timer
    @IBAction func pauseTimer(){
        if(timer != nil){
            timer?.invalidate()
            timer = nil
        }
        
    }
    
    //quit session with stop button press
    @IBAction func quitSession(){
        let quitAlert = UIAlertController(title: "Are you sure you want to quit?", message: "All session data will be lost.", preferredStyle: UIAlertController.Style.alert)
        
        quitAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            (action: UIAlertAction!) in self.saveDataAndExit()
            
        }))
        
        quitAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        
        present(quitAlert, animated: true, completion: nil)
    }
    
    //saving session and moving to welcome screen
    func saveDataAndExit(){
        let wlVC = WelcomeViewController()
        wlVC.savedSession = sessionInfo
        performSegue(withIdentifier: "unwindToWelcome", sender: self)
    }
    
    //managing data receved from new session page
    func manageSession(){
        titleOfSession.title = sessionInfo.name

        timeLeft = Double(sessionInfo.time)
        let(h,m,s) = timeCon(seconds: Int(timeLeft!))
        sessionInfo.hours = h
        sessionInfo.mins = m
        sessionInfo.secs = s
        sessionInfo.sessionNum = "0"
        timeLeftLabel.text = String(h) + ":" + String(m) + ":" + String(s)
    
        
        
    }
    
    //converting time in seconds to hours, mins, and secs
    func timeCon (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
}


/*
 * All below is for set up and operation of AR functionality
 *
 */

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

