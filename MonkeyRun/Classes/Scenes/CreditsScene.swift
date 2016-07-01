//
//  HomeScene.swift
//  CocosSwift
//
//  Created by Thales Toniolo on 10/09/14.
//  Copyright (c) 2014 Flameworks. All rights reserved.
//
// MARK: - Class Definition
class CreditsScene : CCScene {
    // MARK: - Public Objects
    
    // MARK: - Private Objects
    let directionLabel1:CCLabelTTF = CCLabelTTF(string: "Direção", fontName: "Verdana-Bold", fontSize: 42.0)
    let directionLabel2:CCLabelTTF = CCLabelTTF(string: "Kauê Mendes / Eder Almeida", fontName: "Verdana-Bold", fontSize: 22.0)
    let production1:CCLabelTTF = CCLabelTTF(string: "Produção", fontName: "Verdana-Bold", fontSize: 42.0)
    let production2:CCLabelTTF = CCLabelTTF(string: "Thatyane Pontes / Ricardo Ogliari", fontName: "Verdana-Bold", fontSize: 22.0)
    let desenvTitle:CCLabelTTF = CCLabelTTF(string: "Desenvolvimento", fontName: "Verdana-Bold", fontSize: 42.0)
    let dev1:CCLabelTTF = CCLabelTTF(string: "Eder Almeida", fontName: "Verdana-Bold", fontSize: 22.0)
    let dev2:CCLabelTTF = CCLabelTTF(string: "Kauê Mendes", fontName: "Verdana-Bold", fontSize: 22.0)
    let dev3:CCLabelTTF = CCLabelTTF(string: "Thatyane Pontes", fontName: "Verdana-Bold", fontSize: 22.0)
    let dev4:CCLabelTTF = CCLabelTTF(string: "Ricardo Ogliari", fontName: "Verdana-Bold", fontSize: 22.0)
    let specialThk:CCLabelTTF = CCLabelTTF(string: "Agradecimento Especial", fontName: "Verdana-Bold", fontSize: 42.0)
    let specialKenny:CCLabelTTF = CCLabelTTF(string: "www.kenney.nl", fontName: "Verdana-Bold", fontSize: 22.0)
    var counter:Int = 0;
    
    // MARK: - Life Cycle
    override init() {
        super.init()
        
        
        self.userInteractionEnabled = true
        
        // Configura os objetos na tela
        self.createSceneObjects()
    }
    
    override func onEnter() {
        // Chamado apos o init quando entra no director
        super.onEnter()
    }
    
    // MARK: - Private Methods
    func createSceneObjects() {
        
        // Back button
        let backButton:CCButton = CCButton(title: "[Back]", fontName: "Verdana-Bold", fontSize: 20.0)
        backButton.position = CGPointMake(screenSize.width - 10, screenSize.height)
        backButton.anchorPoint = CGPointMake(1.0, 1.0)
        backButton.zoomWhenHighlighted = false
        backButton.block = {_ in
            StateMachine.sharedInstance.changeScene(StateMachineScenes.HomeScene, isFade:true)
        }
        self.addChild(backButton, z:ObjectsLayers.HUD.rawValue)
        
        
        
        directionLabel1.fontColor = CCColor.whiteColor()
        directionLabel1.position = CGPointMake(self.contentSize.width / 2.0, self.contentSize.height / 2.0)
        directionLabel1.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(directionLabel1, z: ObjectsLayers.Background.rawValue)
        
        
        directionLabel2.fontColor = CCColor.whiteColor()
        directionLabel2.position = CGPointMake(self.contentSize.width / 2.0, self.contentSize.height / 2.0 - 50)
        directionLabel2.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(directionLabel2, z: ObjectsLayers.Background.rawValue)
        
        
        
        production1.fontColor = CCColor.whiteColor()
        production1.position = CGPointMake(self.contentSize.width/2.0, self.contentSize.height / 2.0)
        production1.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(production1, z: ObjectsLayers.Background.rawValue)
        
        
        production2.fontColor = CCColor.whiteColor()
        production2.position = CGPointMake(self.contentSize.width / 2.0, self.contentSize.height / 2.0 - 50)
        production2.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(production2, z: ObjectsLayers.Background.rawValue)
        
        
        desenvTitle.fontColor = CCColor.whiteColor()
        desenvTitle.position = CGPointMake(self.contentSize.width/2.0, self.contentSize.height / 2.0 + 110)
        desenvTitle.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(desenvTitle, z: ObjectsLayers.Background.rawValue)
        
        
        dev1.fontColor = CCColor.whiteColor()
        dev1.position = CGPointMake(self.contentSize.width / 2.0, self.contentSize.height / 2.0 - 60)
        dev1.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(dev1, z: ObjectsLayers.Background.rawValue)
        
        
        dev2.fontColor = CCColor.whiteColor()
        dev2.position = CGPointMake(self.contentSize.width / 2.0, self.contentSize.height / 2.0 - 20)
        dev2.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(dev2, z: ObjectsLayers.Background.rawValue)
        
        
        dev3.fontColor = CCColor.whiteColor()
        dev3.position = CGPointMake(self.contentSize.width / 2.0, self.contentSize.height / 2.0 + 20)
        dev3.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(dev3, z: ObjectsLayers.Background.rawValue)
        
        
        dev4.fontColor = CCColor.whiteColor()
        dev4.position = CGPointMake(self.contentSize.width / 2.0, self.contentSize.height / 2.0 + 60)
        dev4.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(dev4, z: ObjectsLayers.Background.rawValue)
        
        
        specialThk.fontColor = CCColor.whiteColor()
        specialThk.position = CGPointMake(self.contentSize.width/2.0, self.contentSize.height / 2.0)
        specialThk.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(specialThk, z: ObjectsLayers.Background.rawValue)
        
        
        specialKenny.fontColor = CCColor.whiteColor()
        specialKenny.position = CGPointMake(self.contentSize.width / 2.0, self.contentSize.height / 2.0 - 40)
        specialKenny.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(specialKenny, z: ObjectsLayers.Background.rawValue)
        
        
        directionLabel1.visible = false
        directionLabel2.visible = false
        
        production1.visible = false
        production2.visible = false
        
        desenvTitle.visible = false
        dev1.visible = false
        dev2.visible = false
        dev3.visible = false
        dev4.visible = false
        
        specialThk.visible = false
        specialKenny.visible = false
     
        showEverything()
    }
    
