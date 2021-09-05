import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:travel_app/Screens/categories_screen.dart';
import 'package:travel_app/Screens/category_trips_screen.dart';
import 'package:travel_app/Screens/filters_screen.dart';
import 'package:travel_app/Screens/trip_detail_screen.dart';
import 'package:travel_app/models/trip.dart';
import 'package:travel_app/widgets/app_data.dart';

import 'Screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String,bool> _filters ={
    'summer': false,
    'winter': false,
    'family': false,
  };

  List<Trip> _availableTrips = Trips_data;
  List<Trip> _favouriteTrips = [];

  void _changeFilters(Map<String,bool> filterData){
  setState(() {
    _filters = filterData;

    _availableTrips = Trips_data.where((trip) {
    if(_filters['summer'] == true && trip.isInSummer != true){
      return false;
    }
    if(_filters['winter'] == true && trip.isInWinter != true){
      return false;
    }
    if(_filters['family'] == true && trip.isForFamilies != true){
      return false;
    }
    return true;
    }).toList();
  });
  }

  void _manageFavourite(String tripId){
   final existingIndex =  _favouriteTrips.indexWhere((trip) =>
   trip.id == tripId);
   if(existingIndex >= 0){
     setState(() {
       _favouriteTrips.removeAt(existingIndex);
     });
   } else {
     setState(() {
       _favouriteTrips.add(
         Trips_data.firstWhere((trip) => trip.id == tripId),
       );
     });
   }
  }

  bool _isFavourite(String id){
    return _favouriteTrips.any((trip) => trip.id == id);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegatGlobalMaterialLocalizationses: [
        .delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ar', 'AE'), // English, no country code
      ],
      title: 'Travel App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.amber,
          fontFamily: 'ElMessiri',
          textTheme: ThemeData.light().textTheme.copyWith(
            headline5: TextStyle(
              color: Colors.blue,
              fontSize: 24,
              fontFamily: 'ElMessiri',
              fontWeight: FontWeight.bold,
            ),
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontFamily: 'ElMessiri',
              fontWeight: FontWeight.bold,
            ),
          )),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favouriteTrips),
        CategoryTripsScreen.screenRoute: (ctx) =>
            CategoryTripsScreen(_availableTrips),
        TripDetailScreen.screenRoute: (ctx) =>
            TripDetailScreen(_manageFavourite, _isFavourite),
        FiltersScreen.screenRoute: (ctx) =>
            FiltersScreen(_filters, _changeFilters),
      },
    );
  }
}
