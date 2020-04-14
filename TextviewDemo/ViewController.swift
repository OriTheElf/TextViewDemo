//
//  AddNoteViewController.swift
//  MySafe
//
//  Created by Amritpal Singh on 5/5/17.
//  Copyright © 2017 sidhu. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {

    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var textViewBottomConstaint: NSLayoutConstraint!
    @IBOutlet weak var copyBtnBottomConstraint: NSLayoutConstraint!

    var edited = false
    var isEditingMode = true
    var tapGesture: UITapGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 添加手势
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapResponse(recognizer:)))

        self.notesTextView.addGestureRecognizer(tapGesture)
        self.notesTextView.isSelectable = false
        self.notesTextView.isEditable = false
    }
    
    //MARK: - Custom Functions
    func word(_ recognizer: UITapGestureRecognizer) {
        
        let location1: CGPoint = recognizer.location(in: notesTextView)
        print("location before: \(location1)")
        
        // 这一句代码过后, location1 和 location2 的值不相同
        let tapPosition: UITextPosition = notesTextView.closestPosition(to: location1)!
        
        let location2: CGPoint = recognizer.location(in: notesTextView)
        print("location before: \(location2)")
        
        
        guard let textRange: UITextRange = notesTextView.tokenizer.rangeEnclosingPosition(tapPosition, with: .word, inDirection: 1) else { return }
        let tappedWord: String = notesTextView.text(in: textRange) ?? ""
        print("XXXXX ->", tappedWord)
    }
    
    func handleTap(_ recognizer: UITapGestureRecognizer) {
        notesTextView.textColor = UIColor.white
        word(recognizer)
    }
    
    // 正常代码
    @objc func tapResponse(recognizer: UITapGestureRecognizer) {
        
        // 错误代码
        handleTap(recognizer)
        
        let location: CGPoint = recognizer.location(in: notesTextView)
        let tapPosition: UITextPosition = notesTextView.closestPosition(to: location)!
        print("tap: \(tapPosition.value(forKey: "_offset") ?? "")")
        guard let textRange: UITextRange = notesTextView.tokenizer.rangeEnclosingPosition(tapPosition, with: .word, inDirection: 1) else {return}
        let tappedWord: String = notesTextView.text(in: textRange) ?? ""
        print("√√√√√√ ->", tappedWord)
    }
    

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

    override func viewWillAppear(_ animated: Bool) {

        if isEditingMode == false {
            copyBtnBottomConstraint.constant = -30
            notesTextView.isEditable = true
            notesTextView.becomeFirstResponder()
        } else {
            copyBtnBottomConstraint.constant = 0
            notesTextView.text = """
            WHEN, IN 1993, Hamid Biglari left his job as a theoretical nuclear physicist at Princeton to join McKinsey consulting, what struck him was that “companies were displacing nations as the units of international competition.”
            This seemed to him a pivotal change. International corporations have a different lens. They optimize globally, rather than nationally. Their aim is to maximize profits across the world — allocating cash where it is most beneficial, finding labor where it is cheapest — not to pursue some national interest.
            
            The shift was fast-forwarded by advances in communications that rendered distance irrelevant, and by the willingness in most emerging markets to open borders to foreign investment and new technologies.
            Hundreds of millions of people in these developing countries were lifted from poverty into the middle class. Conversely, in Western societies, a hollowing out of the middle class began as manufacturing migrated, technological advances eliminated jobs and wages stagnated.

            Looking back, it’s now easy enough to see that the high point of democracy — the victory of open systems over the Soviet imperium that brought down the Berlin Wall in 1989 and set free more than 100 million Central Europeans — was quickly followed by the unleashing of economic forces that would undermine democracies. Far from ending history, liberalism triumphant engendered a reaction.

            The shift was fast-forwarded by advances in communications that rendered distance irrelevant, and by the willingness in most emerging markets to open borders to foreign investment and new technologies.
            Hundreds of millions of people in these developing countries were lifted from poverty into the middle class. Conversely, in Western societies, a hollowing out of the middle class began as manufacturing migrated, technological advances eliminated jobs and wages stagnated.

            Looking back, it’s now easy enough to see that the high point of democracy — the victory of open systems over the Soviet imperium that brought down the Berlin Wall in 1989 and set free more than 100 million Central Europeans — was quickly followed by the unleashing of economic forces that would undermine democracies. Far from ending history, liberalism triumphant engendered a reaction.
            """
        }
        print("ContentSize: \(notesTextView.contentSize)")
    }

    @IBAction func copyAllBtnTapped(_ sender: Any) {
        UIPasteboard.general.string = notesTextView?.text
    }
}

extension AddNoteViewController: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        edited = true
        return true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        notesTextView.textColor = UIColor.white
        textView.isEditable = false
    }
}
