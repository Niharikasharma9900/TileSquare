

import UIKit

class Preview: UIViewController,UIGestureRecognizerDelegate {
    
    var screenView: UIView!
    var scroll  = UIScrollView()
    var savedimage : UIImage!
    var bgImage: UIImageView?
    var imageViewBottomConstraint: NSLayoutConstraint!
    var imageViewLeadingConstraint: NSLayoutConstraint!
    var imageViewTopConstraint: NSLayoutConstraint!
    var imageViewTrailingConstraint: NSLayoutConstraint!
    var imageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let button1 = UIBarButtonItem(title: "Save To Photos", style: .plain, target: self, action: #selector(saveimage))
        self.navigationItem.rightBarButtonItem  = button1
       // screenView.backgroundColor = UIColor.white
        self.view.addSubview(scroll)
        scroll.frame = CGRect(x:0,y:0,width:UIScreen.main.bounds.width ,height:UIScreen.main.bounds.height )
       imageView = UIImageView(image: savedimage)
     //  screenView.frame = CGRect(x:0,y:0,width: self.view.frame.size.width, height: self.view.frame.size.height)
       imageView.center = self.view.center
       imageView.backgroundColor = UIColor.white
       scroll.backgroundColor = UIColor.blue
        scroll.showsHorizontalScrollIndicator = true
        scroll.contentSize = CGSize(width:self.view.frame.size.height, height:self.view.frame.size.height)
       scroll.addSubview(imageView)
       
      self.view.addSubview(scroll)
      let pinchGesture: UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureFunc))
        self.imageView.isUserInteractionEnabled = true
        pinchGesture.delegate = self
        self.imageView.addGestureRecognizer(pinchGesture)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveimage(){
        savedimage = UIImage.imageWithView(view: screenView)
        UIImageWriteToSavedPhotosAlbum(savedimage!, nil, nil, nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
    func pinchGestureFunc(gestureRecognizer: UIPinchGestureRecognizer){
      /*  gestureRecognizer.view!.transform = gestureRecognizer.view!.transform.scaledBy(x: gestureRecognizer.scale, y: gestureRecognizer.scale)
        gestureRecognizer.scale = 1
       view.layoutIfNeeded() */
        if let view = gestureRecognizer.view as? UIImageView {
            view.transform = view.transform.scaledBy(x: gestureRecognizer.scale, y: gestureRecognizer.scale)
            if CGFloat(view.transform.a) > 3.0 {
                view.transform.a = 3.0 // this is x coordinate
                view.transform.d = 3.0 // this is x coordinate
            }
            if CGFloat(view.transform.d) < 0.95 {
                view.transform.a = 0.95 // this is x coordinate
                view.transform.d = 0.95 // this is x coordinate
            }
            gestureRecognizer.scale = 1
        }
        
        
    }
  /*  fileprivate func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)
        // 2
        scroll.minimumZoomScale = minScale
        // 3
        scroll.zoomScale = minScale
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 4
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
 /*   fileprivate func updateConstraintsForSize(_ size: CGSize) {
        // 2
        let yOffset = max(0, (size.height - imageView.frame.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        // 3
        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        
        view.layoutIfNeeded()
    }
}
extension Preview: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        // 1
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)  // 4
    } */ */
    
}
 

