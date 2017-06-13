
import UIKit

struct CollectionViewImage {
    var imageName: String
    init(imageName:String) {
    self.imageName = imageName
    }
}
class ElementsCollectionView: UICollectionView, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
   
    var arrayOfGridImages = [CollectionViewImage]()
    var images = [#imageLiteral(resourceName: "tileimage1"),#imageLiteral(resourceName: "tile2"),#imageLiteral(resourceName: "tile3"), #imageLiteral(resourceName: "tile4"), #imageLiteral(resourceName: "tile5")]
    var selectedButton: UIImageView?
    var needToChangeImageView: UIImageView?
    let interimSpacing = CGFloat(0)
    var image = [CollectionViewImage(imageName: "tileImage1"),CollectionViewImage(imageName:"tile2"),CollectionViewImage(imageName:"tile3"),CollectionViewImage(imageName:"tile3"),CollectionViewImage(imageName:"tile4")]
    

    weak var controller : ViewController?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout){
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = .white
       
        let flowLayout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width)/3
        flowLayout.itemSize = CGSize(width:width,height:width - 50)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: interimSpacing, bottom: 0, right: interimSpacing)
        self.setCollectionViewLayout(flowLayout, animated: true)
        self.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        self.delegate = self
        self.dataSource = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        cell.backgroundColor = .white
        cell.layer.borderWidth = 1.0
     //   cell.layer.borderColor= UIColor.black as! CGColor
        if cell.backgroundView == nil{
            let imageView = UIImageView()
            imageView.image = images[indexPath.row]
            imageView.backgroundColor = .clear
            imageView.contentMode = .scaleAspectFit
            cell.backgroundView = imageView
        }else{
            let imageView = cell.backgroundView as! UIImageView
            imageView.image = images[indexPath.item]
        }
    
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let cell = collectionView.cellForItem(at: indexPath)
        
       if controller?.currentView == controller?.scroll
       {
            
            let buttons = controller?.highlightedButtons
            if selectedButton == nil{
                if !(buttons?.isEmpty)!{
                    var image: UIImage
                    image = (cell?.backgroundView as! UIImageView).image!
                    
                    for button in buttons!{
                        button.setImage(image, for: .normal)
                     //   button.backgroundColor = .clear
                   }
                    
                    controller?.highlightedButtons.removeAll()
               }
                else{
                    cell?.backgroundColor = .lightGray
                    selectedButton = cell?.backgroundView as! UIImageView!
                    let selectedImageArray = controller?.dictionaryOfImages[(selectedButton?.image)!]
                    guard let array = selectedImageArray else {
                        return
                    }
                    arrayOfGridImages = array
                }
            }
            else if selectedButton == (cell?.backgroundView as! UIImageView!){
                cell?.backgroundColor = .white
                selectedButton = nil
            }
            else {
                cell?.backgroundColor = .lightGray
                selectedButton = cell?.backgroundView as! UIImageView!
            }
        }
        else {
            let image = (cell?.backgroundView as! UIImageView).image!
            needToChangeImageView?.image = image
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath){
            cell.backgroundColor = .lightGray
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath){
            cell.backgroundColor = .white
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath){
        if let cell = collectionView.cellForItem(at: indexPath){
            cell.backgroundColor = .white
            selectedButton = nil
        }
    }
    
    
}

