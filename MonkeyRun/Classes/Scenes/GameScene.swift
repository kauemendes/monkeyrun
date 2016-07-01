//
//  GameScene.swift
//  CocosSwift
//
//  Created by Usuário Convidado on 27/08/15.
//  Copyright (c) 2015 Flameworks. All rights reserved.
//

import Foundation
internal class GameScene : CCScene, CCPhysicsCollisionDelegate {
    
    private let screenSize:CGSize = CCDirector.sharedDirector().viewSize()
   // private var playerHero:Plane = Plane()
    private var canTap:Bool = true
    
    private var parallaxNode:CCParallaxNode = CCParallaxNode()
    private let ground1:CCSprite = CCSprite(imageNamed: "background_ricardo.jpg")
    private let ground2:CCSprite = CCSprite(imageNamed: "background_ricardo.jpg")
    
    var arrPicos: [CCSprite] = []
    var monkey:Monkey?
    var arrBananas:[Banana] = []
    
    private var canPlay:Bool = true
    private var pausado:Bool = false
    private var pontos:Int = 0
    
    private var metrosLabel:CCLabelTTF = CCLabelTTF(string:"Score: 0", fontName:"Arial", fontSize:32.0)
    private var labelPause:CCLabelTTF = CCLabelTTF(string:"Paused", fontName:"Arial", fontSize:45.0)
    
    private var hs:Int = 0
    let defaults = NSUserDefaults.standardUserDefaults()
    var physicsWorld:CCPhysicsNode = CCPhysicsNode()
    
    
    let backButton:CCButton = CCButton(title: "[QUIT]", fontName: "Verdana-Bold", fontSize: 32.0)
    let btnResume:CCButton = CCButton(title: "[RESUME]", fontName: "Arial", fontSize: 32.0)
    let btnRestart:CCButton = CCButton(title: "[RESTART]", fontName: "Arial", fontSize: 32.0)
    let btnPause:CCButton = CCButton(title: "[PAUSE]", fontName: "Arial", fontSize: 32.0)
    
    var taxaCriacao:Int = -70
    var taxaDeSubida:CGFloat = 7.0
    var taxaDeCaida:CGFloat = 9.0
    var ltapped = false
    
    
    // MARK: - Life Cycle
    override init() {
        super.init()
        self.userInteractionEnabled = true
        self.createSceneObjects()
        
    }
    
