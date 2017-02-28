//
//  SudokuSquare.swift
//  Sudoku
//
//  Created by James Campagno on 2/22/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

protocol SudokuSquareDelegate: class {
    func sudokuSquare(_ sudokuSquare: SudokuSquare, canPlayAt position: Int) -> Bool
    func sudokuSquare(_ sudokuSquare: SudokuSquare, didUpdateLabelWith value: Int)
}

class SudokuSquare: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    
    var position: Int!
    weak var delegate: SudokuSquareDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("SudokuSquare", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        numberLabel.addGestureRecognizer(tapGesture)
    }
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        guard let allowedToPlay = delegate?.sudokuSquare(self, canPlayAt: position) else { return }

        if allowedToPlay {
            animateTurn()
        }
    }
    
    func animateTurn() {
        layer.borderColor = UIColor.green.cgColor
        layer.borderWidth = 2.0
        numberLabel.alpha = 0.7
    }
    
    func reset() {
        layer.borderColor = nil
        layer.borderWidth = 0.0
        numberLabel.alpha = 1.0
    }
    
    func updateNumberLabel(with value: Int) {
        numberLabel.text = String(value)
        delegate?.sudokuSquare(self, didUpdateLabelWith: value)
        reset()
    }
    
}
