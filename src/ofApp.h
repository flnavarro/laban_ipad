#pragma once

#include "ofxiOS.h"
#include "ofxiOSKeyboard.h"
#include "ofxOsc.h"

#define PORT_IN 20001

class ofApp : public ofxiOSApp{
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
    
        // Colors
        ofColor labanColor[6];
    
        // States
        void requestStatusChange(int pcNumber, bool demo);
        void checkStatusChange();
        bool iHaveIps;
        bool iHaveIp[2];
        int state[2];
        bool state4_error;
    
        // Xml
        ofXml xmlSettings;
    
        // Osc
        ofxOscSender sender[2];
        ofxOscReceiver receiver;
        string HOST[2];
        int PORT[2];
        void sendEmailAddress(int pcNumber, string emailAddress);
        void sendTestMessage(int pcNumber);
        bool testSent[2];
        void receiveTestMessage(int pcNumber);
        bool testConfirmed[2];
    
        // GUI
        ofTrueTypeFont prompt40;
        ofTrueTypeFont prompt20;
        ofTrueTypeFont promptExtra70;
        ofPoint screenPos[2];
        ofImage bckgrd[2];
        ofImage guiScreen[2][7];
        ofImage loadScreen[2];
        ofImage configScreen[2];
        ofPoint loadRect[2][2];
        int loadRectSize;
        ofPoint loadInfoTextPos[2][2];
        ofPoint loadButtonTextPos[2][2];
        bool loadButtonPressed[2][2];
        bool loadConfigScreen[2];
        ofPoint testButtonPos[2];
        ofVec2f testButtonSize;
        bool testButtonPressed[2];
        int configRectSize;
        ofPoint configButtonTextPos[2];
        bool bigButtonPressed[2];
        ofPoint demoButtonPos[2];
        ofVec2f demoButtonSize;
        bool demoButtonPressed[2];
        bool demoActive;
        ofVec2f playAgainRectSize;
        ofPoint playAgainRect[2];
        ofVec2f emailRectSize;
        ofPoint emailRect[2];
        ofVec2f emailInputRectSize;
        ofPoint emailInputRect[2];
        bool emailButtonPressed[2];
        bool emailPopUpBox[2];
        bool prevEmailPopUpBox[2];
        ofVec2f emailOkRectSize;
        ofPoint emailOkRect[2];
        bool emailOkButtonPressed[2];
        int alphaGuiImgs[2];
        bool alphaDecreasing[2];
        int alphaChangeAmount;
    
        // Mouse
        bool isTouching = false;
        bool prevIsTouching = false;
        ofPoint touchPos;
    
        // Keyboard
        ofxiOSKeyboard * keybdInput[2][2];
        ofPoint keybdPos[2][2];
        ofxiOSKeyboard * emailInput[2];
};


