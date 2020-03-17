//
//  Extension-CGFloat.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 16/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation

extension CGFloat{
    func degreesToradius() -> CGFloat {
        return self * .pi / 180
    }
    func radiusToDegree() -> CGFloat {
        return self  * 180 / .pi
    }
}