    func createSceneObjects() {
        
        
        if let p: Int = NSUserDefaults.standardUserDefaults().valueForKey("hiScores") as? Int{
            self.hs = p
        }
        
        // Insere o Chão
        self.ground1.position = CGPointMake(0.0, 0.0)
        self.ground1.anchorPoint = CGPointMake(0.0, 0.0)
        self.ground2.position = CGPointMake(0.0, 0.0)
        self.ground2.anchorPoint = CGPointMake(0.0, 0.0)
        self.parallaxNode.position = CGPointMake(0.0, 0.0)
        self.parallaxNode.addChild(self.ground1, z: 1, parallaxRatio:CGPointMake(0.5, 0.0), positionOffset:CGPointMake(0.0, 0.0))
        self.parallaxNode.addChild(self.ground2, z: 1, parallaxRatio:CGPointMake(0.5, 0.0), positionOffset:CGPointMake(self.ground1.contentSize.width, 0.0))
        addChild(parallaxNode)
        
        
        // Adiciona Botão para Pause e Play
        
        self.btnPause.position = CGPointMake(self.screenSize.width, self.screenSize.height)
        self.btnPause.anchorPoint = CGPointMake(1.0, 1.0)
        self.btnPause.block = {(sender:AnyObject!) -> Void in
            self.pausado = true
            self.labelPause.visible = true
            self.btnResume.visible = true
            self.backButton.visible = true
            self.btnRestart.visible = true
            CCDirector.sharedDirector().pause()
            self.btnPause.visible = false
        }
        addChild(btnPause, z:ObjectsLayers.HUD.rawValue)
        
        
        // Adiciona Botão para Pause e Play
        
        self.btnResume.position = CGPointMake(self.screenSize.width/2, screenSize.height/2-150)
        self.btnResume.anchorPoint = CGPointMake(0.5, 0.5)
        self.btnResume.block = {(sender:AnyObject!) -> Void in
            /* IMPLEMENTACAO */
            if (self.pausado){
                self.pausado = false
                self.labelPause.visible = false
                CCDirector.sharedDirector().resume()
                self.btnResume.visible = false
                self.backButton.visible = false
                self.btnRestart.visible = false
                self.btnPause.visible = true
            }
        }
        self.btnResume.visible = false
        addChild(self.btnResume, z:ObjectsLayers.HUD.rawValue)
        
        self.btnRestart.position = CGPointMake(self.screenSize.width/2, screenSize.height/2-100)
        self.btnRestart.anchorPoint = CGPointMake(0.5, 0.5)
        self.btnRestart.block = {(sender:AnyObject!) -> Void in
            /* IMPLEMENTACAO */
            CCDirector.sharedDirector().resume()
            StateMachine.sharedInstance.changeScene(.GameScene, isFade:true)
        }
        self.btnRestart.visible = false
        addChild(self.btnRestart, z:ObjectsLayers.HUD.rawValue)
        
        // Botão de Retorno para Tela inicial
        
        self.backButton.position = CGPointMake(screenSize.width/2, screenSize.height/2-200)
        self.backButton.anchorPoint = CGPointMake(0.5, 0.5)
        self.backButton.zoomWhenHighlighted = false
        self.backButton.block = {_ in
            CCDirector.sharedDirector().resume()
            StateMachine.sharedInstance.changeScene(.HomeScene, isFade:true)
        }
        self.backButton.visible = false
        addChild(self.backButton, z:ObjectsLayers.HUD.rawValue)
        
        
        
        // Pontos Metros
        self.metrosLabel.position = CGPointMake(0.0, self.screenSize.height)
        self.metrosLabel.anchorPoint = CGPointMake(0.0, 1.0)
        addChild(self.metrosLabel)
        
        // Pause
        labelPause.position = CGPointMake(self.screenSize.width/2, self.screenSize.height/2)
        labelPause.anchorPoint = CGPointMake(0.5, 0.5)
        labelPause.visible = false
        addChild(labelPause)
        
        
        var positionX = CGPointMake(100.0, 384.0)
        self.monkey = Monkey(event: "updateScore", target: self)
        self.monkey!.physicsBody = CCPhysicsBody(rect: CGRectMake(3, 10, self.monkey!.contentSize.width-6, self.monkey!.contentSize.height-14), cornerRadius: 0.0)
        self.monkey!.physicsBody.type = CCPhysicsBodyType.Kinematic
        self.monkey!.physicsBody.mass = 240.0

        self.monkey!.physicsBody.collisionType = "monkey"
        self.monkey!.physicsBody.collisionCategories = ["monkey"]
        self.monkey!.physicsBody.collisionMask = ["obstacles", "banana"]
        
        self.monkey!.position = positionX
        self.monkey!.name = "monkey"
        
        physicsWorld.collisionDelegate = self // Protocolo: CCPhysicsCollisionDelegate
        physicsWorld.addChild(self.monkey!, z: 2)
        
        
        addChild(physicsWorld)
//        physicsWorld.debugDraw = true
        
        self.changePoints()
        self.generateObstacles()
        self.generateBananas()
    
    }
    
