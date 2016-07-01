//
//  HomeScene.swift
//  CocosSwift
//
//  Created by Thales Toniolo on 10/09/14.
//  Copyright (c) 2014 Flameworks. All rights reserved.
//
// MARK: - Class Definition
class HomeScene : CCScene {
    // MARK: - Public Objects
    
    // MARK: - Private Objects
    let defaults = NSUserDefaults.standardUserDefaults()
    private var hs:Int = 0
    let soundFx:CCButton = CCButton(title: "[SoundFX: OFF]", fontName: "Verdana-Bold", fontSize: 22.0)
    let soundBtn:CCButton = CCButton(title: "[Music: OFF]", fontName: "Verdana-Bold", fontSize: 22.0)
    
    // MARK: - Life Cycle
    override init() {
        super.init()
        
        self.userInteractionEnabled = true
        
        if let p: Int = NSUserDefaults.standardUserDefaults().valueForKey("score1") as? Int{
            
        }
        else
        {
            self.defaults.setObject(0, forKey: "score1")
        }
        
        if let p: Int = NSUserDefaults.standardUserDefaults().valueForKey("score2") as? Int{
            
        }
        else
        {
            self.defaults.setObject(0, forKey: "score2")
        }
        
        if let p: Int = NSUserDefaults.standardUserDefaults().valueForKey("score3") as? Int{
            
        }
        else
        {
            self.defaults.setObject(0, forKey: "score3")
        }
        
        if let p: Int = NSUserDefaults.standardUserDefaults().valueForKey("score4") as? Int{
            
        }
        else
        {
            self.defaults.setObject(0, forKey: "score4")
        }
        
        if let p: Int = NSUserDefaults.standardUserDefaults().valueForKey("score5") as? Int{
            
        }
        else
        {
            self.defaults.setObject(0, forKey: "score5")
        }
        
        if let p: Int = NSUserDefaults.standardUserDefaults().valueForKey("lsounds") as? Int{
            soundFx.title = "[SoundFX: OFF]"
            if ( p == 1 )
            {
                soundFx.title = "[SoundFX: ON]"
            }
        }
        else
        {
            self.defaults.setObject(1, forKey: "lsounds")
            soundFx.title = "[SoundFX: ON]"
        }
        
        if let p: Int = NSUserDefaults.standardUserDefaults().valueForKey("lmusics") as? Int{
            soundBtn.title = "[Music: OFF]"
            if ( p == 1 )
            {
                soundBtn.title = "[Music: ON]"
            }
        }
        else
        {
            self.defaults.setObject(1, forKey: "lmusics")
            soundBtn.title = "[Music: ON]"
        }
        
        // Configura os objetos na tela
        self.createSceneObjects()
    }
    
    override func onEnter() {
        // Chamado apos o init quando entra no director
        super.onEnter()
    }
    
    func habilitaSounds()
    {
        if let p: Int = defaults.valueForKey("lsounds") as? Int{
            if( p == 1)
            {
                self.soundFx.title = "[SoundFX: OFF]"
                self.defaults.setObject(0, forKey: "lsounds")
            }
            else
            {
                self.soundFx.title = "[SoundFX: ON]"
                self.defaults.setObject(1, forKey: "lsounds")
            }
        }
        
    }
    
    func habilitaMusic()
    {
        if let p: Int = defaults.valueForKey("lmusics") as? Int{
            if( p == 1)
            {
                self.soundBtn.title = "[Music: OFF]"
                self.defaults.setObject(0, forKey: "lmusics")
            }
            else
            {
                self.soundBtn.title = "[Music: ON]"
                self.defaults.setObject(1, forKey: "lmusics")
            }
        }
        
    }
    
