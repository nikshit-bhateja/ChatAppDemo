//
//  ViewController.swift
//  ChatApp
//
//  Created by Nikk Bhateja on 25/03/25.
//

import UIKit
import PhotosUI

class ConversationViewController: UIViewController {

    //MARK: @IBOutlets
    
    // UITableView
    @IBOutlet weak var chatListTableView: UITableView!
    
    // UIButton
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var sendMessageButton: UIButton!
    
    // UITextField
    @IBOutlet weak var newMessageTextField: UITextField!
    
    // UIView
    @IBOutlet weak var mainBGView: UIView!
    @IBOutlet weak var toolBarBGView: UIView!
    
    // Constraints
    @IBOutlet weak var toolBarBottomConstraint: NSLayoutConstraint!
    
    
    //MARK: Properties
    //Array
    var messages:[MessageModel] = []
  
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        // register cells
        registerCells()
        addObservers()
        addGestureToHideKeyboard()
    }
    
    //MARK: Custom Methods
    private func registerCells() {
        self.chatListTableView.dataSource = self
        self.chatListTableView.delegate = self
                
        let nib = UINib(nibName: TextMessageTableViewCell.description(), bundle: nil)
        self.chatListTableView.register(nib, forCellReuseIdentifier: TextMessageTableViewCell.description())
        
        let receiverNib = UINib(nibName: ReceiverTextMessageTableViewCell.description(), bundle: nil)
        self.chatListTableView.register(receiverNib, forCellReuseIdentifier: ReceiverTextMessageTableViewCell.description())
        
        let mediaCell = UINib(nibName: SenderMediaMessageTableViewCell.description(), bundle: nil)
        self.chatListTableView.register(mediaCell, forCellReuseIdentifier: SenderMediaMessageTableViewCell.description())
    }
    
    func scrollToBottom() {
        DispatchQueue.main.async {
            let lastRow = self.messages.count - 1
            if lastRow >= 0 {
                let indexPath = IndexPath(row: lastRow, section: 0)
                self.chatListTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight: CGFloat = keyboardFrame.cgRectValue.height
            self.toolBarBottomConstraint.constant = keyboardHeight - 8
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            self.toolBarBottomConstraint.constant = 8
        }
    }
    
    func addGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(hideKeyboard))
        tapGesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        self.newMessageTextField.resignFirstResponder()
    }
    
    func insertNewMessage() {
        let newIndexPath = IndexPath(row: messages.count - 1, section: 0)
        
        self.chatListTableView.beginUpdates()
        self.chatListTableView.insertRows(at: [newIndexPath], with: .bottom)
        self.chatListTableView.endUpdates()

        self.scrollToBottom()
    }

    
    //MARK: @IBAction
    @IBAction func cameraTapped(_ sender: UIButton) {
        self.openPhotoLibrary()
    }
    
    @IBAction func sendMessageTapped(_ sender: UIButton) {
        if let message = newMessageTextField.text, !(message.isEmpty) {
            let messageModel = MessageModel(text: message, userId: "0", image: "", timestamp: Date.now, messageType: "Text")
            self.messages.append(messageModel)
            self.insertNewMessage()
        }
        self.newMessageTextField.text = ""
        
    }
    
}


//MARK: UITableViewDelegate
extension ConversationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

//MARK: UITableViewDataSource
extension ConversationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (messages[indexPath.row].userId == "0") {
            if(messages[indexPath.row].messageType == "Text") {
                guard let textCell = tableView.dequeueReusableCell(withIdentifier: TextMessageTableViewCell.description(), for: indexPath) as? TextMessageTableViewCell else {
                    return UITableViewCell()
                }
                
                textCell.setupCellUI()
                textCell.setMessageData(message: self.messages[indexPath.row])
                
                return textCell
            }else{
                guard let mediaCell = tableView.dequeueReusableCell(withIdentifier: SenderMediaMessageTableViewCell.description(), for: indexPath) as? SenderMediaMessageTableViewCell else {
                    return UITableViewCell()
                }
                
                mediaCell.setUI()
                mediaCell.setMedia(message: messages[indexPath.row])
                
                return mediaCell
            }
        } else {
            guard let textCell = tableView.dequeueReusableCell(withIdentifier: ReceiverTextMessageTableViewCell.description(), for: indexPath) as? ReceiverTextMessageTableViewCell else {
                return UITableViewCell()
            }
            
            textCell.setupCellUI()
            textCell.setMessageData(message: self.messages[indexPath.row])
            
            return textCell
        }
    }
}



extension ConversationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func openPhotoLibrary() {
        Task {
            let status = await PHPhotoLibrary.requestAuthorization(for: .readWrite)

            DispatchQueue.main.async {
                switch status {
                case .authorized, .limited:
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.allowsEditing = true
                    self.present(imagePicker, animated: true)
                    
                case .notDetermined, .restricted, .denied:
                    print("PHPhotoLibrary authorization status: .notDetermined, .restricted, .denied")
                    
                    
                @unknown default:
                    print("PHPhotoLibrary authorization status: \(status.rawValue)")
                }
            }
        }
    }
    
    func saveImageToDocuments(image: UIImage) -> URL? {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
            
            let filename = UUID().uuidString + ".jpg"
            let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)

            do {
                try data.write(to: fileURL)
                return fileURL
            } catch {
                print("Error saving image: \(error)")
                return nil
            }
                
                
                
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            print(userPickedImage)
            let imageUrl = saveImageToDocuments(image: userPickedImage)
            let message = MessageModel(text: "", userId: "0", image: imageUrl?.absoluteString, timestamp: Date.now, messageType: "Media")
            let path = imageUrl?.absoluteString ?? ""
            print("Path of image --> \(path)")
            messages.append(message)
            insertNewMessage()
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