    func changePoints(){
        pontos++
        self.metrosLabel.string = "Score: \(pontos)"
        
        if (pontos > 10){
            self.taxaCriacao = -90
        } else if (pontos > 20){
            self.taxaCriacao = -110
        } else if (pontos > 30){
            self.taxaCriacao = -130
        } else if (pontos > 40){
            self.taxaCriacao = -150
        } else if (pontos > 50){
            self.taxaCriacao = -170
        }
        
        let delayAction:CCActionSequence = CCActionSequence(
            one:(CCActionDelay.actionWithDuration(0.5) as! CCActionFiniteTime),
            two:(CCActionCallBlock.actionWithBlock({_ in self.changePoints()})) as! CCActionFiniteTime)
        self.runAction(delayAction)
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, monkey nodeA: CCNode!, obstacles nodeB: CCNode!) {
        self.monkey!.stopAllSpriteActions()
        self.gameOver()
        
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, monkey aMonkey: Monkey!, banana bBanana: Banana!) {
        self.somaMetros()
        SoundPlayHelper.sharedInstance.playSoundWithControl(.coinSound)
        bBanana.removeFromParentAndCleanup(true)
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, banana bBanana: Monkey!, obstacles bObstacles: Banana!) {
        var max:UInt32 = 768 - UInt32(bBanana.contentSize.height)
        var taxa:CGFloat = bBanana.contentSize.height/2 + CGFloat(Int(arc4random_uniform(max)))
        bBanana.position = CGPointMake(self.screenSize.width + 70, taxa)
    }
    
    override func onEnter() {
        // Chamado apos o init quando entra no director
        super.onEnter()
    }
    
    // MARK: - Death Cycle
    override func onExit() {
        // Chamado quando sai do director
        super.onExit()
    }
    
    deinit {
        // Chamado no momento de desalocacao
        CCTextureCache.sharedTextureCache().removeAllTextures()
    }
    
    func gameOver(){
        self.canPlay = false
        self.canTap = false
       // self.playerHero.canColide = false
        
        self.stopAllActions()
        SoundPlayHelper.sharedInstance.stopAllSounds()
        SoundPlayHelper.sharedInstance.playSoundWithControl(.SoundFaustaoErrou)
        
        
        self.btnPause.visible = false
        
        // Percorre e cancela toda movimentacao dos picos
        for peak:CCSprite in self.arrPicos {
            peak.stopAllActions()
        }
        
        // Percorre e cancela toda movimentacao dos picos
        for banana:Banana in self.arrBananas {
            banana.stopAllActions()
        }
        
        self.monkey!.stopAllActions()
        
        if (self.pontos > self.hs){
            self.defaults.setObject(self.pontos, forKey: "hiScores")
            self.defaults.synchronize()
        }
        self.updateHighScores(self.pontos, apercorrer: 5)
        self.pontos = 0;
        
        let label:CCSprite = CCSprite(imageNamed: "textGameOver.png")
        label.position = CGPointMake(self.screenSize.width/2, self.screenSize.height/2)
        label.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(label, z: 4)
        CCDirector.sharedDirector().pause()
        
    }
    
