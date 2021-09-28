
//
//  MKMapViewExtended.swift
//  TheBeaconApp
//
//  Created by Ruchin Singhal on 14/12/16.
//  Copyright © 2016 finoit. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView
{
  func getZoomLevel() -> Double
  {
    var angleCamera = self.camera.heading
    if angleCamera > 270
    {
      angleCamera = 360 - angleCamera
    }
    else if angleCamera > 90
    {
      angleCamera = fabs(angleCamera - 180)
    }
    
    let angleRad = Double.pi * angleCamera / 180 // camera heading in radians
    let width = Double(self.frame.size.width)
    let height = Double(self.frame.size.height)
    let heightOffset : Double = 20 // the offset (status bar height) which is taken by MapKit into consideration to calculate visible area height
    
    // calculating Longitude span corresponding to normal (non-rotated) width
    let spanStraight = width * self.region.span.longitudeDelta / (width * cos(angleRad) + (height - heightOffset) * sin(angleRad))
    return log2(360 * ((width / 256) / spanStraight)) + 1;
  }
}
