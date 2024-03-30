//
//  ViewController.swift
//  ToDoList
//
//  Created by Droisys on 10/07/23.
//

import UIKit
class contact{
    var firstName:String
    var lastName:String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}
class ViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    
    var contactArray = [contact]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
//        1
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")  // deafult cell apple provide so cell registerd kr skte hai, cell bnane k lie need nhi hai
        
        
//        configuration()
    }


    @IBAction func AddContact(_ sender: Any) {
        
        
//    type:1
        
        let alert = UIAlertController(title: "Add Contact", message: "Enter your contact!", preferredStyle: .alert)

        let save = UIAlertAction(title: "Save", style: .default) {_ in
            //textFields this array so first k lie [0] or last [1]  // if let k sath , 2nd let bhi use kr skte hai
            if let first = alert.textFields?[0].text,
               let last = alert.textFields?[1].text {
//                print(first,last)
                let contact = contact(firstName: first, lastName: last)   // name pass kia
                self.contactArray.append(contact)
                
                
                self.table.reloadData()

            }

        }
        let cancel =  UIAlertAction(title: "Cancel", style: .cancel,handler: nil)

        //placeHolder
        alert.addTextField{ firstNameAdd in
            firstNameAdd.placeholder = "Enter Your FirstName!"

        }
        alert.addTextField{ lastNameAdd in
            lastNameAdd.placeholder = "Enter Your lastName!"

        }
        alert.addAction(save)
        alert.addAction(cancel)  // add show for button
        present(alert,animated: true)
    
    }
}


//2: viewdidload me
//extension ViewController{
//
//    func configuration(){
//        table.dataSource = self
//        table.delegate = self
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")  // deafult cell apple provide so cell registerd kr skte hai, cell bnane k lie need nhi hai
//
//    }
//}


//tableview
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         contactArray.count
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: "cell")else{
            return UITableViewCell()
        }
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = contactArray[indexPath.row].firstName
        cell.detailTextLabel?.text = contactArray[indexPath.row].lastName    // default cell apple provide krta hai  then registered cell func me
        
        return cell
    }
}


//delegate method for swipe  edit and delete
extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //for update
        let editt = UIContextualAction(style: .normal, title: "Edit") { _,_,_  in   // handler me nothing so -,-,- use
            let alert = UIAlertController(title: "Update Contact", message: "Enter your update contact!", preferredStyle: .alert)

            let save = UIAlertAction(title: "Save", style: .default) {_ in
                if let first = alert.textFields?[0].text,
                   let last = alert.textFields?[1].text {
                    let contact = contact(firstName: first, lastName: last)
//                    self.contactArray.append(contact)
//                    for update:
                    self.contactArray[indexPath.row] = contact  // update pr pura contect de dia firstsecondnhi
                    self.table.reloadData()
                    
                }
                
            }
            let cancel =  UIAlertAction(title: "Cancel", style: .cancel,handler: nil)
            
            //placeHolder
            alert.addTextField{ firstNameAdd in
                firstNameAdd.placeholder = self.contactArray[indexPath.row].firstName // 1row select uska placeholder firstName hoga
                
            }
            alert.addTextField{ lastNameAdd in
                lastNameAdd.placeholder = self.contactArray[indexPath.row].lastName
                
            }
            alert.addAction(save)
            alert.addAction(cancel)  // add show for button
            self.present(alert,animated: true)
        }
        editt.backgroundColor = .green
        
        
        
        //for delete
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _,_,_ in

            self.contactArray.remove(at: indexPath.row)
            self.table.reloadData()
        }
        let swipeConfi = UISwipeActionsConfiguration(actions: [delete, editt])

        return swipeConfi
    }
    
}






//type:2

