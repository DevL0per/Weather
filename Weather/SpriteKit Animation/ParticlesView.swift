//
//  ParticlesView.swift
//  Weather
//
//  Created by Роман Важник on 09/10/2019.
//  Copyright © 2019 Роман Важник. All rights reserved.
//

import UIKit
import SpriteKit

class ParticlesView: SKView {
    
    override func didMoveToSuperview() {
        self.allowsTransparency = true
        self.backgroundColor = .clear
    }
    
    func startAnimating(type: String) {
        let scene = SKScene(size: self.frame.size)
        scene.backgroundColor = .clear
        
        var fileName: String?
        
        switch type {
        case "rain":
            fileName = "RainParticleScene.sks"
        case "sleet":
            fileName = "SleetParticleScene.sks"
        case "snow":
            fileName = "SnowParticleScene.sks"
        default:
            break
        }
        
        if let fileName = fileName, let particles = SKEmitterNode(fileNamed: fileName) {
            particles.position = CGPoint(x: self.frame.width/2, y: self.frame.height)
            particles.particlePositionRange = CGVector(dx: self.frame.width, dy: 0)
            scene.addChild(particles)
        }
        self.presentScene(scene)
    }
    
}