    func showEverything(){
        
            println(self.counter)
        switch (self.counter) {
        case 0:
            self.showDirection()
            var delay:CCTime = 2 // De 0.5s a 1.5s
            DelayHelper.sharedInstance.callFunc("hideDirection", onTarget: self, withDelay: delay)
            
        case 1:
            self.showProduction()
            var delay:CCTime = 2 // De 0.5s a 1.5s
            DelayHelper.sharedInstance.callFunc("hideProduction", onTarget: self, withDelay: delay)
            
        case 2:
            self.showDesenvolvedores()
            var delay:CCTime = 2 // De 0.5s a 1.5s
            DelayHelper.sharedInstance.callFunc("hideDesenvolvedores", onTarget: self, withDelay: delay)
            
        case 3:
            self.showSpecial()
            var delay:CCTime = 2 // De 0.5s a 1.5s
            DelayHelper.sharedInstance.callFunc("hideSpecial", onTarget: self, withDelay: delay)
            
        default:
            break
            
        }
        self.counter++
        
        if( self.counter > 3 )
        {
            self.counter = 0
        }
        
        
        var delay:CCTime = 2.1 // De 0.5s a 1.5s
        DelayHelper.sharedInstance.callFunc("showEverything", onTarget: self, withDelay: delay)
    }
    
    func showDirection(){
        directionLabel1.visible = true
        directionLabel2.visible = true
    }
    
    func hideDirection(){
        directionLabel1.visible = false
        directionLabel2.visible = false
    }
    
    func showProduction(){
        production1.visible = true
        production2.visible = true
    }
    
    func hideProduction(){
        production1.visible = false
        production2.visible = false
    }
    
    func showDesenvolvedores(){
        desenvTitle.visible = true
        dev1.visible = true
        dev2.visible = true
        dev3.visible = true
        dev4.visible = true
    }
    
    func hideDesenvolvedores(){
        desenvTitle.visible = false
        dev1.visible = false
        dev2.visible = false
        dev3.visible = false
        dev4.visible = false
    }
    
    func showSpecial(){
        specialThk.visible = true
        specialKenny.visible = true
    }
    
    func hideSpecial(){
        specialThk.visible = false
        specialKenny.visible = false
    }
    
    // MARK: - Public Methods
    
    // MARK: - Touch Delegates
    override func touchBegan(touch: UITouch!, withEvent event: UIEvent!) {
        //SoundPlayHelper.sharedInstance.playSoundWithControl(GameMusicAndSoundFx.SoundFXButtonTap)
        StateMachine.sharedInstance.changeScene(StateMachineScenes.GameScene, isFade:true)
    }
    
    // MARK: - Death Cycle
    override func onExit() {
        // Chamado quando sai do director
        super.onExit()
        
        CCTextureCache.sharedTextureCache().removeAllTextures()
    }
}
