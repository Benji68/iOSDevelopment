//
//  TableViewController.swift
//  SampleProject
//
//  Created by benjamin.chrysostom on 28/05/22.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: SPTableViewDataSource!
    var prefetchDataSource: SPTableViewDataSource!
    var loaderController: LoaderDelegate!
    var senderData: String = ""
    var refreshControl: UIRefreshControl!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchDataFromServer { [weak self] success in
            if let loaderController_ = self?.navigationController?.topViewController as? LoaderDelegate {
                self?.loaderController = loaderController_
                self?.loaderController?.isDataLoaded = success
                print("Data Downloaded Successfully")
            }
        }
    }
    
    func fetchDataFromServer(_ completion: @escaping((Bool) -> Void)) {
        guard let url = URL(string: Constant.feedUrl) else { return }
        ConnectionHandler.getFeedResponse(url: url) { [weak self] response in
            DispatchQueue.main.async {
                if let strongSelf = self {
                    _ = TableViewDataSource(items: response.articles, viewController: strongSelf)
                    completion(true)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        let title = NSMutableAttributedString(string: "Refreshing Data...")
        title.addAttribute(.foregroundColor, value: UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0), range: NSRange(location: 0, length: title.length))
        refreshControl.attributedTitle = title
        tableView.refreshControl = refreshControl
    }
    
    @objc func didPullToRefresh() {
        fetchDataFromServer { [weak self] success in
            if success, self?.refreshControl.superview != nil {
                self?.refreshControl.endRefreshing()
            }
        }
    }
    
    func setUpDataSource() {
        tableView.dataSource = dataSource as? UITableViewDataSource
        tableView.prefetchDataSource = prefetchDataSource as? UITableViewDataSourcePrefetching
        tableView.reloadData()
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselecting the cell again once the user clicks on any cell.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        senderData = (dataSource as? TableViewDataSource)?.getCurrentArticleModel(index: indexPath.row).body_html ?? ""
        return indexPath
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let webViewController = segue.destination as? DetailWebViewController {
            webViewController.webViewModel.htmlString = senderData
        }
       
    }
    

}
