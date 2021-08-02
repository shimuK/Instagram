//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 志村　圭 on 2021/08/02.
//

import UIKit
import FirebaseUI

class PostTableViewCell: UITableViewCell, UITableViewDelegate {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var cmntButton: UIButton!
    @IBOutlet weak var cmntTableView: UITableView! {
        didSet {
            let nib = UINib(nibName: "CmntTableViewCell", bundle: nil)
            cmntTableView.register(nib, forCellReuseIdentifier: "cmntCell")
        }
    }
    
    var comments:[String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cmntTableView.delegate = self
        cmntTableView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // PostDataの内容をセルに表示
    func setPostData(_ postData: PostData) {
        // 画像の表示
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        postImageView.sd_setImage(with: imageRef)

        // キャプションの表示
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"

        // 日時の表示
        self.dateLabel.text = ""
        if let date = postData.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.string(from: date)
            self.dateLabel.text = dateString
        }

        // いいね数の表示
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"

        // いいねボタンの表示
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
        
        // コメントの表示
        comments = postData.comments
        // TableViewの表示を更新する
        self.cmntTableView.reloadData()
    }
}

extension PostTableViewCell: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cmntCell") as! CmntTableViewCell
        let cmntArray:[String] = self.comments[indexPath.row].components(separatedBy:",")
        cell.cmntLabel.text = "\(cmntArray[0]) : \(cmntArray[1])"

      return cell
    }
}

//extension PostTableViewCell: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 400.0
//    }
//
//}
