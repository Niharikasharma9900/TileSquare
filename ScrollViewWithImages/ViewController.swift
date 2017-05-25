

import Foundation
import UIKit
import EasyPeasy
import Darwin

struct ViewControllerConstant{
    static let collectionView = ElementsCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
    static let buttonImages = [[#imageLiteral(resourceName: "tile4"), #imageLiteral(resourceName: "house"), #imageLiteral(resourceName: "cake"), #imageLiteral(resourceName: "line"), #imageLiteral(resourceName: "apple")],[#imageLiteral(resourceName: "face1"), #imageLiteral(resourceName: "hair1"), #imageLiteral(resourceName: "f3"), #imageLiteral(resourceName: "f4"), #imageLiteral(resourceName: "f5")], [#imageLiteral(resourceName: "dog"), #imageLiteral(resourceName: "bird"), #imageLiteral(resourceName: "bug"), #imageLiteral(resourceName: "cat"), #imageLiteral(resourceName: "twitter")], [#imageLiteral(resourceName: "red"), #imageLiteral(resourceName: "green"), #imageLiteral(resourceName: "box"), #imageLiteral(resourceName: "bullet"), #imageLiteral(resourceName: "flower")]]
    static let gridArray = [[#imageLiteral(resourceName: "tile1-1"),#imageLiteral(resourceName: "tile1-2"),#imageLiteral(resourceName: "tile1-3"),#imageLiteral(resourceName: "tile1-4")],[#imageLiteral(resourceName: "tile2-1"),#imageLiteral(resourceName: "tile2-2"),#imageLiteral(resourceName: "tile2-3"),#imageLiteral(resourceName: "tile2-4")],[#imageLiteral(resourceName: "tile3-1"),#imageLiteral(resourceName: "tile3-2"),#imageLiteral(resourceName: "tile3-3"),#imageLiteral(resourceName: "tile3-4")],[#imageLiteral(resourceName: "tile4-1"),#imageLiteral(resourceName: "tile4-2"),#imageLiteral(resourceName: "tile4-3"),#imageLiteral(resourceName: "tile4-4")]]
    static let maleView = MaleView(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2))
    static let femaleView = MaleView(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2))
    static let petView = MaleView(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2))
}

class ViewController: UIViewController, UIToolbarDelegate,UITableViewDataSource,UITableViewDelegate,AddViewControllerDelegate {
    
