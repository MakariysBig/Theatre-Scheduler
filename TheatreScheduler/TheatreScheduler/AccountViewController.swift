import UIKit
import NetworkKit

final class AccountViewController: UIViewController {
    
    private let networkService: NetworkProtocol = NetworkManager()

    init() {
        print("inited")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkService.getCrypto(pair: "btc") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                print(data)
            case .failure(_):
                print("error")
            }
        }
    }


}

