import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:travel_app/Screens/trip_detail_screen.dart';
import 'package:travel_app/models/trip.dart';

class TripItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final TripType tripType;
  final Season season;
 // final Function removeItem;

  const TripItem({ required this.title, required this.imageUrl, required this.duration,  required this.tripType, required this.season, required this.id }) ;

  String get seasonText{
   if (season == Season.Winter){
    return 'شتاء';
   }
   if (season == Season.Spring){
     return 'ربيع';
   }
   if (season == Season.Summer){
     return 'صيف';
   }
   if (season == Season.Fall){
     return 'خريف';
   }
   return 'غير معروف';
  }

  String get tripTypeText{
    if (tripType == TripType.Exploration){
      return 'شتاء';
    }
    if (tripType == TripType.Recovery){
      return 'نقاهة';
    }
    if (tripType == TripType.Activities){
      return 'أنشطة';
    }
    if (tripType == TripType.Therapy){
      return 'علاج';
    }
    return 'غير معروف';
  }
  void selectTrip(BuildContext context){
  Navigator.of(context).pushNamed(TripDetailScreen.screenRoute,
  arguments:id).then((result) {
    if(result != null){
    // removeItem(result);
    }
  });
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
   onTap: () => selectTrip(context),
      child:Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 7,
        margin: EdgeInsets.all(10),
        child:Column(
         children: [
           Stack(
             children: [
               ClipRRect(
                 borderRadius: BorderRadius.only(
                   topLeft: Radius.circular(15),
                   topRight: Radius.circular(15),
                 ),
                 child: Image.network(
                   imageUrl,
                   height: 250,
                   width: double.infinity,
                   fit: BoxFit.cover ,
                 ),
               ),
               Container(
                 height: 250,
                 alignment:Alignment.bottomRight,
                 padding: EdgeInsets.symmetric(vertical: 10,
                 horizontal: 20,
                 ),
                 decoration:BoxDecoration(
                   gradient: LinearGradient(
                   begin: Alignment.topCenter,
                   end: Alignment.bottomCenter,
                     colors: [
                      Colors.black.withOpacity(0),
                       Colors.black.withOpacity(0.8),
                     ],
                     stops: [0.6,1]
                   ),
                 ) ,
                 child: Text(title,
                 style: Theme.of(context).textTheme.headline6,
                 overflow:TextOverflow.fade),
               ),
             ],
           ),
           Padding(
             padding: const EdgeInsets.all(20.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Row(
                children: [
                 Icon(Icons.today,color: Theme.of(context).
                 accentColor,),
                 SizedBox(
                 width: 6,
                 ),
                  Text('$duration أيام '),
                ],
              ),
                Row(
                  children: [
                    Icon(Icons.wb_sunny,color: Theme.of(context).
                    accentColor,),
                    SizedBox(
                      width: 6,
                    ),
                    Text(seasonText),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.family_restroom,color: Theme.of(context).
                    accentColor,),
                    SizedBox(
                      width: 6,
                    ),
                    Text(tripTypeText),
                  ],
                ),
              ],
             ),
           ),
         ],
        ) ,
      ) ,
    );
  }
}
