import UIKit
import Alamofire

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var inputTF: UITextField!
    @IBOutlet var sendButon: UIButton!
    @IBOutlet var responseLabel: UILabel!
    
    @IBOutlet var tfView: UIView!
    @IBOutlet var tableView: UITableView!
    
    var otherMsgArray : [String] = []
    var youMsgArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfView.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8901960784, blue: 0.8901960784, alpha: 1)
        tfView.layer.borderWidth =  1.0
        tfView.layer.cornerRadius = 8.0
        
        sendButon.layer.cornerRadius = 8.0
        
        tableView.register(UINib(nibName: "youTableViewCell", bundle: nil), forCellReuseIdentifier: "youCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return youMsgArray.count + otherMsgArray.count
        }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.row % 2 == 0 {
                // Even index, show user message
                let userIndex = indexPath.row / 2
                if userIndex < youMsgArray.count {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "youCell", for: indexPath) as! youTableViewCell
                    cell.youMsgLabel.text = youMsgArray[userIndex]
                    cell.layer.cornerRadius = 12.0
                    return cell
                }
            } else {
                // Odd index, show chatbot message
                let chatbotIndex = (indexPath.row - 1) / 2
                if chatbotIndex < otherMsgArray.count {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "otherCell", for: indexPath) as! otherTableViewCell
                    cell.layer.cornerRadius = 12.0
                    cell.otherMsgLabel.text = otherMsgArray[chatbotIndex]
                    return cell
                }
            }

            // Default case, return an empty cell
            return UITableViewCell()
        }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
    
    

    @IBAction func sendTapped(_ sender: UIButton) {
        if let userMessage = inputTF.text, !userMessage.isEmpty {
               youMsgArray.append(userMessage)
               tableView.reloadData()
               inputTF.text = ""
               sendMessage(message: userMessage)
           }
    }
    
    func sendMessage(message: String) {
        let apiUrl = "https://wsapi.simsimi.com/190410/talk"
        let apiKey = "3uqGNnf3T0-I12mVf-GaTqbcdf~HjA6fILD~YMJv"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "x-api-key": apiKey
        ]
        
        let parameters: [String: Any] = [
            "utext": message,
            "lang": "en"
        ]
        
        AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: ChatbotResponse.self) { response in
                switch response.result {
                case .success(let chatbotResponse):
                    self.handleChatbotResponse(response: chatbotResponse.atext)
                case .failure(let error):
                    self.handleChatbotError(error: error)
                }
            }
    }

    func handleChatbotResponse(response: String) {
        otherMsgArray.append(response)
        tableView.reloadData()
    }


    
//    func handleChatbotResponse(response: String) {
//            responseLabel.text = response
//        }
        
        func handleChatbotError(error: Error) {
            // Display an error message to the user
            let alert = UIAlertController(title: "Error", message: "An error occurred. Please try again later.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    
    
}