    func somaMetros(){
        
        var taxaDePonto:Int = 0
        
        if (self.pontos > 200){
            taxaDePonto = 10
        } else if (self.pontos > 1000){
            taxaDePonto = 20
        } else if (self.pontos > 1500){
            taxaDePonto = 40
        } else if (self.pontos > 2000){
            taxaDePonto = 80
        } else if (self.pontos > 3000){
            taxaDePonto = 160
        } else if (self.pontos > 6000){
            taxaDePonto = 320
        } else if (self.pontos > 12000){
            taxaDePonto = 640
        } else if (self.pontos > 24000){
            taxaDePonto = 1280
        } else {
            taxaDePonto = 2
        }
        
        self.pontos = self.pontos+taxaDePonto
        
        self.metrosLabel.string = "Score: \(pontos)"
        
        let delayAction:CCActionSequence = CCActionSequence(
            one:(CCActionDelay.actionWithDuration(0.5) as! CCActionFiniteTime),
            two:(CCActionCallBlock.actionWithBlock({_ in self.changePoints()})) as! CCActionFiniteTime)
        self.runAction(delayAction)
    }
    
    
    func generateObstacles(){
        if (self.canPlay) {
            let enemySpeed:CCTime = 3.0 // De 5s a 10s
            let obstacles:Obstacles = Obstacles(imageNamed: "elementExplosive_\(arc4random_uniform(24)+1).png")
            var max:UInt32 = 768 - UInt32(obstacles.contentSize.height)
            var taxa:CGFloat = obstacles.contentSize.height/2 + CGFloat(Int(arc4random_uniform(max)))
            obstacles.anchorPoint = CGPointMake(0.5, 0.5)
            obstacles.position = CGPointMake(self.screenSize.width + 70, taxa)
//            self.arrPicos.append(obstacles)
            self.physicsWorld.addChild(obstacles, z: ObjectsLayers.Foes.rawValue)
            
            obstacles.runAction(CCActionSequence.actionOne(CCActionMoveTo.actionWithDuration(enemySpeed, position: CGPointMake(CGFloat(self.taxaCriacao), obstacles.position.y)) as! CCActionFiniteTime, two:CCActionCallBlock.actionWithBlock({_ in
//                self.arrPicos.removeAtIndex(find(self.arrPicos, obstacles)!)
                obstacles.removeFromParentAndCleanup(true)
            
            }) as! CCActionFiniteTime) as! CCAction)
        
            var delay:CCTime = (CCTime(arc4random_uniform(101)) / 100.0) + 0.6 // De 0.5s a 1.5s
            DelayHelper.sharedInstance.callFunc("generateObstacles", onTarget: self, withDelay: delay)
        }
    }
    
    func generateBananas(){
        if (self.canPlay) {
            let enemySpeed:CCTime = 3.0 // De 5s a 10s
            
            let banana:Banana = Banana()
            var max:UInt32 = 768 - UInt32(banana.contentSize.height)
            var taxa:CGFloat = banana.contentSize.height/2 + CGFloat(Int(arc4random_uniform(max)))
            
            banana.anchorPoint = CGPointMake(0.5, 0.5)
            banana.position = CGPointMake(self.screenSize.width + 70, taxa)
            self.physicsWorld.addChild(banana, z: ObjectsLayers.Foes.rawValue)
            
            banana.runAction(CCActionSequence.actionOne(CCActionMoveTo.actionWithDuration(enemySpeed, position: CGPointMake(CGFloat(self.taxaCriacao), banana.position.y)) as! CCActionFiniteTime, two:CCActionCallBlock.actionWithBlock({_ in
                
                banana.removeFromParentAndCleanup(true)
                
            }) as! CCActionFiniteTime) as! CCAction)
            
            var delay:CCTime = (CCTime(arc4random_uniform(101)) / 100.0) + 3.0 // De 0.5s a 1.5s
            DelayHelper.sharedInstance.callFunc("generateBananas", onTarget: self, withDelay: delay)
        }
    }
    
    override func update(delta: CCTime) {
        
        if (self.canPlay) {
            
            if( self.ltapped )
            {
                self.monkey!.position = CGPointMake(self.monkey!.position.x, self.monkey!.position.y+self.taxaDeSubida)
            }
            else
            {
                self.monkey!.position = CGPointMake(self.monkey!.position.x, self.monkey!.position.y-self.taxaDeCaida)
            }
            
        
            var backgroundScrollVel:CGPoint = CGPointMake(-400, 0)
            
            // Soma os pontos (posicao atual + (velocidade * delta))
            let pt1:CGFloat = backgroundScrollVel.x * CGFloat(delta)
            let multiDelta:CGPoint = CGPointMake(pt1, backgroundScrollVel.y)
            self.parallaxNode.position = CGPointMake(self.parallaxNode.position.x + multiDelta.x, 0.0)
            
            // Verifica se terminou uma imagem para continuar o ciclo
            if (self.parallaxNode.convertToWorldSpace(self.ground1.position).x < -self.ground1.contentSize.width) {
                self.parallaxNode.position = CGPointMake(0.0, 0.0)
            }
            
        
//            //teste de GAME OVER
//            for pico:CCSprite in self.arrPicos {
//                if (self.playerHero.canColide) {
//                    if (CGRectIntersectsRect(self.playerHero.boundingBox(), pico.boundingBox())) {
//                        
//                        self.gameOver()
//                    }
//                }
//            }
        
            if (self.monkey!.position.y <= 20 || self.monkey!.position.y > self.screenSize.height - 20) {
                self.gameOver()
            }
            
        } //fecha canplay
    }
    