    // MARK: - Private Methods
    func createSceneObjects() {
        let button:CCButton = CCButton(title:"", spriteFrame:CCSprite.spriteWithImageNamed("textGetReady.png").spriteFrame)
        button.block = {(sender:AnyObject!) -> Void in
            /* IMPLEMENTACAO */
            StateMachine.sharedInstance.changeScene(StateMachineScenes.GameScene, isFade:true)
        }
        button.position = CGPointMake(screenSize.width/2, screenSize.height/2 + 40)
        button.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(button, z: ObjectsLayers.HUD.rawValue)
        
        
        self.soundFx.block = {(sender:AnyObject!) -> Void in
            /* IMPLEMENTACAO */
            self.habilitaSounds()
        }
        self.soundFx.position = CGPointMake(screenSize.width-100, screenSize.height-30)
        self.soundFx.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(self.soundFx, z: ObjectsLayers.HUD.rawValue)
        
        self.soundBtn.block = {(sender:AnyObject!) -> Void in
            /* IMPLEMENTACAO */
            self.habilitaMusic()
        }
        self.soundBtn.position = CGPointMake(screenSize.width-270, screenSize.height-30)
        self.soundBtn.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(self.soundBtn, z: ObjectsLayers.HUD.rawValue)
        
        
        // Background da cena
        let imgBackground:CCSprite = CCSprite(imageNamed: "background_ricardo2.png")
        imgBackground.anchorPoint = CGPointMake(0.0, 0.0)
        imgBackground.position = CGPointMake(0.0, 0.0)
        self.addChild(imgBackground, z: ObjectsLayers.Background.rawValue)
        
        let creditButton:CCButton = CCButton(title: "[ Credits ]", fontName: "Verdana-Bold", fontSize: 32.0)
        creditButton.position = CGPointMake(self.contentSize.width/2.0, self.contentSize.height/2.0-100)
        creditButton.anchorPoint =  CGPointMake(0.5, 0.5)
        creditButton.zoomWhenHighlighted = false
        creditButton.block = {_ in
            StateMachine.sharedInstance.changeScene(StateMachineScenes.CreditsScene, isFade:true)
        }
        self.addChild(creditButton, z:ObjectsLayers.HUD.rawValue)
        
        let resetButton:CCButton = CCButton(title: "[ Resetar High Score ]", fontName: "Verdana-Bold", fontSize: 18.0)
        resetButton.position = CGPointMake(self.contentSize.width-120, 20)
        resetButton.anchorPoint =  CGPointMake(0.5, 0.5)
        resetButton.zoomWhenHighlighted = false
        resetButton.block = {_ in
            self.defaults.setObject(0, forKey: "hiScores")
            self.defaults.setObject(0, forKey: "score1")
            self.defaults.setObject(0, forKey: "score2")
            self.defaults.setObject(0, forKey: "score3")
            self.defaults.setObject(0, forKey: "score4")
            self.defaults.setObject(0, forKey: "score5")
            
            StateMachine.sharedInstance.changeScene(StateMachineScenes.HomeScene, isFade:true)
            
        }
        self.addChild(resetButton, z:ObjectsLayers.HUD.rawValue)
        
        
        if let p: Int = NSUserDefaults.standardUserDefaults().valueForKey("hiScores") as? Int{
            self.hs = p
            self.generateMedals()
        }
    }
    
    // MARK: - Public Methods
    
    // MARK: - Touch Delegates
    override func touchBegan(touch: UITouch!, withEvent event: UIEvent!) {
//        SoundPlayHelper.sharedInstance.playSoundWithControl(GameMusicAndSoundFx.SoundFXButtonTap)
//        StateMachine.sharedInstance.changeScene(StateMachineScenes.GameScene, isFade:true)
    }
    
    
    // MARK: - Death Cycle
    override func onExit() {
        // Chamado quando sai do director
        super.onExit()
        
        CCTextureCache.sharedTextureCache().removeAllTextures()
    }
    
