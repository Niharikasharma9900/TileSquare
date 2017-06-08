
import UIKit
import EasyPeasy


protocol AddViewControllerDelegate {
    func valuePassed(value:String,width:Double,height:Double)
}

class AddViewController: UIViewController {
    
    var layertextbox = UITextField()
    var layerlabel = UILabel()
    var widthlabel = UILabel()
    var widthtextbox = UITextField()
    var heightlabel = UILabel()
    var heighttextbox = UITextField()
    var defaults = UserDefaults.standard
    let origin = ViewController()
    var delegate: AddViewControllerDelegate?
    var layerview = [UIView]()
    var indexPath:IndexPath!
    var savebutton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.title = "ADD"
        savebutton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savebuttonpressed))
        self.navigationItem.rightBarButtonItem = savebutton
        self.view.backgroundColor = UIColor.white
        layerlabel.text = "Layer Name"
        self.view.addSubview(layerlabel)
        self.layerlabel <- [Top(100), Width(200),Height(30), CenterX(-50)]
        
        self.view.addSubview(layertextbox)
        self.layertextbox <- [Top(100), Width(200),Height(30), CenterX(50)]
        layertextbox.layer.cornerRadius = 5
        layertextbox.layer.borderWidth = 1
        widthlabel.text = "Width"
        self.view.addSubview(widthlabel)
        widthlabel <- [Top(20).to(self.layerlabel),Width(200),Height(30), CenterX(-50)]
        self.view.addSubview(widthtextbox)
        widthtextbox.layer.borderWidth = 1
        widthtextbox <- [Top(20).to(self.layertextbox),Width(200),Height(30), CenterX(50)]
        widthtextbox.layer.cornerRadius = 5
        heightlabel.text = "Height"
        self.view.addSubview(heightlabel)
        heightlabel <- [Top(20).to(self.widthlabel),Width(200),Height(30), CenterX(-50)]
        self.view.addSubview(heighttextbox)
        heighttextbox.layer.borderWidth = 1
        heighttextbox <- [Top(20).to(self.widthtextbox),Width(200),Height(30), CenterX(50)]
        heighttextbox.layer.cornerRadius = 5
        self.layertextbox.text = "1"
        self.widthtextbox.text = "40"
        self.heighttextbox.text = "40"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func savebuttonpressed(){
        print("Button is clicked")
        let savebuttoncount = savebutton.accessibilityElementCount()
        for _ in 0 ..< savebuttoncount {
            layerview = [UIView(frame:(CGRect(x:0, y:0, width: 500, height: 500)))]
            layerview.append(UIView())
            print(layerview)
        }
        
        let connection = self.layertextbox.text
        defaults.set(connection, forKey: "text")
        guard let value = self.layertextbox.text, value.characters.count > 0,
            let width = self.widthtextbox.text,width.characters.count > 0,
            let height = self.heighttextbox.text,height.characters.count > 0
            else {
                return
        }
        delegate?.valuePassed(value: value,width: Double(width)!,height: Double(height)!)
        self.navigationController?.popViewController(animated: true)
    }
}
