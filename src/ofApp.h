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
        void requestStatusChange(int pcNumber);
        void checkStatusChange();
        bool iHaveIps;
        bool iHaveIp[2];
        int state[2];
    
        // Xml
        ofXml xmlSettings;
    
        // Osc
        ofxOscSender sender[2];
        ofxOscReceiver receiver;
        string HOST[2];
        int PORT[2];
        void sendEmailAddress(int pcNumber, string emailAddress);
    
        // GUI
        ofTrueTypeFont prompt40;
        ofTrueTypeFont prompt20;
        ofPoint screenPos[2];
        ofImage guiScreen[2][5];
        ofImage loadScreen[2];
        ofImage configScreen[2];
        ofPoint loadRect[2][2];
        int loadRectSize;
        ofPoint loadInfoTextPos[2][2];
        ofPoint loadButtonTextPos[2][2];
        bool loadButtonPressed[2][2];
        bool loadConfigScreen[2];
        int configRectSize;
        ofPoint configButtonTextPos[2];
        bool bigButtonPressed[2];
        ofVec2f playAgainRectSize;
        ofPoint playAgainRect[2];
        ofVec2f emailRectSize;
        ofPoint emailRect[2];
        bool emailButtonPressed[2];
        bool emailPopUpBox[2];
        ofVec2f emailOkRectSize;
        ofPoint emailOkRect[2];
        bool emailOkButtonPressed[2];
    
        // Mouse
        bool isTouching = false;
        bool prevIsTouching = false;
        ofPoint touchPos;
    
        // Keyboard
        ofxiOSKeyboard * keybdInput[2][2];
        ofPoint keybdPos[2][2];
        ofxiOSKeyboard * emailInput[2];
};


