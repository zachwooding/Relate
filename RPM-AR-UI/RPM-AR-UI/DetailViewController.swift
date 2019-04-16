import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var iconInfo: UILabel!
    @IBOutlet weak var objsImageView: UIImageView!
    
    
    var objSelected: String!
    
    
    var detailObjs: Objs! {
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        if let detailObjs = detailObjs {
            if let detailDescriptionLabel = detailDescriptionLabel, let iconInfoView = iconInfo {
                detailDescriptionLabel.text = detailObjs.name
                iconInfoView.text = detailObjs.icon
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
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ARViewController{
            let arVC = segue.destination as? ARViewController
            arVC?.objSelected = detailObjs
        }
    }
    
    
    
}


