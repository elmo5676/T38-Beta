//
//  PlanningGonk.swift
//  T38
//
//  Created by Matthew Elmore on 5/7/19.
//  Copyright © 2019 elmo. All rights reserved.
//

import Foundation

struct PlanningGonk {
    
    //Restricted Climb:
    //Alt: [rcStdTemp:0, rcClimb@KIAS:1, rcClimb@Mach:2, rcTime:3, rcDist:4, rcFuelUsed:5, rcTempCorrection:6]
    var rcKIAS: Double      = 0.0   //1
    var rcMach: Double      = 0.0   //2
    var rcTime: Double      = 0.0   //3
    var rcDistance: Double  = 0.0   //4
    var rcFuelUsed: Double  = 0.0   //5
    //Max Range Cruise
    //Alt: [mrcMach:0, mrcKIAS:1, mrcKTAS:2, mrcFFLb/hr:3, mrcFFLb/min:4]
    var mrcMach: Double     = 0.0   //0
    var mrcKIAS: Double     = 0.0   //1
    var mrcKTAS: Double     = 0.0   //2
    var mrcFFpHr: Double    = 0.0   //3
    var mrcFFpMin: Double   = 0.0   //4
    var mrcRange: Double    = 0.0
    //Max Range Cruise
    //Alt: [p9mMach:0, p9mKIAS:1, p9mKTAS:2, p9mFFlb/hr:3, p9mFFLbs/min:4]
    var p9mMach: Double     = 0.0   //0
    var p9mKIAS: Double     = 0.0   //1
    var p9mKTAS: Double     = 0.0   //2
    var p9mFFpHr: Double    = 0.0   //3
    var p9mFFpMin: Double   = 0.0   //4
    var p9mRange: Double    = 0.0
    //AirField Results Info
    var afMrcTime: Double       = 0.0
    var afMrcFuelUsed: Double   = 0.0
    var afMrcFuelRemain: Double = 0.0
    var afP9mTime: Double       = 0.0
    var afP9mFuelUsed: Double   = 0.0
    var afP9mFuelRemain: Double = 0.0
    
    
    init(depAlt: Double,
         alt: Double,
         fuel: Double,
         distAway: Double?) {
        //depAlt/1000 is to match up units from the calculator and the device
        self.calc(depAlt: depAlt/1000, alt: alt, fuel: fuel, distAway: distAway)
    }
    
    var restrictedClimb: [Double: [Double]] = [
        //rc = Restricted Climb
        //Alt: [rcStdTemp:0, rcClimb@KIAS:1, rcClimb@Mach:2, rcTime:3, rcDist:4, rcFuelUsed:5, rcTempCorrection:6]
        41  :[-56.5,259,0.87,13.0,100,890,8],
        39  :[-56.5,275,0.87,10.5,85,805,7],
        37  :[-56.5,285,0.87,9.0,70,770,7],
        35  :[-54.3,295,0.86,8.0,63,730,6],
        33  :[-50.4,305,0.85,7.0,55,690,6],
        31  :[-46.4,317,0.84,6.5,50,670,6],
        29  :[-42.4,328,0.84,6.0,45,635,5],
        25  :[-34.5,349,0.83,5.0,37,585,5],
        20  :[-24.7,377,0.80,3.7,28,520,4],
        15  :[-14.7,406,0.79,3.0,23,450,3],
        10  :[-4.8,300,0.52,2.5,11,385,2],
        5   :[5.1,300,0.50,2.0,5,250,2]]
    
    var maxRangeCruise: [Double: [Double]] = [
        //mrc = Max Range Cruise
        //Alt: [mrcMach:0, mrcKIAS:1, mrcKTAS:2, mrcFFLb/hr:3, mrcFFLb/min:4]
        41  :[0.88,261,505,1380,23.0],
        39  :[0.86,268,493,1385,23.1],
        37  :[0.85,275,487,1450,24.2],
        35  :[0.84,283,484,1510,25.2],
        33  :[0.82,294,487,1530,25.5],
        31  :[0.81,298,475,1600,26.7],
        29  :[0.79,307,467,1630,27.2],
        25  :[0.75,321,457,1730,28.8],
        20  :[0.70,327,433,1890,31.5],
        15  :[0.66,336,413,1980,33.0],
        10  :[0.61,324,380,2040,34.0],
        5   :[0.46,280,300,2020,33.6]]
    
    var p9mCruise: [Double: [Double]] = [
        //p9m = 0.9 Mach Cruise
        //Alt: [p9mMach:0, p9mKIAS:1, p9mKTAS:2, p9mFFlb/hr:3, p9mFFLbs/min:4]
        41  :[0.90,266,516,1455,24.3],
        39  :[0.90,280,516,1470,24.5],
        37  :[0.90,293,516,1560,26.0],
        35  :[0.90,305,518,1720,28.7],
        33  :[0.90,323,525,1780,29.7],
        31  :[0.90,337,528,1950,32.5],
        29  :[0.90,352,532,2080,34.7],
        25  :[0.90,380,543,2260,37.7],
        20  :[0.90,421,553,2840,47.3],
        15  :[0.90,464,565,3320,55.3],
        10  :[0.90,491,577,3750,62.5],
        5   :[0.50,300,320,2200,36.7]]
    
    
    private func lineSolver(knownX: Double, X1: Double, X2: Double, Y1: Double, Y2: Double) -> Double {
        let m = (Y2 - Y1)/(X2 - X1)
        let b = Y1 - (m * X1)
        return  (m * knownX + b)
    }
    
