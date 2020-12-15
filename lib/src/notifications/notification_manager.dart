import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  FlutterLocalNotificationsPlugin _flnp;

  NotificationManager() {
    _flnp = new FlutterLocalNotificationsPlugin(); 
    var initializationSettingsAndroid = AndroidInitializationSettings('@drawable/ic_stat_notification_default');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSettings = new InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    _flnp.initialize(initSettings);
  }

  Future showNotificationWithDefaultSound(id, title, body) async { 
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails( 
        'id', 
        'name', 
        'description', 
        importance: Importance.max, 
        priority: Priority.high,
        // icon: '@drawable/ic_stat_notification_default_1',
        color: const Color.fromARGB(255, 31, 75, 153)
    ); 
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails(); 
      
    // initialise channel platform for both Android and iOS device. 
    var platformChannelSpecifics = new NotificationDetails( 
        android: androidPlatformChannelSpecifics, 
        iOS: iOSPlatformChannelSpecifics 
    ); 
    
    await _flnp.show(id, title, 
      body, 
      platformChannelSpecifics, payload: 'Default_Sound'
    ); 
  } 
}