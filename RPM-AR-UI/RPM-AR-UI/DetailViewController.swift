import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var objsImageView: UIImageView!
    
    
    var objSelected: String!
    
    
    var detailObjs: Objs! {
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        if let detailObjs = detailObjs {
            if let detailDescriptionLabel = detailDescriptionLabel, let objsImageView = objsImageView {
                detailDescriptionLabel.text = detailObjs.name
                objsImageView.image = UIImage(named: detailObjs.name)
                title = detailObjs.category
                objSelected = detailObjs.sceneName
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func setObj(){
        objSelected = detailObjs.sceneName
    }

    func getObj() -> String{
        if (objSelected == nil){
            return "nothing selected"
        }else{
            return objSelected
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "passObj" {
                
            let controller = (segue.destination as! UINavigationController).topViewController as! ARViewController
            controller.objSelected = detailObjs
        }
    }
    
    
    
}