    func generateMedals(){
        let highScore = CCLabelTTF(string:"High Score: \(self.hs)", fontName:"Verdana-bold", fontSize:28.0)
        highScore.color = CCColor.brownColor()
        highScore.anchorPoint = CGPointMake(0.0, 0.0)
        highScore.position = CGPointMake(50, screenSize.height/2-130)
        self.addChild(highScore, z: ObjectsLayers.Background.rawValue)
        
        if( self.hs < 100 )
        {
            let medalsLabel = CCLabelTTF(string:"Conquistes as medalhas!", fontName:"Verdana-bold", fontSize:18.0)
            medalsLabel.color = CCColor.redColor()
            medalsLabel.anchorPoint = CGPointMake(0.0, 0.0)
            medalsLabel.position = CGPointMake(50, screenSize.height/2-155)
            self.addChild(medalsLabel, z: ObjectsLayers.Background.rawValue)

        }
        else
        {
            let medalsLabel = CCLabelTTF(string:"Medalhas:", fontName:"Verdana-bold", fontSize:18.0)
            medalsLabel.color = CCColor.redColor()
            medalsLabel.anchorPoint = CGPointMake(0.0, 0.0)
            medalsLabel.position = CGPointMake(50, screenSize.height/2-155)
            self.addChild(medalsLabel, z: ObjectsLayers.Background.rawValue)
        }
        
        
        for(var i = 0; i <= self.hs; i++){
            
            var positionFixed = 50
            
            if( i == 500 )
            {
                let imgBackground:CCSprite = CCSprite(imageNamed: "flat_medal\(1).png")
                imgBackground.anchorPoint = CGPointMake(0.0, 0.0)
                imgBackground.position = CGPointMake(50, screenSize.height/2-230)
                self.addChild(imgBackground, z: ObjectsLayers.Background.rawValue)
            }
            
            if( i == 1000 )
            {
                let imgBackground:CCSprite = CCSprite(imageNamed: "flat_medal\(2).png")
                imgBackground.anchorPoint = CGPointMake(0.0, 0.0)
                imgBackground.position = CGPointMake(100, screenSize.height/2-230)
                self.addChild(imgBackground, z: ObjectsLayers.Background.rawValue)
            }
            
            if( i == 2000 )
            {
                let imgBackground:CCSprite = CCSprite(imageNamed: "flat_medal\(3).png")
                imgBackground.anchorPoint = CGPointMake(0.0, 0.0)
                imgBackground.position = CGPointMake(150, screenSize.height/2-230)
                self.addChild(imgBackground, z: ObjectsLayers.Background.rawValue)
            }
            
            if( i == 3500 )
            {
                let imgBackground:CCSprite = CCSprite(imageNamed: "flat_medal\(4).png")
                imgBackground.anchorPoint = CGPointMake(0.0, 0.0)
                imgBackground.position = CGPointMake(200, screenSize.height/2-230)
                self.addChild(imgBackground, z: ObjectsLayers.Background.rawValue)
            }
            
            if( i == 4500 )
            {
                let imgBackground:CCSprite = CCSprite(imageNamed: "flat_medal\(5).png")
                imgBackground.anchorPoint = CGPointMake(0.0, 0.0)
                imgBackground.position = CGPointMake(250, screenSize.height/2-230)
                self.addChild(imgBackground, z: ObjectsLayers.Background.rawValue)
            }
            
            
            if( i == 5800 )
            {
                let imgBackground:CCSprite = CCSprite(imageNamed: "flat_medal\(6).png")
                imgBackground.anchorPoint = CGPointMake(0.0, 0.0)
                imgBackground.position = CGPointMake(300, screenSize.height/2-230)
                self.addChild(imgBackground, z: ObjectsLayers.Background.rawValue)
            }
            
            if( i == 7000 )
            {
                let imgBackground:CCSprite = CCSprite(imageNamed: "flat_medal\(7).png")
                imgBackground.anchorPoint = CGPointMake(0.0, 0.0)
                imgBackground.position = CGPointMake(350, screenSize.height/2-230)
                self.addChild(imgBackground, z: ObjectsLayers.Background.rawValue)
            }
            
            if( i == 10000 )
            {
                let imgBackground:CCSprite = CCSprite(imageNamed: "flat_medal\(8).png")
                imgBackground.anchorPoint = CGPointMake(0.0, 0.0)
                imgBackground.position = CGPointMake(400, screenSize.height/2-230)
                self.addChild(imgBackground, z: ObjectsLayers.Background.rawValue)
            }
            
            if( i == 15000 )
            {
                let imgBackground:CCSprite = CCSprite(imageNamed: "flat_medal\(9).png")
                imgBackground.anchorPoint = CGPointMake(0.0, 0.0)
                imgBackground.position = CGPointMake(400, screenSize.height/2-230)
                self.addChild(imgBackground, z: ObjectsLayers.Background.rawValue)
            }
            
        }
        
        var positionHeight:CGFloat = 215
        for(var i:Int = 0; i <= 5; i++)
        {
            positionHeight += 20
            var positionHeiFinal = screenSize.height/2-positionHeight
            
            if let p1: Int = self.defaults.valueForKey("score\(i)") as? Int{
                let medalsLabel = CCLabelTTF(string:"Score\(i): \(p1)", fontName:"Verdana-bold", fontSize:18.0)
                medalsLabel.color = CCColor.redColor()
                medalsLabel.anchorPoint = CGPointMake(0.0, 0.0)
                medalsLabel.position = CGPointMake(50, positionHeiFinal)
//                self.addChild(medalsLabel, z: ObjectsLayers.Background.rawValue)
                
            }
            
        }
        
    }
}
