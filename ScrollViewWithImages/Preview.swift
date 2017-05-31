

import UIKit

class Preview: UIViewController {
        
    var screenView = UIView()
    var savedimage : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = UIColor.white
        let button1 = UIBarButtonItem(title: "Save To Photos", style: .plain, target: self, action: #selector(saveimage))
        self.navigationItem.rightBarButtonItem  = button1
        screenView.backgroundColor = UIColor.white
        screenView.frame = CGRect(x:0,y:100,width:self.view.frame.width,height:UIScreen.main.bounds.height)
        self.view.addSubview(screenView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveimage(){
     // let create = ViewController()
    savedimage = UIImage.imageWithView(view: screenView)
    UIImageWriteToSavedPhotosAlbum(savedimage!, nil, nil, nil)
        self.navigationController?.popToRootViewController(animated: true)
    }

   
}
