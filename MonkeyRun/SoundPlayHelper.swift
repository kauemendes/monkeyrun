//
//  SoundPlayHelper.m
//  CocosSwift
//
//  Created by Thales Toniolo on 10/09/14.
//  Copyright (c) 2014 Flameworks. All rights reserved.
//
enum GameMusicAndSoundFx:String {
    //case MusicInGame = "MusicInGame.mp3"
	//case SoundFXButtonTap = "SoundFXButtonTap.mp3"
    
    case SoundFaustaoErrou = "faustao-errou.mp3"
    case Palmas = "palmas.mp3"
    case OlhaOMacaco = "olha-o-macaco.mp3"
    case coinSound = "coinSound.mp3"
    case MusicInGame = "bananaPhone.mp3"
    
    
	static let allSoundFx = [coinSound, Palmas, SoundFaustaoErrou, OlhaOMacaco]
}

class SoundPlayHelper {
	// MARK Public Declarations
	
	// MARK Private Declarations
    
    let defaults = NSUserDefaults.standardUserDefaults()

	// MARK: - Singleton
	class var sharedInstance:SoundPlayHelper {
	struct Static {
			static var instance: SoundPlayHelper?
			static var token: dispatch_once_t = 0
		}
		
		dispatch_once(&Static.token) {
			Static.instance = SoundPlayHelper()
		}

		return Static.instance!
	}
	
	// MARK: Private Methods

	// MARK: Public Methods
	func preloadSoundsAndMusic() {
		// Habilita o cache de audio
		OALSimpleAudio.sharedInstance().preloadCacheEnabled = true

		// Apenas uma musica de fundo pode ser cacheada
		OALSimpleAudio.sharedInstance().preloadBg(GameMusicAndSoundFx.MusicInGame.rawValue)

		// Itera todos os SoundsFX para cachear
		for music in GameMusicAndSoundFx.allSoundFx {
			OALSimpleAudio.sharedInstance().preloadEffect(music.rawValue)
		}

		// Define o volume default
		setMusicDefaultVolume()
	}

	func playSoundWithControl(aGameMusic:GameMusicAndSoundFx) {
        if let p: Int = defaults.valueForKey("lsounds") as? Int{
            if( p == 1 ){
                OALSimpleAudio.sharedInstance().playEffect(aGameMusic.rawValue)
            }
        }
	}

	func playMusicWithControl(aGameMusic:GameMusicAndSoundFx, withLoop:Bool) {
        if let p: Int = defaults.valueForKey("lmusics") as? Int{
            if( p == 1 ){
                OALSimpleAudio.sharedInstance().stopBg()
                OALSimpleAudio.sharedInstance().preloadBg(aGameMusic.rawValue)
                OALSimpleAudio.sharedInstance().playBgWithLoop(withLoop)
            }
        }

	}

	func stopAllSounds() {
		OALSimpleAudio.sharedInstance().stopEverything()
	}

	func setMusicVolume(aVolume:Float) {
		OALSimpleAudio.sharedInstance().bgVolume = aVolume
	}

	func setMusicPauseVolume() {
		OALSimpleAudio.sharedInstance().bgVolume = 0.25
	}

	func setMusicDefaultVolume() {
		OALSimpleAudio.sharedInstance().bgVolume = 0.4
		OALSimpleAudio.sharedInstance().effectsVolume = 2.0
	}
}
