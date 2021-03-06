#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){	

    ofTrueTypeFont::setGlobalDpi(72);
    
    // Colors
    labanColor[0] = ofColor(13, 20, 13);
    labanColor[1] = ofColor(16, 34, 38);
    labanColor[2] = ofColor(104, 140, 137);
    labanColor[3] = ofColor(129, 191, 181);
    labanColor[4] = ofColor(73, 73, 73);
    labanColor[5] = ofColor(241, 242, 242);
    
    // GUI
    string imagePath;
    for(int i=0; i<2; i++){
        imagePath = "imagesGUI/Load_" + ofToString(i+1) + ".png";
        loadScreen[i].load(imagePath);
        imagePath = "imagesGUI/Settings_" + ofToString(i+1) + ".png";
        configScreen[i].load(imagePath);
        imagePath = "imagesGUI/Background_" + ofToString(i+1) + ".png";
        bckgrd[i].load(imagePath);
        for(int j=0; j<7; j++){
            if( j==0 && demoActive ){
                imagePath = "imagesGUI/0" + ofToString(j) + "_" + ofToString(i+1) + "_Demo.png";
            } else {
                imagePath = "imagesGUI/0" + ofToString(j) + "_" + ofToString(i+1) + ".png";
            }
            guiScreen[i][j].load(imagePath);
        }
        loadButtonPressed[i][0] = false;
        loadButtonPressed[i][1] = false;
        loadConfigScreen[i] = false;
        bigButtonPressed[i] = false;
        emailButtonPressed[i] = false;
        emailPopUpBox[i] = false;
        emailOkButtonPressed[i] = false;
        alphaGuiImgs[i] = 255;
        alphaDecreasing[i] = true;
        testButtonPressed[i] = false;
        testSent[i] = false;
        testConfirmed[i] = false;
        demoButtonPressed[i] = false;
    }
    alphaChangeAmount = 5;
    screenPos[0] = ofPoint(0, 0);
    screenPos[1] = ofPoint(1024, 0);
    prompt40.load("fonts/Prompt-Regular.ttf", 40, true, true);
    prompt20.load("fonts/Prompt-Bold.ttf", 20, true, true);
    promptExtra70.load("fonts/Prompt-ExtraBold.ttf", 70, true, true);
    loadRectSize = 210;
    loadRect[0][0] = ofPoint(250, 1155);
    loadRect[0][1] = ofPoint(560, loadRect[0][0].y);
    loadRect[1][0] = ofPoint(1024 + loadRect[0][0].x, loadRect[0][0].y);
    loadRect[1][1] = ofPoint(1024 + loadRect[0][1].x, loadRect[0][0].y);
    loadInfoTextPos[0][0] = ofPoint(350, 1050);
    loadInfoTextPos[0][1] = ofPoint(loadInfoTextPos[0][0].x, 1100);
    loadInfoTextPos[1][0] = ofPoint(1024 + loadInfoTextPos[0][0].x, loadInfoTextPos[0][0].y);
    loadInfoTextPos[1][1] = ofPoint(1024 + loadInfoTextPos[0][0].x, loadInfoTextPos[0][1].y);
    loadButtonTextPos[0][0] = ofPoint(275, 1270);
    loadButtonTextPos[0][1] = ofPoint(635, loadButtonTextPos[0][0].y);
    loadButtonTextPos[1][0] = ofPoint(1024 + loadButtonTextPos[0][0].x, loadButtonTextPos[0][0].y);
    loadButtonTextPos[1][1] = ofPoint(1024 + loadButtonTextPos[0][1].x, loadButtonTextPos[0][0].y);
    testButtonSize = ofVec2f(193, 105);
    testButtonPos[0] = ofPoint(422, 791);
    testButtonPos[1] = ofPoint(testButtonPos[0].x + 1024 - 12, testButtonPos[0].y + 1);
    configRectSize = 550;
    configButtonTextPos[0] = ofPoint(450, 1270);
    configButtonTextPos[1] = ofPoint(1024 + configButtonTextPos[0].x, configButtonTextPos[0].y);
    demoButtonPos[0] = ofPoint(428, 835);
    demoButtonPos[1] = ofPoint(428 + 1024, 835);
    demoButtonSize = ofVec2f(180, 67);
    demoActive = false;
    playAgainRect[0] = ofPoint(100, 1150);
    playAgainRect[1] = ofPoint(playAgainRect[0].x, playAgainRect[0].y);
    playAgainRectSize.x = 800;
    playAgainRectSize.y = 215;
    emailRectSize.x = 134;
    emailRectSize.y = 134;
    emailRect[0] = ofPoint(441, 935);
    emailRect[1] = ofPoint(emailRect[0].x + 1024, emailRect[0].y);
    emailInputRectSize.x = 800;
    emailInputRectSize.y = 300;
    emailInputRect[0] = ofPoint(120, ofGetHeight()/2 - 400);
    emailInputRect[1] = ofPoint(emailInputRect[0].x + 1024, emailInputRect[0].y);
    emailOkRectSize.x = 100;
    emailOkRectSize.y = 60;
    emailOkRect[0] = ofPoint(emailInputRect[0].x + emailInputRectSize.x/2 - 50, emailInputRect[0].y + 200);
    emailOkRect[1] = ofPoint(emailInputRect[1].x + emailInputRectSize.x/2 - 50, emailInputRect[1].y + 200);

    // Xml
    string message;
    if( xmlSettings.load(ofxiPhoneGetDocumentsDirectory() + "xml/labanIPs.xml") ){
        message = "labanIPs.xml loaded from documents folder!";
    }else if( xmlSettings.load("xml/labanIPs.xml") ){
        message = "labanIPs.xml loaded from data folder!";
    }else{
        message = "unable to load labanIPs.xml check data/ folder";
    }
    
    if( xmlSettings.exists("//host_1") ){
        HOST[0] = xmlSettings.getValue<string>("//host_1");
    } else {
        HOST[0] = "0.0.0.0";
    }
    if( xmlSettings.exists("//port_1") ){
        PORT[0] = xmlSettings.getValue<int>("//port_1");
    } else {
        PORT[0] = 12345;
    }
    if( xmlSettings.exists("//host_2") ){
        HOST[1] = xmlSettings.getValue<string>("//host_2");
    } else {
        HOST[1] = "0.0.0.1";
    }
    if( xmlSettings.exists("//port_2") ){
        PORT[1] = xmlSettings.getValue<int>("//port_2");
    } else {
        PORT[1] = 23456;
    }
    
    sender[0].setup(HOST[0], PORT[0]);
    sender[1].setup(HOST[1], PORT[1]);
    receiver.setup(PORT_IN);
    
    state[0] = 0;
    state[1] = 0;
    
    keybdPos[0][0] = ofPoint(180, 200);
    keybdPos[0][1] = ofPoint(180, 300);
    keybdPos[1][0] = ofPoint(700, 200);
    keybdPos[1][1] = ofPoint(700, 300);
    emailInput[0] = new ofxiOSKeyboard(105, 220, 290, 32);
    emailInput[1] = new ofxiOSKeyboard(625, 220, 290, 32);
    for( int i=0; i<2; i++ ){
        for( int j=0; j<2; j++ ){
            keybdInput[i][j] = new ofxiOSKeyboard(keybdPos[i][j].x, keybdPos[i][j].y, 150, 32);
            keybdInput[i][j]->setVisible(false);
            keybdInput[i][j]->setBgColor(104, 140, 137, 255);
            keybdInput[i][j]->setFontColor(241, 242, 242, 255);
            keybdInput[i][j]->setFontSize(20);
            if( j==0 ){
                keybdInput[i][j]->setText(HOST[i]);
            } else {
                keybdInput[i][j]->setText(ofToString(PORT[i]));
            }
        }
        emailInput[i]->setVisible(false);
        emailInput[i]->setBgColor(104, 140, 137, 255);
        emailInput[i]->setFontColor(241, 242, 242, 255);
        emailInput[i]->setFontSize(15);
    }
    
    iHaveIps = false;
    state4_error = false;
}

