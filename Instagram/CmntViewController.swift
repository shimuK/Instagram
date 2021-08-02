//
//  CmntViewController.swift
//  Instagram
//
//  Created by 志村　圭 on 2021/08/02.
//

import UIKit
import Firebase
import SVProgressHUD

class CmntViewController: UIViewController {

    @IBOutlet weak var cmntTextField: UITextField!
    
    var postData :PostData!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handlePostButton(_ sender: Any) {
        if let cmnt = cmntTextField.text {
            // コメントが入力されていない時はHUDを出して何もしない
            if cmnt.isEmpty {
                SVProgressHUD.showError(withStatus: "コメントを入力して下さい")
                return
            }
            
            // コメントを設定する
            let user = Auth.auth().currentUser
            if let displayName = user?.displayName {
                let cmntStr = "\(displayName),\(cmnt)"
                
                var cmntField: FieldValue
                cmntField = FieldValue.arrayUnion([cmntStr])
                let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
                postRef.updateData(["comments": cmntField])
                
                print("DEBUG_PRINT: [displayName = \(displayName)) ], cmnt = \(cmnt)]の設定に成功しました。")
                
                // HUDで完了を知らせる
                SVProgressHUD.showSuccess(withStatus: "コメントを投稿しました")
                
                // Home画面を表示する
                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                self.present(homeViewController!, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        // Home画面を表示する
        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "Home")
        self.present(homeViewController!, animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
