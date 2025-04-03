import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class rotationChart extends StatefulWidget {
  rotationChart({Key key}) : super(key: key);
  @override
  _rotationChartState createState() => _rotationChartState();
}

List<Map> rotationImageList = [
  {"rotation": "lib/assets/rotationChart/rotation1.jpg"},
  {"rotation": "lib/assets/rotationChart/rotation2.jpg"},
   {"rotation": "lib/assets/rotationChart/rotation3.jpg"},
      {"rotation": "lib/assets/rotationChart/rotation4.jpg"},
];

class _rotationChartState extends State<rotationChart> {
  @override
  Widget build(BuildContext context) {
      return Container(
        
         padding: const EdgeInsets.only(bottom: 8),
          child:Column(
              children:<Widget>[
                  Container(
                      width: double.infinity,
                      child: AspectRatio(
                          aspectRatio: 16/9,
                          child: new Swiper(
                              itemBuilder: (BuildContext context,int index){
                                  return new Image.asset(rotationImageList[index]["rotation"], fit: BoxFit.cover, width: 50, height: 50,);
                              },
                              itemCount: rotationImageList.length,
                              pagination: new SwiperPagination(),
                              control: new SwiperControl(),
                              loop: true,
                              autoplay: true,
                          ),  
                      ),
                  )
              ]
          )
      );
  }
}