    override func touchCancelled(touch: UITouch!, withEvent event: UIEvent!) {
        self.ltapped = false
    }
    
    override func touchEnded(touch: UITouch!, withEvent event: UIEvent!) {
        self.ltapped = false
    }
    
    override func touchBegan(touch: UITouch!, withEvent event: UIEvent!) {
        if (self.canTap && self.canPlay) {
            
            self.ltapped = true
            
            // Mostra subindo
            let a1:[CCAction] = [CCActionRotateTo.actionWithDuration(0.3, angle: -10) as! CCAction,
                CCActionCallBlock.actionWithBlock({_ in
                    
                }) as! CCAction]
            
            self.monkey!.runAction(CCActionSequence.actionWithArray(a1) as! CCAction)
            
            
            // Mostra Descendo
            let a2:[CCAction] = [CCActionRotateTo.actionWithDuration(0.3, angle: 10) as! CCAction,
                CCActionCallBlock.actionWithBlock({_ in
                    
                }) as! CCAction]
            
            self.monkey!.runAction(CCActionSequence.actionWithArray(a2) as! CCAction)
            
            /*
            let arrActions:[CCAction] = [CCActionMoveBy.actionWithDuration(0.2, position: CGPointMake(0.0, 80.0)) as! CCAction, CCActionCallBlock actionWithBlock({_ in
                    self.canTap = true
                    let a2:[CCAction] = [CCActionRotateTo.actionWithDuration(0.3, angle: 10) as! CCAction,
                        CCActionCallBlock.actionWithBlock({_ in
                            
                        }) as! CCAction]
                    self.monkey!.runAction(CCActionSequence.actionWithArray(a2) as! CCAction)
                }) as! CCAction]
            
            self.monkey!.runAction(CCActionSequence.actionWithArray(arrActions) as! CCAction)
            */
            
            
        } else {
            CCDirector.sharedDirector().resume()
            self.canTap = true;
            self.canPlay = true;
            StateMachine.sharedInstance.changeScene(.GameScene, isFade: true)
        }
    }
    
    func updateHighScores(actualPoint:Int, apercorrer:Int){
       
        var valor:Int = actualPoint
        for(var i:Int = apercorrer; i <= 5; i++)
        {
            if var pontos1: Int = self.defaults.valueForKey("score\(i)") as? Int{
                println("score\(i) -> \(pontos)")
                println("pontos\(i) -> \(valor)")
                if( valor >= pontos )
                {
                    println("Nao pode entrar essa porra")
                    self.defaults.setObject(valor, forKey: "score\(i)")
                    self.defaults.synchronize()
                    
                    for( var j = 1 ; j <= 5; j++ )
                    {
                        if var pontos2: Int = self.defaults.valueForKey("score\(j)") as? Int{
                            
                            if( pontos1 >= pontos2 ){
                                
                            }
                            self.defaults.setObject(pontos1, forKey: "score\(j)")
                            self.defaults.synchronize()
                        }
                        
                        
                    }
                    
                    
                    
                    
                    break
                }
                else if  ( pontos > 0 ){
                    break
                }
                else
                {
                    break
                }
            }
            
        }
        
    }

}