//--------------------------------------------------------------
void ofApp::update(){
    if( !iHaveIps ){
        for(int i=0; i<2; i++){
            if( !iHaveIp[i] && !loadConfigScreen[i] ){
                for( int j=0; j<2; j++ ){
                    if( isTouching &&
                       ofRectangle(loadRect[i][j].x, loadRect[i][j].y, loadRectSize, loadRectSize).inside(touchPos.x, touchPos.y) ){
                        loadButtonPressed[i][j] = true;
                    } else if( !isTouching && prevIsTouching &&
                              ofRectangle(loadRect[i][j].x, loadRect[i][j].y, loadRectSize, loadRectSize).inside(touchPos.x, touchPos.y) ){
                        loadButtonPressed[i][j] = false;
                        if( j== 0 ){
                            loadConfigScreen[i] = true;
                            keybdInput[i][0]->setVisible(true);
                            keybdInput[i][1]->setVisible(true);
                        } else if( j==1 ){
                            sendTestMessage(i);
                            iHaveIp[i] = true;
                        }
                    } else {
                        loadButtonPressed[i][j] = false;
                    }
                }
                if( isTouching &&
                   ofRectangle(testButtonPos[i].x, testButtonPos[i].y, testButtonSize.x, testButtonSize.y).inside(touchPos.x, touchPos.y) ){
                    testButtonPressed[i] = true;
                } else if( !isTouching && prevIsTouching &&
                          ofRectangle(testButtonPos[i].x, testButtonPos[i].y, testButtonSize.x, testButtonSize.y).inside(touchPos.x, touchPos.y) ){
                    testButtonPressed[i] = false;
                    testConfirmed[i] = false;
                    sendTestMessage(i);
                } else {
                    testButtonPressed[i] = false;
                }
                if( testSent[i] ){
                    receiveTestMessage(i);
                }
            } else if( !iHaveIp[i] && loadConfigScreen[i] ){
                if( isTouching &&
                   ofRectangle(loadRect[i][0].x, loadRect[i][0].y, configRectSize, configRectSize).inside(touchPos.x, touchPos.y) ){
                    bigButtonPressed[i] = true;
                } else if( !isTouching && prevIsTouching &&
                          ofRectangle(loadRect[i][0].x, loadRect[i][0].y, configRectSize, configRectSize).inside(touchPos.x, touchPos.y) ){
                    bigButtonPressed[i] = false;
                    HOST[i] = keybdInput[i][0]->getText();
                    PORT[i] = ofToInt(keybdInput[i][1]->getText());
                    keybdInput[i][0]->setVisible(false);
                    keybdInput[i][1]->setVisible(false);
                    string host_ = "//host_" + ofToString(i + 1);
                    string port_ = "//port_" + ofToString(i + 1);
                    xmlSettings.setValue(host_, HOST[i]);
                    xmlSettings.setValue(port_, ofToString(PORT[i]));
                    xmlSettings.save(ofxiPhoneGetDocumentsDirectory() + "xml/labanIPs.xml");
                    sender[i].setup(HOST[i], PORT[i]);
                    loadConfigScreen[i] = false;
                } else {
                    bigButtonPressed[i] = false;
                }
            } else {
                receiveTestMessage(i);
            }
        }
        if( iHaveIp[0] && iHaveIp[1] ){
            iHaveIps = true;
        }
    } else {
        for(int i=0; i<2; i++){
            checkStatusChange();
            if( state[i] == 0 ){
                emailInput[i]->setVisible(false);
                if( isTouching &&
                   ofRectangle(loadRect[i][0].x, loadRect[i][0].y, configRectSize, configRectSize).inside(touchPos.x, touchPos.y) ){
                    bigButtonPressed[i] = true;
                } else if( !isTouching && prevIsTouching &&
                          ofRectangle(loadRect[i][0].x, loadRect[i][0].y, configRectSize, configRectSize).inside(touchPos.x, touchPos.y)  ){
                    bigButtonPressed[i] = false;
                    requestStatusChange(i, false);
                } else {
                    bigButtonPressed[i] = false;
                }
                
                if( demoActive ){
                    if( isTouching &&
                       ofRectangle(demoButtonPos[i].x, demoButtonPos[i].y, demoButtonSize.x, demoButtonSize.y).inside(touchPos.x, touchPos.y) ){
                        demoButtonPressed[i] = true;
                    } else if( !isTouching && prevIsTouching &&
                              ofRectangle(demoButtonPos[i].x, demoButtonPos[i].y, demoButtonSize.x, demoButtonSize.y).inside(touchPos.x, touchPos.y) ){
                        demoButtonPressed[i] = false;
                        requestStatusChange(i, true);
                    } else {
                        demoButtonPressed[i] = false;
                    }
                }
                
                if( emailPopUpBox[i] ){
                    emailPopUpBox[i] = false;
                }
            } else if( state[i]==4 ){
                if( !emailPopUpBox[i] ){
                    emailInput[i]->setVisible(false);
                    if( isTouching &&
                       ofRectangle(playAgainRect[i].x + screenPos[i].x, playAgainRect[i].y, playAgainRectSize.x, playAgainRectSize.y).inside(touchPos.x, touchPos.y) ){
                        bigButtonPressed[i] = true;
                    } else if( !isTouching && prevIsTouching &&
                              ofRectangle(playAgainRect[i].x + screenPos[i].x, playAgainRect[i].y, playAgainRectSize.x, playAgainRectSize.y).inside(touchPos.x, touchPos.y) ){
                        bigButtonPressed[i] = false;
                        requestStatusChange(i, false);
                    } else {
                        bigButtonPressed[i] = false;
                    }
                    
                    if( !state4_error ){
                        if( isTouching &&
                           ofRectangle(emailRect[i].x, emailRect[i].y, emailRectSize.x, emailRectSize.y).inside(touchPos.x, touchPos.y) ){
                            emailButtonPressed[i] = true;
                        } else if( !isTouching && prevIsTouching &&
                                  ofRectangle(emailRect[i].x, emailRect[i].y, emailRectSize.x, emailRectSize.y).inside(touchPos.x, touchPos.y) ){
                            emailButtonPressed[i] = false;
                            emailPopUpBox[i] = true;
                            emailInput[i]->setText("hola@tuemail.com");
                            emailInput[i]->setVisible(true);
                        } else {
                            emailButtonPressed[i] = false;
                        }
                    }
                } else {
                    if( isTouching &&
                       ofRectangle(emailOkRect[i].x, emailOkRect[i].y, emailOkRectSize.x, emailOkRectSize.y).inside(touchPos.x, touchPos.y) ){
                        emailOkButtonPressed[i] = true;
                    } else if( !isTouching && prevIsTouching &&
                              ofRectangle(emailOkRect[i].x, emailOkRect[i].y, emailOkRectSize.x, emailOkRectSize.y).inside(touchPos.x, touchPos.y) ){
                        emailOkButtonPressed[i] = false;
                        emailPopUpBox[i] = false;
                        emailInput[i]->setVisible(false);
                        sendEmailAddress(i, emailInput[i]->getText());
                    } else {
                        emailOkButtonPressed[i] = false;
                    }
                    if( isTouching &&
                       ( touchPos.x < emailInputRect[i].x || touchPos.x > emailInputRect[i].x + emailInputRectSize.x ||
                         touchPos.y < emailInputRect[i].y || touchPos.y > emailInputRect[i].y + emailInputRectSize.y )){
                           emailPopUpBox[i] = false;
                           emailInput[i]->setVisible(false);

                    }
                }
            } else {
                emailInput[i]->setVisible(false);
                if( alphaDecreasing[i] ){
                    if( alphaGuiImgs[i] > 0 ){
                        alphaGuiImgs[i] -= alphaChangeAmount;
                    } else if (alphaGuiImgs[i] <= 0){
                        alphaDecreasing[i] = false;
                    }
                } else {
                    if( alphaGuiImgs[i] < 255 ){
                        alphaGuiImgs[i] += alphaChangeAmount;
                    } else if (alphaGuiImgs[i] >= 255){
                        alphaDecreasing[i] = true;
                    }
                }
            }
        }
    }
    prevIsTouching = isTouching;
}

