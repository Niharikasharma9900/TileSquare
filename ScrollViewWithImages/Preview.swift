

import UIKit

class Preview: UIViewController,UIGestureRecognizerDelegate,UIScrollViewDelegate {
    
    var screenView: UIView!
    var scroll  = UIScrollView()
    var savedimage : UIImage!
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
        self.scroll.backgroundColor = UIColor.white
        scroll.frame = CGRect(x:0,y:0,width:UIScreen.main.bounds.width ,height:UIScreen.main.bounds.height )
        self.automaticallyAdjustsScrollViewInsets = false
        imageView = UIImageView(image: savedimage)
        imageView.contentMode = .scaleAspectFit
        imageView.center = self.view.center
        imageView.backgroundColor = UIColor.white
        scroll.addSubview(imageView)
        //scroll.contentSize = CGSize(width: 1000 , height: 1000)
      //  scroll.contentSize = CGSize(width: self.savedimage.size.width, height: 1600)
        scroll.contentSize = self.scroll.frame.size
        scroll.delegate = self
        scroll.isUserInteractionEnabled = true
        scroll.contentInset = UIEdgeInsets.zero
        scroll.scrollIndicatorInsets = UIEdgeInsets.zero;
        
        self.imageView.isUserInteractionEnabled = true
        self.view.addSubview(scroll)
        let pinchGesture: UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureFunc))
        
        // let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
        pinchGesture.delegate = self
        //panGesture.delegate = self
        self.scroll.addGestureRecognizer(pinchGesture)
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
        
       /* if let view = gestureRecognizer.view  {
            view.transform = view.transform.scaledBy(x: gestureRecognizer.scale, y: gestureRecognizer.scale)
            if CGFloat(view.transform.a) > 4.5 {
                view.transform.a = 4.5 // this is x coordinate
                view.transform.d = 4.5 // this is x coordinate
            }
            if CGFloat(view.transform.d) < 0.95 {
                view.transform.a = 0.95 // this is x coordinate
                view.transform.d = 0.95 // this is x coordinate
            }
            gestureRecognizer.scale = 1
            scroll.zoomScale =
        } */
        let widthScale = self.view.frame.size.width / imageView.bounds.width
        let heightScale = self.view.frame.size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)
        // 2
        scroll.minimumZoomScale = minScale
        scroll.maximumZoomScale = 3.5

        // 3
        scroll.zoomScale = minScale
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
