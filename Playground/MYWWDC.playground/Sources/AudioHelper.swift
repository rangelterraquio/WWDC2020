//
//  File.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 25/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import AVFoundation

private let AudioHelperInstance = AudioHelper()

public class AudioHelper{
    
    private var backgroundMusicPlayer: AVAudioPlayer!
    private var soundEffectPlayer: AVAudioPlayer!
   
    public class func sharedInstance() -> AudioHelper{
        return AudioHelperInstance
    }
    
    public func playBackgroundMusic(music: Music){
        
        guard let url = Bundle.main.url(forResource: music.file.name, withExtension: music.file.exten) else {return}
        
        
        do {
           backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
        } catch{
            print("error with fileName: \(music.file.name)")
            backgroundMusicPlayer = nil
        }
        
        if let backgroundMusicPlayer = backgroundMusicPlayer{
            backgroundMusicPlayer.numberOfLoops = -1
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play()
        }else{
            print("Error")
        }
        
        
    }
    
    public func pauseBackgroundMusic(){
        if let backgroundMusicPlayer = backgroundMusicPlayer{
            if backgroundMusicPlayer.isPlaying{
                backgroundMusicPlayer.pause()
            }
        }
    }
    

    public func resumeBackgroundMusic() {
        if let player = backgroundMusicPlayer {
            if !player.isPlaying {
                player.play()
            }
        }
    }
    
    public func playSoundEffect(music: Music){
        
        guard let url = Bundle.main.url(forResource: music.file.name, withExtension: music.file.exten) else {return}
        
        
        do {
           soundEffectPlayer = try AVAudioPlayer(contentsOf: url)
        } catch{
            print("error with fileName: \(music.file.name)")
            soundEffectPlayer = nil
        }
        
        if let backgroundMusicPlayer = soundEffectPlayer{
            backgroundMusicPlayer.numberOfLoops = 0
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play()
        }else{
            print("Error")
        }
        
    }
    
}


public enum Music{
    case error
    case jumping
    case jetpack
    case collectable
    
    
    struct File{
        let name: String
        let exten: String
    }
    var file: File{
        switch self {
        case .error:
            return File(name: "error", exten: ".mp3")
        case .jumping:
            return File(name: "click", exten: ".wav")
        case .jetpack:
            return File(name: "jetpack", exten: ".wav")
        case .collectable:
            return File(name: "collectable", exten: ".wav")
        }
    }
}