void ofApp::sendEmailAddress(int pcNumber, string emailAddress){
    string address = "/" + ofToString(pcNumber) + "/send_email_to";
    ofxOscMessage m;
    m.setAddress(address);
    m.addStringArg(emailAddress);
    sender[pcNumber].sendMessage(m, false);
}

void ofApp::sendTestMessage(int pcNumber){
    string address = "/" + ofToString(pcNumber) + "/test";
    ofxOscMessage m;
    m.setAddress(address);
    sender[pcNumber].sendMessage(m, false);
    testSent[pcNumber] = true;
}

void ofApp::receiveTestMessage(int pcNumber){
    string msg = "/" + ofToString(pcNumber) + "/test";
    while(receiver.hasWaitingMessages()){
        ofxOscMessage m;
        receiver.getNextMessage(m);
        if( m.getAddress() == msg ){
            testConfirmed[pcNumber] = true;
            testSent[pcNumber] = false;
        }
    }
}

void ofApp::checkStatusChange(){
    // Manage OSC
    while(receiver.hasWaitingMessages()){
        ofxOscMessage m;
        receiver.getNextMessage(m);
        for(int i=0; i<2; i++){
            for(int j=0; j<6; j++){
                if( j!=4 ){
                    string msg;
                    msg = "/" + ofToString(i) + "/state/" + ofToString(j);
                    if(m.getAddress() == msg){
                        state[i] = j;
                    }
                } else {
                    string msg[2];
                    msg[0] = "/" + ofToString(i) + "/state/" + ofToString(j) + "/1";
                    msg[1] = "/" + ofToString(i) + "/state/" + ofToString(j) + "/0";
                    if(m.getAddress() == msg[0]){
                        state[i] = j;
                        state4_error = false;
                    } else if(m.getAddress() == msg[1]){
                        state[i] = j;
                        state4_error = true;
                    }
                }
                ofLog()<<"PC: " + ofToString(i) + " // NEW STATE: " + ofToString(j);
            }
        }
    }
}

