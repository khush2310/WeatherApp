//
//  TemperatureParametersView.swift
//  WeatherApp
//
//  Created by Khushboo Jain on 2023-05-09.
//

import UIKit

@IBDesignable
class TemperatureParametersView: UIView {
    
    var view : UIView?
    
    @IBOutlet weak var lbPrecipitation: UILabel!
    @IBOutlet weak var lbLow: UILabel!
    @IBOutlet weak var lbHigh: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func xibSetup() {
        view?.removeFromSuperview()
        view = loadViewFromNib()
        view?.frame = bounds
        view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        guard let views = view else { return }
        view?.removeFromSuperview()
        addSubview(views)
    }
    
    func loadViewFromNib() -> UIView? {
        let nibName = "TemperatureParametersView"
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view =  nib.instantiate(withOwner: self,options: nil).first as? UIView
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func setUpView(weather: WeatherModel) {
        lbHigh.text = weather.maxTempString
        lbLow.text = weather.minTempString
        lbPrecipitation.text = weather.precipitationString
        lbDate.text = weather.dateString
        self.setNeedsDisplay()
        self.layoutSubviews()
    }
    
}
