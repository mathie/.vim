" Vim syntax file
" Language:    Arduino
" Maintainer:  Johannes Hoff <johannes@johanneshoff.com>
" Last Change: 22 Mar 2013
" License:     VIM license (:help license, replace vim by arduino.vim)

" Syntax highlighting like in the Arduino IDE
" Using keywords from <arduino>/build/shared/lib/keywords.txt
" From version: ARDUINO 1.0.3.

" Thanks to Rik, Erik Nomitch, Adam Obeng and Graeme Cross for helpful feedback!

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Read the C syntax to start with
if version < 600
  so <sfile>:p:h/cpp.vim
else
  runtime! syntax/cpp.vim
endif

syn keyword arduinoConstant  BIN BYTE CHANGE DEC DEFAULT EXTERNAL FALLING HALF_PI
syn keyword arduinoConstant  HEX HIGH INPUT INPUT_PULLUP INTERNAL INTERNAL1V1 INTERNAL2V56
syn keyword arduinoConstant  LOW LSBFIRST MSBFIRST OCT OUTPUT PI RISING TWO_PI

syn keyword arduinoFunc      analogRead analogReference analogWrite
syn keyword arduinoFunc      attachInterrupt bit bitClear bitRead bitSet
syn keyword arduinoFunc      bitWrite delay delayMicroseconds detachInterrupt
syn keyword arduinoFunc      digitalRead digitalWrite highByte interrupts
syn keyword arduinoFunc      lowByte micros millis noInterrupts noTone pinMode
syn keyword arduinoFunc      pulseIn shiftIn shiftOut tone

syn keyword arduinoMethod    accept available begin click end find findUntil flush isPressed
syn keyword arduinoMethod    loop move parseFloat parseInt peek press print println
syn keyword arduinoMethod    read readBytes readBytesUntil release releaseAll setTimeout setup

syn keyword arduinoModule    Serial Serial1 Serial2 Serial3 Keyboard Mouse

syn keyword arduinoStdFunc   abs acos asin atan atan2 ceil constrain cos degrees
syn keyword arduinoStdFunc   exp floor log map max min radians random randomSeed
syn keyword arduinoStdFunc   round sin sq sqrt tan

syn keyword arduinoType      boolean byte null String word

hi def link arduinoType Type
hi def link arduinoConstant Constant
hi def link arduinoStdFunc Function
hi def link arduinoFunc Function
hi def link arduinoMethod Function
hi def link arduinoModule Identifier
