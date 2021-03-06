// Copyright (c) 2013, akserg (Sergey Akopkokhyants)
// https://github.com/akserg/monomer
// All rights reserved.  Please see the LICENSE.md file.

part of monomer_tests;

void formTests() {
  logMessage('Performing button tests.');

  group('Testing button:', () {
    Button button;
    var dataToSend = {'id':1, 'name':'Test Name'};
    
    setUp((){
      button = new Button();
      document.body.append(button);
    });
    
    tearDown((){
      button.remove();
    });
    
    test('Do Action', () {
      logMessage('Expect call action method when user click on button');
      
      button.data = dataToSend;
      
      button.onAction.listen((event) {
        logMessage('Handle Action Event');
        expect(event, new isInstanceOf<CustomEvent>(), reason:'must be CustomEvent');
        expect(event.type, equals('action'), reason:'must be action event type');
      });
      
      logMessage('Click on button');
      button.dispatchEvent(new MouseEvent('click'));
    });
    
    test('Do Visible', () {
      logMessage('Expect make button visible or invisible');
      
      button.onVisible.listen((event) {
        logMessage('Handle Visible Event');
        expect(event, new isInstanceOf<CustomEvent>());
        // Check the state
        bool visible = (event as CustomEvent).detail;
        if (visible) {
          expect(button.style.display, equals(''), reason:'must be visible');
        } else {
          expect(button.style.display, equals('none'), reason:'must be invisible');
        }
      });
      
      logMessage('Set button invisible');
      Component.setVisible(button, false);
      logMessage('Set button visible');
      Component.setVisible(button, true);
    });
    
    test('Do Include in Layout', () {
      logMessage('Expect include or exclude button from layout');
      
      button.onIncludeInLayout.listen((event) {
        logMessage('Handle IncludeInLayout Event');
        expect(event, new isInstanceOf<CustomEvent>());
        // Check the state
        bool visibility = (event as CustomEvent).detail;
        if (visibility) {
          expect(button.style.visibility, equals('visible'), reason:'must be include in layout');
        } else {
          expect(button.style.visibility, equals('hidden'), reason:'must be exnclude from layout');
        }
      });
      
      logMessage('Exclude button from layout');
      Component.setIncludeInLayout(button, false);
      logMessage('Include button in layout');
      Component.setIncludeInLayout(button, true);
    });
  });
}