    private func chartSolver(alt: Double, altDic: [Double: [Double]], columnIndex: Int) -> Double {
        var altBounds: [Double] = [5,10,15,20,25,29,31,33,35,37,39,41]
        var result = 0.0
        var X1 = 0.0
        var X2 = 0.0
        var Y1 = 0.0
        var Y2 = 0.0
        for a in altBounds {
            if alt == a {
                let a = altDic[a]
                result = a![columnIndex]
                break
            }
            if alt < altBounds[0] {
                //TODO: Make this a throws function and this will be an error
                print("Alt is below charted Data")
                print("\(alt) in \(altBounds.description)")
                break
            }
            if alt > altBounds.last! {
                //TODO: Make this a throws function and this will be an error
                print("Alt is above charted Data")
                print("\(alt) in \(altBounds)")
                break
            }
            if alt < a {
                let index = altBounds.firstIndex(of: a)
                X1 = altBounds[index! - 1]
                X2 = altBounds[index!]
                Y1 = {
                    let a = altDic[X1]!
                    let b = a[columnIndex]
                    return b
                }()
                Y2 = {
                    let a = altDic[X2]!
                    let b = a[columnIndex]
                    return b
                }()
                result = lineSolver(knownX: alt, X1: X1, X2: X2, Y1: Y1, Y2: Y2)
                break
            }
            
        }
        return result
    }
    
    private mutating func calc(depAlt: Double,
                               alt: Double,
                               fuel: Double,
                               distAway: Double?){
        
        self.rcKIAS      = chartSolver(alt: alt, altDic: restrictedClimb, columnIndex: 1)
        self.rcMach      = chartSolver(alt: alt, altDic: restrictedClimb, columnIndex: 2)
        let startRcTime  = chartSolver(alt: depAlt, altDic: restrictedClimb, columnIndex: 3)
        let startRcDist  = chartSolver(alt: depAlt, altDic: restrictedClimb, columnIndex: 4)
        let startRcFU    = chartSolver(alt: depAlt, altDic: restrictedClimb, columnIndex: 5)
        let finalRcTime  = chartSolver(alt: alt, altDic: restrictedClimb, columnIndex: 3)
        let finalRcDist  = chartSolver(alt: alt, altDic: restrictedClimb, columnIndex: 4)
        let finalRcFU    = chartSolver(alt: alt, altDic: restrictedClimb, columnIndex: 5)
        //This accounts for starting from an alt above sea level
        self.rcTime      = finalRcTime - startRcTime
        self.rcDistance  = finalRcDist - startRcDist
        self.rcFuelUsed  = finalRcFU - startRcFU
        self.mrcMach     = chartSolver(alt: alt, altDic: maxRangeCruise, columnIndex: 0)
        self.mrcKIAS     = chartSolver(alt: alt, altDic: maxRangeCruise, columnIndex: 1)
        self.mrcKTAS     = chartSolver(alt: alt, altDic: maxRangeCruise, columnIndex: 2)
        self.mrcFFpHr    = chartSolver(alt: alt, altDic: maxRangeCruise, columnIndex: 3)
        self.mrcFFpMin   = chartSolver(alt: alt, altDic: maxRangeCruise, columnIndex: 4)
        self.p9mMach     = chartSolver(alt: alt, altDic: p9mCruise, columnIndex: 0)
        self.p9mKIAS     = chartSolver(alt: alt, altDic: p9mCruise, columnIndex: 1)
        self.p9mKTAS     = chartSolver(alt: alt, altDic: p9mCruise, columnIndex: 2)
        self.p9mFFpHr    = chartSolver(alt: alt, altDic: p9mCruise, columnIndex: 3)
        self.p9mFFpMin   = chartSolver(alt: alt, altDic: p9mCruise, columnIndex: 4)
        
        self.mrcRange = {
            let a = fuel - rcFuelUsed
            let b = a/mrcFFpMin
            return (b * mrcKTAS.knotsPHrToNMperMin)
        }()
        
        self.p9mRange = {
            let a = fuel - rcFuelUsed
            let b = a/p9mFFpMin
            return (b * p9mKTAS.knotsPHrToNMperMin)
        }()
        
        if let distAway = distAway {
            let distRemaingAtLevelOff: Double = {
                return distAway - rcDistance
            }()
            let mrcTimeCompontent: Double = {
                return distRemaingAtLevelOff / mrcKTAS.knotsPHrToNMperMin
            }()
            let p9mTimeComponent: Double = {
                return distRemaingAtLevelOff / p9mKTAS.knotsPHrToNMperMin
            }()
            self.afMrcTime = mrcTimeCompontent + rcTime
            self.afMrcFuelUsed = (mrcFFpMin * mrcTimeCompontent) + rcFuelUsed
            self.afMrcFuelRemain = fuel - afMrcFuelUsed
            self.afP9mTime = p9mTimeComponent + rcTime
            self.afP9mFuelUsed = (p9mFFpMin * p9mTimeComponent) + rcFuelUsed
            self.afP9mFuelRemain = fuel - afP9mFuelUsed
        }
    }
}