    private var toolbar: UIToolbar!
    private var tableView = UITableView()
    private var rowForImage = 20
    private var columnForImage = 20
    private var middleButtonNumber = 5
    private var middleButtonWidth = 100
    private var middlebutton = UIButton()
    var highlightedButtons = [UIButton]()
    private var secondScroll = UIScrollView()
    var currentView: UIView?
    var scroll: UIScrollView = UIScrollView(frame: CGRect(x:0, y:0, width: (UIScreen.main.bounds.width)*3/4 , height: (UIScreen.main.bounds.height)*4/5))
    var ourText = String()
    var textArray:[String] = [String]()
    var defaults = UserDefaults.standard
    var imageView: UIImageView! = UIImageView(frame: CGRect(x:0, y:100, width: (UIScreen.main.bounds.width)*3/4 , height: (UIScreen.main.bounds.height)*4/5))
    var myUIBarButtonGreen: UIBarButtonItem!
    var myUIBarButtonBlue : UIBarButtonItem!
    var myUIBarButtonRed: UIBarButtonItem!
    var myUIBarButtonArrow: UIBarButtonItem!
    var myUIBarButtonA: UIBarButtonItem!
    var preview : UIBarButtonItem!
    let addbutton = UIButton()
    var dictionaryOfImages = [UIImage:Array<CollectionViewImage>]()
    var flag = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        dictionaryValues()
        toolbarfunc()
        self.view.addSubview(toolbar)
        addbutton.frame = CGRect(x: self.scroll.frame.size.width, y:100, width:self.view.frame.size.width - self.scroll.frame.size.width, height:50)
        addbutton.setTitle("ADD", for: .normal)
        addbutton.titleLabel?.textColor = UIColor.black
        addbutton.backgroundColor = UIColor.black
        addbutton.addTarget(self, action: #selector(edit), for: UIControlEvents.touchUpInside)
        self.view.addSubview(addbutton)
        tableView = UITableView(frame: CGRect(x: self.scroll.frame.size.width, y:150, width:self.view.frame.size.width - self.scroll.frame.size.width, height:self.view.frame.size.height), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        self.view.addSubview(secondScroll)
        secondScroll.translatesAutoresizingMaskIntoConstraints = false
        secondScroll.backgroundColor = UIColor.white
        secondScroll <- [Top().to(self.view, .centerY), Left(100), Right(), Height(60), Width(UIScreen.main.bounds.width)]
        self.view.addSubview(middlebutton)
        middlebutton <- [Top().to(self.view, .centerY), Left(), Width(100), Height(60)]
        middlebutton.setImage(#imageLiteral(resourceName: "arrow-down"), for: .normal)
        middlebutton.addTarget(self, action: #selector(viewchange(sender:)), for: .touchUpInside)
        middlebutton.backgroundColor = UIColor.white
        self.view.addSubview(ViewControllerConstant.collectionView)
        ViewControllerConstant.collectionView.controller = self
        ViewControllerConstant.collectionView <- [Top().to(secondScroll, .bottom), Left(), Right(), Bottom()]
        
        var con2 = [NSLayoutConstraint]()
        var previousView2 : UIButton? = nil
        for i in 1...middleButtonNumber{
            let button = UIButton()
            button.tag = i
            button.setImage(ViewControllerConstant.buttonImages[0][i-1], for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.clipsToBounds = true
            button.backgroundColor = .white
            button.addTarget(self, action: #selector(sectionButton(sender:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            secondScroll.addSubview(button)
            con2.append(contentsOf:
                NSLayoutConstraint.constraints(withVisualFormat:
                    "V:|[button(60)]|",
                                               metrics:nil,
                                               views:["button":button]))
            
            if previousView2 == nil { // first one, pin to top
                con2.append(contentsOf:
                    NSLayoutConstraint.constraints(withVisualFormat:
                        "H:|[button(middleButtonWidth)]",
                                                   metrics:["middleButtonWidth":middleButtonWidth],
                                                   views:["button":button]))
            } else { // all others, pin to previous
                con2.append(contentsOf:
                    NSLayoutConstraint.constraints(withVisualFormat:
                        "H:[prev][button(middleButtonWidth)]",
                                                   metrics:["middleButtonWidth": middleButtonWidth],
                                                   views:["button":button, "prev":previousView2!]))
            }
            previousView2 = button
        }
        con2.append(contentsOf:
            NSLayoutConstraint.constraints(withVisualFormat:
                "H:[button]|",
                                           metrics:nil,
                                           views:["button":previousView2!]))
        
        NSLayoutConstraint.activate(con2)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    
    func dictionaryValues(){
        let tileImages = [CollectionViewImage(imageName:"tile1-1"),CollectionViewImage(imageName:"tile1-2"),CollectionViewImage(imageName:"tile1-3"),CollectionViewImage(imageName:"tile1-4")]
        let tileImages2 = [CollectionViewImage(imageName:"tile2-1"),CollectionViewImage(imageName:"tile2-3"),CollectionViewImage(imageName:"tile2-2"),CollectionViewImage(imageName:"tile2-4")]
        let tileImages3 = [CollectionViewImage(imageName:"tile3-1"),CollectionViewImage(imageName:"tile3-2"),CollectionViewImage(imageName:"tile3-3"),CollectionViewImage(imageName:"tile3-4")]
        let tileImages4 = [CollectionViewImage(imageName:"tile4-1"),CollectionViewImage(imageName:"tile4-2"),CollectionViewImage(imageName:"tile4-3"),CollectionViewImage(imageName:"tile4-4")]
        let tileImages5 =  [CollectionViewImage(imageName:"tile5-1"),CollectionViewImage(imageName:"tile5-2"),CollectionViewImage(imageName:"tile5-3"),CollectionViewImage(imageName:"tile5-4")]
        dictionaryOfImages = [#imageLiteral(resourceName: "tileimage1"): tileImages,#imageLiteral(resourceName: "tile2"): tileImages2, #imageLiteral(resourceName: "tile3"): tileImages3,#imageLiteral(resourceName: "tile4"):tileImages4,#imageLiteral(resourceName: "tile5"): tileImages5]
        
    }
    
    func toolbarfunc(){
        let mySegmentedControl = UISegmentedControl(items: ["Map", "Male", "Female", "Pet"])
        mySegmentedControl.frame = CGRect(x:0, y:0, width:300, height: 25)
        self.navigationItem.titleView = mySegmentedControl
        mySegmentedControl.tintColor = UIColor.red
        mySegmentedControl.selectedSegmentIndex = 0
        mySegmentedControl.addTarget(self, action: #selector(segmentedControl(sender:)), for: .valueChanged)
        toolbar = UIToolbar(frame: CGRect(x:0, y:70,width: self.view.bounds.size.width, height:50.0))
        toolbar.layer.position = CGPoint(x: self.view.bounds.width/2, y: 80)
        toolbar.barStyle = .blackTranslucent
        toolbar.tintColor = UIColor.white
        toolbar.backgroundColor = UIColor.black
        myUIBarButtonGreen = UIBarButtonItem(title: "Green", style:.plain, target: self, action: #selector(onClickBarButton))
        myUIBarButtonGreen.tag = 1
        myUIBarButtonBlue = UIBarButtonItem(title: "Blue", style:.plain, target: self, action: #selector(onClickBarButton))
        myUIBarButtonBlue.tag = 2
        myUIBarButtonRed = UIBarButtonItem(title: "Eraser",style: .plain,target: self, action: #selector(onClickBarButton))
        myUIBarButtonRed.tag = 3
        preview = UIBarButtonItem(title:"Preview",style: .plain, target: self,action: #selector(onClickBarButton))
        preview.tag = 4
        myUIBarButtonArrow = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: #selector(onClickBarButton))
        myUIBarButtonArrow.tag = 5
        myUIBarButtonA = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fastForward, target: self, action: #selector(onClickBarButton))
        myUIBarButtonA.tag = 5
        toolbar.items = [myUIBarButtonGreen, myUIBarButtonBlue, myUIBarButtonRed,preview,myUIBarButtonArrow,myUIBarButtonA]
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Table View Methods
    //MARK:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let uiViewPresent = self.scroll.viewWithTag(indexPath.row + 1) {
            print("tag is---",uiViewPresent.tag)
            self.scroll.bringSubview(toFront: uiViewPresent)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  textArray.count
    }
    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "myIdentifier",frame: tableView.frame.size)
        cell.myLabel1.text = textArray[indexPath.row]
        
        return cell
    }
    
    //MARK: Custom Methods
    //MARK:
    internal func onClickBarButton(sender: UIBarButtonItem) {
        switch sender.tag {
        case 1:
            self.view.backgroundColor = UIColor.green
        case 2:
            self.view.backgroundColor = UIColor.blue
        case 3:
            if(!flag) {
                sender.title = "Eraser On"
                flag = true
            }
            else {
                sender.title = "Eraser"
                flag = false
            }
        case 4:
            let createTableView = Preview()
            createTableView.screenView = getSnapShot(view: currentView)!
            self.navigationController?.pushViewController(createTableView, animated: true)
            
        case 5:
            let button1 = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(onBackBarButton))
            toolbar.items = [ myUIBarButtonGreen, myUIBarButtonBlue, myUIBarButtonRed,myUIBarButtonArrow,button1]
            self.view.addSubview(toolbar)
            scroll.frame = CGRect(x:0,y:100,width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height*3/4)
            self.view.addSubview(scroll)
            tableView.removeFromSuperview()
            addbutton.removeFromSuperview()
            self.view.addSubview(secondScroll)
            secondScroll.translatesAutoresizingMaskIntoConstraints = false
            secondScroll.backgroundColor = UIColor.white
            secondScroll <- [Top().to(self.view, .centerY), Left(100), Right(), Height(60), Width(UIScreen.main.bounds.width)]
            self.view.addSubview(middlebutton)
            middlebutton <- [Top().to(self.view, .centerY),Left(0), Height(60), Width(100)]
            middlebutton.setImage(#imageLiteral(resourceName: "arrow-down"), for: .normal)
            middlebutton.addTarget(self, action: #selector(viewchange(sender:)), for: .touchUpInside)
            middlebutton.backgroundColor = UIColor.white
            self.view.addSubview(ViewControllerConstant.collectionView)
            ViewControllerConstant.collectionView.controller = self
            ViewControllerConstant.collectionView <- [Top().to(secondScroll, .bottom), Left(), Right(), Bottom()]
        default:
            print("ERROR!!")
        }
    }
    
    func getSnapShot(view: UIView?) -> UIView? {
        
        for i in 0..<rowForImage {
            for j in 0..<columnForImage {
                let button = view?.viewWithTag(i + 10*j) as? UIButton
                if button?.imageView?.image == #imageLiteral(resourceName: "square") {
                    button?.setImage(nil, for: .normal)
                }
            }
        }
        return view
    }
    
    func onBackBarButton(){
        toolbar = UIToolbar(frame: CGRect(x:0, y:70,width: self.view.bounds.size.width, height:50.0))
        toolbar.layer.position = CGPoint(x: self.view.bounds.width/2, y: 80)
        toolbar.barStyle = .blackTranslucent
        toolbar.tintColor = UIColor.white
        toolbar.backgroundColor = UIColor.black
        toolbar.items = [myUIBarButtonGreen, myUIBarButtonBlue, myUIBarButtonRed,myUIBarButtonArrow,myUIBarButtonA]
        self.view.addSubview(toolbar)
        self.view.addSubview(scroll)
        scroll.frame = CGRect(x:0,y:100,width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height*3/4)
        self.view.addSubview(tableView)
        self.view.addSubview(addbutton)
        self.view.addSubview(secondScroll)
        secondScroll.translatesAutoresizingMaskIntoConstraints = false
        secondScroll.backgroundColor = UIColor.white
        secondScroll <- [Top().to(self.view, .centerY), Left(100), Right(), Height(60), Width(UIScreen.main.bounds.width)]
        self.view.addSubview(middlebutton)
        middlebutton <- [Top().to(self.view, .centerY),Left(0), Height(60), Width(100)]
        middlebutton.setImage(#imageLiteral(resourceName: "arrow-down"), for: .normal)
        middlebutton.addTarget(self, action: #selector(viewchange(sender:)), for: .touchUpInside)
        middlebutton.backgroundColor = UIColor.white
        self.view.addSubview(ViewControllerConstant.collectionView)
        ViewControllerConstant.collectionView.controller = self
        ViewControllerConstant.collectionView <- [Top().to(secondScroll, .bottom), Left(), Right(), Bottom()]
    }
    func edit(){
        let createTableView = AddViewController()
        createTableView.delegate = self
        self.navigationController?.pushViewController(createTableView, animated: true)
    }
    func viewchange(sender: UIButton){
        scroll.frame = CGRect(x:0, y:100, width: (UIScreen.main.bounds.width)*3/4 , height: (UIScreen.main.bounds.height)*4/5)
        self.view.addSubview(scroll)
        self.view.addSubview(middlebutton)
        middlebutton <- [ Top(600).to(self.view),Left(0), Height(60), Width(100)]
        middlebutton.setImage(#imageLiteral(resourceName: "up"), for: .normal)
        middlebutton.addTarget(self, action: #selector(reverse(sender:)), for: .touchUpInside)
        self.view.addSubview(secondScroll)
        secondScroll.translatesAutoresizingMaskIntoConstraints = false
        secondScroll.backgroundColor = UIColor.white
        secondScroll <- [Top(600),Left(100), Height(60), Width(UIScreen.main.bounds.width)]
        self.view.addSubview(ViewControllerConstant.collectionView)
        ViewControllerConstant.collectionView.controller = self
        ViewControllerConstant.collectionView <- [Top().to(secondScroll, .bottom), Left(), Right(), Bottom()]
    }
    func reverse(sender: UIButton){
        
        self.view.addSubview(secondScroll)
        secondScroll.translatesAutoresizingMaskIntoConstraints = false
        secondScroll.backgroundColor = UIColor.white
        secondScroll <- [Top().to(self.view, .centerY), Left(100), Right(), Height(60), Width(UIScreen.main.bounds.width)]
        self.view.addSubview(middlebutton)
        middlebutton <- [Top().to(self.view, .centerY), Left(), Width(100), Height(60)]
        middlebutton.setImage(#imageLiteral(resourceName: "arrow-down"), for: .normal)
        middlebutton.addTarget(self, action: #selector(viewchange(sender:)), for: .touchUpInside)
        middlebutton.backgroundColor = UIColor.white
    }
    
    func switchButtonImage(sender: UIButton){
        if ViewControllerConstant.collectionView.selectedButton == nil{
            if sender.backgroundColor != .darkGray{
                sender.backgroundColor = .darkGray
                highlightedButtons.append(sender)
            }
            else {
                sender.backgroundColor = .white
                highlightedButtons.remove(at: highlightedButtons.index(of: sender)!)
            }
        } else if flag {
            let uiView = self.scroll.viewWithTag(textArray.count)
            let gridMatrixValue = Int(sqrt(Double(ViewControllerConstant.gridArray.count)))
            let tag = sender.tag
            var startIndexI = tag/10
            // var count = 0
            for _ in 0..<gridMatrixValue {
                var startIndexJ = tag%10
                for _ in 0..<gridMatrixValue {
                    
                    let button = uiView?.viewWithTag(startIndexJ+(10*startIndexI)) as? UIButton
                    startIndexJ += 1
                    button?.setImage(#imageLiteral(resourceName: "square"), for: .normal)
                    
                }
                startIndexI += 1
            }
            
        }
        else {
            
            let uiView = self.scroll.viewWithTag(textArray.count)
            let gridMatrixValue = Int(sqrt(Double(ViewControllerConstant.gridArray.count)))
            let tag = sender.tag
            var startIndexI = tag/10
            var count = 0
            for _ in 0..<gridMatrixValue {
                var startIndexJ = tag%10
                for _ in 0..<gridMatrixValue {
                    
                    let uiImageGrid = ViewControllerConstant.collectionView.arrayOfGridImages[count]
                    let button = uiView?.viewWithTag(startIndexJ+(10*startIndexI)) as? UIButton
                    count += 1
                    startIndexJ += 1
                    button?.setImage(UIImage(named:uiImageGrid.imageName), for: .normal)
                    
                }
                startIndexI += 1
            }
        }
        if ViewControllerConstant.collectionView.selectedButton == self{
            highlightedButtons.removeAll()
            
        }
    }
    
    
    func sectionButton(sender: UIButton){
        ViewControllerConstant.collectionView.selectedButton = nil
        if sender.tag == 1{
            ViewControllerConstant.collectionView.images = [#imageLiteral(resourceName: "tileimage1"), #imageLiteral(resourceName: "tile2"), #imageLiteral(resourceName: "tile3"), #imageLiteral(resourceName: "tile4"), #imageLiteral(resourceName: "tile5")]
        }
        else if sender.tag == 2 {
            ViewControllerConstant.collectionView.images = [#imageLiteral(resourceName: "house"), #imageLiteral(resourceName: "Building"), #imageLiteral(resourceName: "small_school"), #imageLiteral(resourceName: "supermarket"), #imageLiteral(resourceName: "Hospital")]
        }
        else if sender.tag == 3 {
            ViewControllerConstant.collectionView.images = [#imageLiteral(resourceName: "cake"), #imageLiteral(resourceName: "cake"), #imageLiteral(resourceName: "cake"), #imageLiteral(resourceName: "cake"), #imageLiteral(resourceName: "cake")]
        }
        else if sender.tag == 4 {
            ViewControllerConstant.collectionView.images = [#imageLiteral(resourceName: "line"), #imageLiteral(resourceName: "line"), #imageLiteral(resourceName: "line"), #imageLiteral(resourceName: "line"), #imageLiteral(resourceName: "line")]
        }
        else if sender.tag == 5 {
            ViewControllerConstant.collectionView.images = [#imageLiteral(resourceName: "apple"), #imageLiteral(resourceName: "apple"), #imageLiteral(resourceName: "apple"), #imageLiteral(resourceName: "apple"), #imageLiteral(resourceName: "apple")]
        }
        else if sender.tag == 6{
            ViewControllerConstant.collectionView.needToChangeImageView = ViewControllerConstant.maleView.topImageView
            ViewControllerConstant.collectionView.images = [#imageLiteral(resourceName: "face1"),#imageLiteral(resourceName: "face2"),#imageLiteral(resourceName: "face3"), #imageLiteral(resourceName: "face4"),#imageLiteral(resourceName: "face5"),#imageLiteral(resourceName: "face6"),#imageLiteral(resourceName: "face7"),#imageLiteral(resourceName: "face8")]
        }
        else if sender.tag == 7{
            ViewControllerConstant.collectionView.needToChangeImageView = ViewControllerConstant.maleView.leftImageView
            ViewControllerConstant.collectionView.images = [#imageLiteral(resourceName: "hair1"),#imageLiteral(resourceName: "hair2"),#imageLiteral(resourceName: "hair3"),#imageLiteral(resourceName: "hair4"),#imageLiteral(resourceName: "hair5"),#imageLiteral(resourceName: "hair6"),#imageLiteral(resourceName: "hair7"),#imageLiteral(resourceName: "hair8")]
        }
        else if sender.tag == 8{
            ViewControllerConstant.collectionView.needToChangeImageView = ViewControllerConstant.maleView.rightImageView
            ViewControllerConstant.collectionView.images = [#imageLiteral(resourceName: "f3"),#imageLiteral(resourceName: "f5"),#imageLiteral(resourceName: "f4"),#imageLiteral(resourceName: "f3"),#imageLiteral(resourceName: "f1")]
        }
        else if sender.tag == 9{
            ViewControllerConstant.collectionView.needToChangeImageView = ViewControllerConstant.maleView.bottomImageView
            ViewControllerConstant.collectionView.images = [#imageLiteral(resourceName: "f2"),#imageLiteral(resourceName: "f4"),#imageLiteral(resourceName: "f3"),#imageLiteral(resourceName: "f4"),#imageLiteral(resourceName: "f1")]
        }
        else if sender.tag == 10{
            ViewControllerConstant.collectionView.needToChangeImageView = ViewControllerConstant.maleView.furtherLeft
            ViewControllerConstant.collectionView.images = [#imageLiteral(resourceName: "f1"),#imageLiteral(resourceName: "f4"),#imageLiteral(resourceName: "f2"),#imageLiteral(resourceName: "f5"),#imageLiteral(resourceName: "f3")]
        }else if sender.tag == 11{
            ViewControllerConstant.collectionView.needToChangeImageView = ViewControllerConstant.femaleView.topImageView
            ViewControllerConstant.collectionView.images = [#imageLiteral(resourceName: "cat"), #imageLiteral(resourceName: "dog"), #imageLiteral(resourceName: "twitter"), #imageLiteral(resourceName: "bird"), #imageLiteral(resourceName: "bug")]
        }
        else if sender.tag == 12 {
            ViewControllerConstant.collectionView.needToChangeImageView = ViewControllerConstant.femaleView.leftImageView
            ViewControllerConstant.collectionView.images = [#imageLiteral(resourceName: "dog"), #imageLiteral(resourceName: "cat"), #imageLiteral(resourceName: "bird"), #imageLiteral(resourceName: "bug"), #imageLiteral(resourceName: "twitter")]
        }
        else if sender.tag == 13 {
            ViewControllerConstant.collectionView.needToChangeImageView = ViewControllerConstant.maleView.rightImageView
            ViewControllerConstant.collectionView.images = [#imageLiteral(resourceName: "twitter"), #imageLiteral(resourceName: "dog"), #imageLiteral(resourceName: "bug"), #imageLiteral(resourceName: "bird"), #imageLiteral(resourceName: "cat")]
        }
        else if sender.tag == 14 {
            ViewControllerConstant.collectionView.needToChangeImageView = ViewControllerConstant.maleView.bottomImageView
            ViewControllerConstant.collectionView.images = [#imageLiteral(resourceName: "bird"), #imageLiteral(resourceName: "twitter"), #imageLiteral(resourceName: "dog"), #imageLiteral(resourceName: "cat"), #imageLiteral(resourceName: "bug")]
        }
        else if sender.tag == 15 {
            ViewControllerConstant.collectionView.needToChangeImageView = ViewControllerConstant.maleView.furtherLeft
            ViewControllerConstant.collectionView.images = [#imageLiteral(resourceName: "cat"), #imageLiteral(resourceName: "bird"), #imageLiteral(resourceName: "bug"), #imageLiteral(resourceName: "twitter"), #imageLiteral(resourceName: "dog")]
        }
        else if sender.tag == 16{
            ViewControllerConstant.collectionView.needToChangeImageView = ViewControllerConstant.maleView.topImageView
            ViewControllerConstant.collectionView.images = [#imageLiteral(resourceName: "red"),#imageLiteral(resourceName: "green"), #imageLiteral(resourceName: "box"), #imageLiteral(resourceName: "bullet"), #imageLiteral(resourceName: "flower") ]
        }
        else if sender.tag == 17{
            ViewControllerConstant.collectionView.needToChangeImageView = ViewControllerConstant.maleView.leftImageView
            ViewControllerConstant.collectionView.images = [#imageLiteral(resourceName: "flower"),#imageLiteral(resourceName: "red"),#imageLiteral(resourceName: "green"),#imageLiteral(resourceName: "box"),#imageLiteral(resourceName: "bullet")]
        }
        else if sender.tag == 18{
            ViewControllerConstant.collectionView.needToChangeImageView = ViewControllerConstant.maleView.rightImageView
            ViewControllerConstant.collectionView.images = [#imageLiteral(resourceName: "bullet"),#imageLiteral(resourceName: "flower"),#imageLiteral(resourceName: "red"),#imageLiteral(resourceName: "green"),#imageLiteral(resourceName: "box")]
        }
        else if sender.tag == 19{
            ViewControllerConstant.collectionView.needToChangeImageView = ViewControllerConstant.maleView.bottomImageView
            ViewControllerConstant.collectionView.images = [#imageLiteral(resourceName: "box"),#imageLiteral(resourceName: "bullet"),#imageLiteral(resourceName: "flower"),#imageLiteral(resourceName: "red"),#imageLiteral(resourceName: "green")]
        }
        else if sender.tag == 20{
            ViewControllerConstant.collectionView.needToChangeImageView = ViewControllerConstant.maleView.furtherLeft
            ViewControllerConstant.collectionView.images = [#imageLiteral(resourceName: "green"),#imageLiteral(resourceName: "box"),#imageLiteral(resourceName: "bullet"),#imageLiteral(resourceName: "flower"),#imageLiteral(resourceName: "red")]
        }
        
        ViewControllerConstant.collectionView.reloadData()
    }
    
    func segmentedControl(sender: UISegmentedControl){
        secondScroll.contentOffset = CGPoint.zero
        switch sender.selectedSegmentIndex {
        case 0:
            ViewControllerConstant.maleView.removeFromSuperview()
            ViewControllerConstant.maleView.removeFromSuperview()
            ViewControllerConstant.maleView.removeFromSuperview()
            toolbar = UIToolbar(frame: CGRect(x:0, y:70,width: self.view.bounds.size.width, height:50.0))
            toolbar.layer.position = CGPoint(x: self.view.bounds.width/2, y: 80)
            toolbar.barStyle = .blackTranslucent
            toolbar.tintColor = UIColor.white
            toolbar.backgroundColor = UIColor.black
            // add the buttons on the toolbar
            toolbar.items = [myUIBarButtonGreen, myUIBarButtonBlue, myUIBarButtonRed,myUIBarButtonArrow,myUIBarButtonA]
            self.view.addSubview(scroll)
            self.view.addSubview(toolbar)
            self.view.addSubview(addbutton)
            tableView = UITableView(frame: CGRect(x: self.scroll.frame.size.width, y:140, width:self.view.frame.size.width - self.scroll.frame.size.width, height:self.view.frame.size.height), style: .plain);
            tableView.delegate = self
            tableView.dataSource = self
            tableView.backgroundColor = UIColor.white
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            self.view.addSubview(tableView)
            self.view.addSubview(secondScroll)
            secondScroll.translatesAutoresizingMaskIntoConstraints = false
            secondScroll.backgroundColor = UIColor.white
            secondScroll <- [Top().to(self.view, .centerY), Left(100), Right(), Height(60), Width(UIScreen.main.bounds.width)]
            self.view.addSubview(middlebutton)
            middlebutton <- [Top().to(self.view, .centerY),Left(0), Height(60), Width(100)]
            middlebutton.setImage(#imageLiteral(resourceName: "arrow-down"), for: .normal)
            middlebutton.addTarget(self, action: #selector(viewchange(sender:)), for: .touchUpInside)
            middlebutton.backgroundColor = UIColor.white
            currentView = scroll
            
            self.view.addSubview(ViewControllerConstant.collectionView)
            ViewControllerConstant.collectionView.controller = self
            ViewControllerConstant.collectionView <- [Top().to(secondScroll, .bottom), Left(), Right(), Bottom()]
            changeSecondScrollButtons(tag: 1, index:0)
        case 1:
            ViewControllerConstant.maleView.removeFromSuperview()
            scroll.removeFromSuperview()
            ViewControllerConstant.maleView.removeFromSuperview()
            self.view.addSubview(ViewControllerConstant.maleView)
            currentView = ViewControllerConstant.maleView
            secondScroll.translatesAutoresizingMaskIntoConstraints = false
            secondScroll.backgroundColor = UIColor.white
            secondScroll <- [Top().to(self.view, .centerY), Left(100), Right(), Height(60), Width(UIScreen.main.bounds.width)]
            self.view.addSubview(middlebutton)
            changeSecondScrollButtons(tag: 6, index:1)
        case 2:
            ViewControllerConstant.maleView.removeFromSuperview()
            ViewControllerConstant.maleView.removeFromSuperview()
            scroll.removeFromSuperview()
            self.view.addSubview(ViewControllerConstant.maleView)
            currentView = ViewControllerConstant.maleView
            changeSecondScrollButtons(tag: 11, index:2)
        case 3:
            ViewControllerConstant.maleView.removeFromSuperview()
            ViewControllerConstant.maleView.removeFromSuperview()
            scroll.removeFromSuperview()
            self.view.addSubview(ViewControllerConstant.maleView)
            currentView = ViewControllerConstant.maleView
            changeSecondScrollButtons(tag: 16, index:3)
        default:
            print("0")
        }
    }
    
    func changeSecondScrollButtons(tag: Int, index: Int){
        let subviews = secondScroll.subviews
        let images = ViewControllerConstant.buttonImages[index]
        var theButton: UIButton? = nil
        var buttons = [UIButton]()
        
        for subview in subviews {
            if subview is UIButton {
                buttons.append(subview as! UIButton)
            }
        }
        
        for (i, button) in buttons.enumerated() {
            if i == 0{
                theButton = button
            }
            button.tag = tag + i
            button.setImage(images[i], for: .normal)
        }
        sectionButton(sender:theButton!)
    }
    
    
    //MARK: - DELEGATE
    func valuePassed(value: String, width: Double, height: Double) {
        addLayers(value: value, width: width, height: height)
    }
    
    func addLayers(value: String, width: Double, height: Double ){
        textArray.append(value)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.reloadData()
        print(self.view.frame.size.width)
        scroll.frame = CGRect(x:0, y:105 , width: self.view.frame.width*3/4,height: self.view.frame.height*35/100)
        let uiView = UIView()
        uiView.frame = CGRect(x:0, y: 0, width: self.view.frame.width * 80/100 , height : self.view.frame.height * 2/5)
        scroll.contentSize = uiView.frame.size
        let index = textArray.count
        uiView.tag = index
        print("UIView tag is---",uiView.tag)
        scroll.addSubview(uiView)
        self.view.addSubview(scroll)
        //   self.view.addSubview(tableView)
        currentView = scroll
        
        var con = [NSLayoutConstraint]()
        var currentLeftWidth:Double = 0
        for i in 1...rowForImage{
            var previousView : UIButton? = nil
            for j in 1...columnForImage{
                let imageView = UIButton()
                imageView.addTarget(self, action: #selector(switchButtonImage(sender:)), for: .touchUpInside)
                imageView.backgroundColor = .clear
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.tag = i + 10*j
                imageView.setImage(#imageLiteral(resourceName: "square"), for: .normal)
                uiView.addSubview(imageView)
                
                if i == rowForImage{
                    con.append(contentsOf:
                        NSLayoutConstraint.constraints(withVisualFormat:
                            "H:|-currentLeftWidth-[imageView(imageViewWidth)]|",
                                                       metrics:["currentLeftWidth": currentLeftWidth, "imageViewWidth":width],
                                                       views:["imageView":imageView]))
                }
                else {
                    con.append(contentsOf:
                        NSLayoutConstraint.constraints(withVisualFormat:
                            "H:|-currentLeftWidth-[imageView(imageViewWidth)]",
                                                       metrics:["currentLeftWidth": currentLeftWidth, "imageViewWidth":width],
                                                       views:["imageView":imageView]))
                }
                if previousView == nil { // first one, pin to top
                    con.append(contentsOf:
                        NSLayoutConstraint.constraints(withVisualFormat:
                            "V:|[imageView(imageViewHeight)]",
                                                       metrics:["imageViewHeight":height],
                                                       views:["imageView":imageView]))
                }
                else { // all others, pin to previous
                    con.append(contentsOf:
                        NSLayoutConstraint.constraints(withVisualFormat:
                            "V:[prev][imageView(imageViewHeight)]",
                                                       metrics:["imageViewHeight": height],
                                                       views:["imageView":imageView, "prev":previousView!]))
                }
                previousView = imageView
            }
            con.append(contentsOf:
                NSLayoutConstraint.constraints(withVisualFormat:
                    "V:[imageView]|", metrics:nil, views:["imageView":previousView!]))
            currentLeftWidth += width
        }
        NSLayoutConstraint.activate(con)
    }
}

