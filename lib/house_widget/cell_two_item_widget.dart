/*
*  cell_two_item_widget.dart
*  When
*
*  Created by Furkan Anşin.
*  Copyright © 2018 HobedTech. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:when/tab_group_two_tab_bar_widget/tab_group_two_tab_bar_widget.dart';
import 'package:when/values/values.dart';
import 'package:when/detail_post_widget/detail_post_widget.dart';

class CellTwoItemWidget extends StatelessWidget {
  List<dynamic> all;
  int index;

  CellTwoItemWidget(this.all,this.index);

 onTap(BuildContext context,List<dynamic> all,  int index){
  Navigator.push(context,
      MaterialPageRoute(
          builder: (BuildContext context) => DetailPostWidget(all,index)
      )
  );
}
  @override
  Widget build(BuildContext context) {

    return  Container(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(

            onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPostWidget(all,index))),
              child: Hero(
                tag: "detail-hero"+all[index].eventPhoto.toString(),
                child: ClipRRect(

                  borderRadius: BorderRadius.all(Radius.circular(41)),

                  child: Image.network(all[index].eventPhoto, fit: BoxFit.fill,height: MediaQuery.of(context).size.height * 0.8 ,),
                ),
              ),
            ),
              SizedBox(height: 10,),
          ],

        ),
      );


  }
}

