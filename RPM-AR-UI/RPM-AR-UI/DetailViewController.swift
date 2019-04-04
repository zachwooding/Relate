import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var objsImageView: UIImageView!
    
    var detailObjs: Objs? {
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
    
}


