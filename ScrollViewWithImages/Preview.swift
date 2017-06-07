

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
    var lastScale: CGFloat = 0.0 //  new paramter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let button1 = UIBarButtonItem(title: "Save To Photos", style: .plain, target: self, action: #selector(saveimage))
        self.navigationItem.rightBarButtonItem  = button1
       // screenView.backgroundColor = UIColor.white
        self.view.addSubview(scroll)
        scroll.frame = CGRect(x:0,y:0,width:UIScreen.main.bounds.width ,height:UIScreen.main.bounds.height )
        self.automaticallyAdjustsScrollViewInsets = false
       imageView = UIImageView(image: savedimage)
       imageView.center = self.view.center
       imageView.backgroundColor = UIColor.white
       scroll.backgroundColor = UIColor.white
        scroll.showsHorizontalScrollIndicator = true
        scroll.contentSize = CGSize(width:self.view.frame.size.height, height:self.view.frame.size.height + 100)
       scroll.addSubview(imageView)
       self.imageView.isUserInteractionEnabled = true
      self.view.addSubview(scroll)
       let pinchGesture: UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureFunc))
        
       // let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
        pinchGesture.delegate = self
        //panGesture.delegate = self
        self.imageView.addGestureRecognizer(pinchGesture)
      //  self.imageView.addGestureRecognizer(panGesture)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveimage(){
        savedimage = UIImage.imageWithView(view: imageView)
        UIImageWriteToSavedPhotosAlbum(savedimage!, nil, nil, nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
    func pinchGestureFunc(gestureRecognizer: UIPinchGestureRecognizer){
     
       if let view = gestureRecognizer.view as? UIImageView {
            view.transform = view.transform.scaledBy(x: gestureRecognizer.scale, y: gestureRecognizer.scale)
            if CGFloat(view.transform.a) > 4.0 {
                view.transform.a = 4.0 // this is x coordinate
                view.transform.d = 4.0 // this is x coordinate
            }
            if CGFloat(view.transform.d) < 0.95 {
                view.transform.a = 0.95 // this is x coordinate
                view.transform.d = 0.95 // this is x coordinate
            }
            gestureRecognizer.scale = 1
        }

     /*   if gestureRecognizer.state == .began {
            lastScale = gestureRecognizer.scale
        }
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let currentScale: CGFloat = (gestureRecognizer.view!.layer.value(forKeyPath: "transform.scale")! as! CGFloat)
            
            // Constants to adjust the max/min values of zoom
            //let kMaxScale: CGFloat = 2.0
            let kMinScale: CGFloat = 1.0
            
            var newScale: CGFloat = 1 - (lastScale - gestureRecognizer.scale)
            
            //newScale = min(newScale, kMaxScale / currentScale)
            newScale = max(newScale, kMinScale / currentScale)
            
            let transform = gestureRecognizer.view?.transform.scaledBy(x: newScale, y: newScale)
            gestureRecognizer.view?.transform = transform!
            
            lastScale = gestureRecognizer.scale
        }
        
    }
    
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: screenView)
        var recognizerFrame = recognizer.view?.frame
        recognizerFrame?.origin.x += translation.x
        recognizerFrame?.origin.y += translation.y
        // Check if UIImageView is completely inside its superView
        if screenView.bounds.contains(recognizerFrame!) {
            recognizer.view?.frame = recognizerFrame!
        }
        else {
            // Check vertically
            if (recognizerFrame?.origin.y)! < screenView.bounds.origin.y {
                recognizerFrame?.origin.y = 0
            }
            else if (recognizerFrame?.origin.y)! + (recognizerFrame?.size.height)! > screenView.bounds.size.height {
                recognizerFrame?.origin.y = screenView.bounds.size.height - (recognizerFrame?.size.height)!
            }
            
            // Check horizantally
            if (recognizerFrame?.origin.x)! < screenView.bounds.origin.x {
                recognizerFrame?.origin.x = 0
            }
            else if (recognizerFrame?.origin.x)! + (recognizerFrame?.size.width)! > screenView.bounds.size.width {
                recognizerFrame?.origin.x = screenView.bounds.size.width - (recognizerFrame?.size.width)!
            }
        }
 
        // Reset translation so that on next pan recognition
        // we get correct translation value
        recognizer.setTranslation(CGPoint(x: CGFloat(0), y: CGFloat(0)), in: screenView)*/
    }
/*    fileprivate func updateMinZoomScaleForSize(_ size: CGSize) {
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
    
   fileprivate func updateConstraintsForSize(_ size: CGSize) {
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
    } */
    
}
 

