//
//  ContactViewController.swift
//  AnimLover
//
//  Created by Marie-Ange Coco on 13/02/2020.
//  Copyright © 2020 Marie-Ange Coco. All rights reserved.
//

import UIKit
import MessageUI

class ContactViewController: UIViewController {
    @IBAction func launchEmailClient(_ sender: Any) {
        sendEmail()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
extension ContactViewController: MFMailComposeViewControllerDelegate{
    func sendEmail(){
        guard MFMailComposeViewController.canSendMail() else {
            //  Afficher une alerte, si le téléphone est capable d'envoyer un mail ou non
            return print("Erreur avec l'envoi de l'e-mail")
        }
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients(["marie.ange.coco@gmail.com"])
        mail.setSubject("Demande d'information suite au JPO WebStart")
        mail.setMessageBody("<p>Félicitations, vous avez reussi !</p>", isHTML: true)
        
        present(mail, animated: true)
        print("Email prêt à partir !")
        
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