void ofApp::requestStatusChange(int pcNumber, bool demo){
    string nextState;
    if( !demo ){
        if(state[pcNumber] == 0){
            nextState = ofToString(state[pcNumber] + 1);
        } else if (state[pcNumber] == 4) {
            nextState = ofToString(0);
        }
    } else {
        nextState = ofToString(5);
    }

    string address = "/" + ofToString(pcNumber) + "/state/" + nextState;
    ofxOscMessage m;
    m.setAddress(address);
    sender[pcNumber].sendMessage(m, false);
}

//--------------------------------------------------------------
void ofApp::draw(){
    if( !iHaveIps ){
        for(int i=0; i<2; i++){
            if( !iHaveIp[i] && !loadConfigScreen[i] ){
                // Background
                ofPushStyle();
                ofSetColor(255, 255);
                loadScreen[i].draw(screenPos[i].x, screenPos[i].y);
                ofPopStyle();
                
                // Info text
                ofPushStyle();
                ofSetColor(labanColor[2], 255);
                if( testConfirmed[i] ){
                    prompt40.drawString("¡CONECTADO!", loadInfoTextPos[i][0].x + 20, loadInfoTextPos[i][0].y - 750);
                }
                prompt40.drawString("HOST: " + HOST[i], loadInfoTextPos[i][0].x, loadInfoTextPos[i][0].y);
                prompt40.drawString("PORT: " + ofToString(PORT[i]), loadInfoTextPos[i][1].x, loadInfoTextPos[i][1].y);
                ofPopStyle();
                
                // Test Button Highlight
                if( testButtonPressed[i] ){
                    ofPushStyle();
                    ofSetColor(labanColor[5], 100);
                    ofDrawRectangle(testButtonPos[i].x, testButtonPos[i].y, testButtonSize.x, testButtonSize.y);
                    ofPopStyle();
                }
                
                // Button highlight
                for( int j=0; j<2; j++ ){
                    if( loadButtonPressed[i][j] ){
                        ofPushStyle();
                        ofSetColor(labanColor[5], 100);
                        ofDrawRectangle(loadRect[i][j].x, loadRect[i][j].y, loadRectSize, loadRectSize);
                        ofPopStyle();
                    }
                }
            } else if( !iHaveIp[i] && loadConfigScreen[i] ) {
                // Background
                ofPushStyle();
                ofSetColor(255, 255);
                configScreen[i].draw(screenPos[i].x, screenPos[i].y);
                ofPopStyle();
                
                // Button text
                ofPushStyle();
                ofSetColor(labanColor[5], 255);
                prompt40.drawString("SAVE", configButtonTextPos[i].x, configButtonTextPos[i].y);
                ofPopStyle();
                
                // Button highlight
                if( bigButtonPressed[i] ){
                    ofPushStyle();
                    ofSetColor(labanColor[5], 100);
                    ofDrawRectangle(loadRect[i][0].x, loadRect[i][0].y, configRectSize, configRectSize);
                    ofPopStyle();
                }
            } else {
                ofPushStyle();
                ofSetColor(labanColor[5], 255);
                ofDrawRectangle(screenPos[i].x, screenPos[i].y, 1024, 1536);
                ofPopStyle();
                
                // Button text
                ofPushStyle();
                string msg[4];
                msg[1] = "PC" + ofToString(i + 1) + ": IP confirmada.";
                ofSetColor(labanColor[2], 255);
                prompt40.drawString(msg[1], 60 + screenPos[i].x, loadInfoTextPos[i][0].y - 550);
                if( testConfirmed[i] ){
                    ofSetColor(labanColor[2], 255);
                    msg[0] = "App Laban en PC" + ofToString(i + 1) + ": conectada a iPad.";
                    if( i==0 ){
                        msg[2] = "Para continuar confirma IP de PC" + ofToString(2) + ".";
                    } else if( i==1 ){
                        msg[2] = "Para continuar confirma IP de PC" + ofToString(1) + ".";
                    }
                    msg[3] = "";
                } else {
                    ofSetColor(255, 0, 10, 180);
                    msg[0] = "App Laban en PC" + ofToString(i + 1) + ": No hay conexión.";
                    msg[2] = "Comprueba que App Laban (PC" + ofToString(i + 1) + ") está activa";
                    msg[3] = "y que HOST y PORT son correctos.";
                }
                prompt40.drawString(msg[0], 60 + screenPos[i].x, loadInfoTextPos[i][0].y - 450);
                prompt40.drawString(msg[2], 60 + screenPos[i].x, loadInfoTextPos[i][0].y - 350);
                prompt40.drawString(msg[3], 60 + screenPos[i].x, loadInfoTextPos[i][0].y - 300);
                ofPopStyle();
            }
        }

    } else {
        for(int i=0; i<2; i++){
            int alpha;
            if( state[i]!=0 && state[i]!=4 ){
                alpha = alphaGuiImgs[i];
                ofPushStyle();
                ofSetColor(255, 255);
                bckgrd[i].draw(screenPos[i].x, screenPos[i].y);
                ofPopStyle();
            } else {
                alpha = 255;
            }
            ofPushStyle();
            ofSetColor(255, alpha);
            int guiIdx;
            if( (state[i] == 4 && state4_error) || state[i] == 5 ){
                guiIdx = state[i] + 1;
            } else {
                guiIdx = state[i];
            }
            guiScreen[i][guiIdx].draw(screenPos[i].x, screenPos[i].y);
            ofPopStyle();
            
            // Button Highlight
            if( state[i]==0){
                if( bigButtonPressed[i] ){
                    ofPushStyle();
                    ofSetColor(labanColor[5], 100);
                    ofDrawRectangle(loadRect[i][0].x, loadRect[i][0].y, configRectSize, configRectSize);
                    ofPopStyle();
                }
                if( demoActive && demoButtonPressed[i] ){
                    ofPushStyle();
                    ofSetColor(labanColor[5], 100);
                    ofDrawRectangle(demoButtonPos[i].x, demoButtonPos[i].y, demoButtonSize.x, demoButtonSize.y
                                    );
                    ofPopStyle();
                }
            } else if( state[i]==4 ){
                if( bigButtonPressed[i] ){
                    ofPushStyle();
                    ofSetColor(labanColor[2], 100);
                    ofDrawRectangle(playAgainRect[i].x + screenPos[i].x, playAgainRect[i].y, playAgainRectSize.x, playAgainRectSize.y);
                    ofPopStyle();
                }
                
                if( !state4_error ){
                    if( emailButtonPressed[i] ){
                        ofPushStyle();
                        ofSetColor(labanColor[2], 100);
                        ofDrawRectangle(emailRect[i].x, emailRect[i].y, emailRectSize.x, emailRectSize.y);
                        ofPopStyle();
                    }
                    
                    if ( emailPopUpBox[i] ){
                        ofPushStyle();
                        ofSetColor(labanColor[0], 200);
                        ofDrawRectangle(screenPos[i].x, screenPos[i].y, 1024, ofGetHeight());
                        ofSetColor(labanColor[5], 255);
                        ofDrawRectangle(emailInputRect[i].x, emailInputRect[i].y, emailInputRectSize.x, emailInputRectSize.y);
                        ofSetColor(labanColor[1], 255);
                        ofDrawRectangle(emailOkRect[i].x, emailOkRect[i].y, emailOkRectSize.x, emailOkRectSize.y);
                        ofSetColor(labanColor[5], 255);
                        prompt20.drawString("ENVIAR",
                                            emailOkRect[i].x + 10,
                                            emailOkRect[i].y + emailOkRectSize.y/2 + 5);
                        ofPopStyle();
                        // Button Highlight
                        if( emailOkButtonPressed[i] ){
                            ofPushStyle();
                            ofSetColor(labanColor[5], 100);
                            ofDrawRectangle(emailOkRect[i].x, emailOkRect[i].y, emailOkRectSize.x, emailOkRectSize.y);
                            ofPopStyle();
                        }
                    }
                }
            }
        }
    }
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    isTouching = true;
    touchPos = ofPoint(touch.ofVec2f::x, touch.ofVec2f::y);
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    isTouching = false;
    touchPos = ofPoint(touch.ofVec2f::x, touch.ofVec2f::y);
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}

