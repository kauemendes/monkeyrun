//
//  Barata.swift
//  CocosSwift
//
//  Created by Usuário Convidado on 29/08/15.
//  Copyright (c) 2015 Flameworks. All rights reserved.
//

import UIKit

class Banana: CCNode {
    
    internal var eventSelector:Selector?
    internal var targetID:AnyObject?
    private var alive:Bool = true
    private var spriteBananas:CCSprite?
    
    convenience init(event:Selector, target:AnyObject) {
        self.init()
        
        self.eventSelector = event
        self.targetID = target
    }
    
    
    
    
    override init() {
        super.init()
        self.userInteractionEnabled = true
        
        CCSpriteFrameCache.sharedSpriteFrameCache().addSpriteFramesWithFile("banana.plist", textureFilename:"banana.png")
        let ccFrameName:CCSpriteFrame = CCSpriteFrame.frameWithImageNamed("banana1.png") as! CCSpriteFrame
        self.spriteBananas = CCSprite.spriteWithSpriteFrame(ccFrameName) as? CCSprite
        
        self.spriteBananas = self.gerarAnimacaoSpriteWithName("banana", aQtdFrames: 16)
        self.contentSize = spriteBananas!.boundingBox().size
        
        self.spriteBananas!.position = CGPointMake(0,0)
        self.spriteBananas!.anchorPoint = CGPointMake(0,0)
        
        self.physicsBody = CCPhysicsBody(rect: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height), cornerRadius: 0.0)
        self.physicsBody.type = CCPhysicsBodyType.Kinematic
        self.physicsBody.friction = 1.0
        self.physicsBody.elasticity = 0.1
        self.physicsBody.mass = 100.0
        self.physicsBody.density = 100.0
        self.physicsBody.collisionType = "banana"
        self.physicsBody.collisionCategories = ["banana"]
        self.physicsBody.collisionMask = ["monkey","obstacles"]
        
        
        self.addChild(spriteBananas, z:5)
        
    }
    
    internal func moveMe() {
        let speed:CGFloat = CGFloat(arc4random_uniform(4) + 2)
        self.runAction(CCActionSequence.actionOne(CCActionMoveTo.actionWithDuration(CCTime(speed), position: CGPointMake(self.position.x, self.height() * -2)) as! CCActionFiniteTime,
            two: CCActionCallBlock.actionWithBlock({ _ in
                self.stopAllSpriteActions()
                self.removeFromParentAndCleanup(true)
            }) as! CCActionFiniteTime)
            as! CCAction)
    }
    
    internal func stopAllSpriteActions() {
        self.spriteBananas!.stopAllActions()
        self.stopAllActions()
    }
    
    internal func width() -> CGFloat {
        return self.spriteBananas!.boundingBox().size.width
    }
    
    internal func height() -> CGFloat {
        return self.spriteBananas!.boundingBox().size.height
    }
    
    
    override func onEnter() {
        // Chamado apos o init quando entra no director
        super.onEnter()
    }
    
    // MARK: - Death Cycle
    deinit {
        // Chamado no momento de desalocacao
    }
    
    func gerarAnimacaoSpriteWithName(aSpriteName:String, aQtdFrames:Int) -> CCSprite {
        // Carrega os frames da animacao dentro do arquivo passado dada a quantidade de frames
        var animFrames:Array<CCSpriteFrame> = Array()
        for (var i = 1; i <= aQtdFrames; i++) {
            let name:String = "\(aSpriteName)\(i).png"
            animFrames.append(CCSpriteFrameCache.sharedSpriteFrameCache().spriteFrameByName(name))
        }
        // Cria a animacao dos frames montados
        let animation:CCAnimation = CCAnimation(spriteFrames: animFrames, delay: 0.1)
        // Cria a acao com a animacao dos frames
        let animationAction:CCActionAnimate = CCActionAnimate(animation: animation)
        // Monta a repeticao eterna da animacao
        let actionForever:CCActionRepeatForever = CCActionRepeatForever(action: animationAction)
        // Monta o sprite com o primeiro quadro
        var spriteRet:CCSprite = CCSprite(imageNamed: "\(aSpriteName)\(1).png")
        // Executa a acao da animacao
        spriteRet.runAction(actionForever)
        
        // Retorna o sprite para controle na classe
        return spriteRet
    }
    
    override func touchBegan(touch: UITouch!, withEvent event: UIEvent!) {
        // Caso a cena principal esteja em gameplayer e nao seja possivel jogar impede o tap
        //        if (!(self.targetID as! GameScene).canPlay) {
        //            return
        //        }
        
        //        // Caso jah tenha recebido o tap, nao permite outro sobre o mesmo inseto
        //        if (!self.alive) {
        //            return
        //        }
        //
        //        self.alive = false
        //
        //        // Barulho da barata morrendo
        //        OALSimpleAudio.sharedInstance().playEffect("FXSquitch.mp3")
        //
        //        self.stopAllSpriteActions()
        //
        //        // Apresenta o blood e oculta a barata
        //        self.bloodSpill.opacity = 255.0
        //        self.spriteBananas?.opacity = 0.0
        //        self.bloodSpill.runAction(CCActionSequence.actionOne(CCActionFadeOut.actionWithDuration(1.2) as! CCActionFiniteTime, two: CCActionCallBlock.actionWithBlock({ _ in
        //            self.removeFromParentAndCleanup(true)
        //        }) as! CCActionFiniteTime) as! CCAction)
        
        // Mata a barata e executa o evento informado
        //DelayHelper.sharedInstance.callFunc(self.eventSelector!, onTarget: self.targetID!, withDelay: 0.0)
        
        //        println("entrou no idf")
        //        let a1:[CCAction] = [CCActionRotateTo.actionWithDuration(0.3, angle: -20) as! CCAction,
        //            CCActionCallBlock.actionWithBlock({_ in
        //
        //            }) as! CCAction]
        //        self.spriteBananas!.runAction(CCActionSequence.actionWithArray(a1) as! CCAction)
        //
        //        let arrActions:[CCAction] = [CCActionMoveBy.actionWithDuration(0.2, position: CGPointMake(0.0, 140.0)) as! CCAction,
        //            CCActionCallBlock.actionWithBlock({_ in
        //                //self.canTap = true
        //                let a2:[CCAction] = [CCActionRotateTo.actionWithDuration(0.3, angle: 20) as! CCAction,
        //                    CCActionCallBlock.actionWithBlock({_ in
        //
        //                    }) as! CCAction]
        //                self.spriteBananas!.runAction(CCActionSequence.actionWithArray(a2) as! CCAction)
        //            }) as! CCAction]
        //        self.spriteBananas!.runAction(CCActionSequence.actionWithArray(arrActions) as! CCAction)
        
    }
    
}
