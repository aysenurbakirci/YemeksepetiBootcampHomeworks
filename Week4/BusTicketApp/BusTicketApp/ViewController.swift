//
//  ViewController.swift
//  BusTicketApp
//
//  Created by Ayşe Nur Bakırcı on 21.07.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var continueButton: UIButton!
    
    private var seatCount = 44
    private var soldSeat: [Int] = []
    var newSoldedSeats: [Int] = []
    var selectedSeats: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        continueButton.layer.cornerRadius = 10
        navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        for seat in newSoldedSeats {
            soldSeat.append(seat)
        }
        newSoldedSeats.removeAll()
        collectionView.reloadData()
    }
    
    @IBAction func continueButtonClick(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CustomerInformationViewController") as! CustomerInformationViewController
        
        if selectedSeats.count == 0 {
            
            makeAlert(title: "You have not selected a seat.", message: "You must select at least 1 seat.")
            
        } else {
            vc.selectedSeatList = selectedSeats
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seatCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seatCell", for: indexPath) as? SeatCollectionViewCell{
        
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 8
            
            if isSold(seatNumber: indexPath.row + 1){
                cell.backgroundColor = .gray
            } else if isSelected(seatNumber: indexPath.row + 1){
                cell.backgroundColor = .green
            } else {
                cell.backgroundColor = .white
            }
            
            cell.seatNumber.text = String(indexPath.row + 1)
            
            return cell
            
        } else {
            
            return UICollectionViewCell()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        if cell?.backgroundColor == .white {
            
            if emptySeatOperations(index: indexPath.row){
                cell?.backgroundColor = .green
            }
            
        } else if cell?.backgroundColor == .gray {
            
            makeAlert(title: "Sold!", message: "This seat has been sold.")
            
        } else {
            
            if selectedSeatOperations(index: indexPath.row) {
                cell?.backgroundColor = .white
            }
            
        }
    }
    
    private func emptySeatOperations(index: Int) -> Bool{
        
        if selectedSeats.count > 4 {
            makeAlert(title: "You have reached the maximum number.", message: "You can purchase up to 5 seats.")
            return false
        } else {
            selectedSeats.append(index + 1)
            return true
        }
    }
    
    private func selectedSeatOperations(index: Int) -> Bool{
        selectedSeats.removeAll{
            $0 == (index + 1)
        }
        return true
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = (self.view.frame.width / 5)
        let height: CGFloat = (self.view.frame.width / 5)
        
        return CGSize(width: width, height: height)
    }
    
}

extension ViewController {
    
    private func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func isSold(seatNumber: Int) -> Bool {
        
        for seat in soldSeat {
            if seatNumber == seat {
                return true
            }
        }
        
        return false
    }
    
    private func isSelected(seatNumber: Int) -> Bool {
        
        for seat in selectedSeats {
            if seatNumber == seat {
                return true
            }
        }
        
        return false
    }
    
}
