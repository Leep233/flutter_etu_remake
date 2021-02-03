import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
class CommoditySwiper extends StatefulWidget{

    final String video;
    final List<String> images;

    CommoditySwiper({Key key,this.video,this.images}):super(key:key);

    @override
    State<StatefulWidget> createState()=>CommoditySwiperState(); 
}
 
class CommoditySwiperState extends State<CommoditySwiper>{

    @override
    void initState() {
       super.initState();
    }

    @override
    void dispose() {
          super.dispose();
    }

    @override
    void deactivate() {
         super.deactivate();
     }

    @override
    Widget build(BuildContext context) {
      return Swiper(
      itemCount: widget.images?.length ?? 0,
      itemBuilder: _imageBuilder,
      autoplay: (widget.images?.length ?? 0) > 1,
      autoplayDelay: 5000,
      pagination: SwiperPagination(alignment: Alignment.bottomCenter),
    );
    }
 Widget _imageBuilder(BuildContext context, int index) {
    String imgUrl = widget.images[index];

    return Container(
        child: FadeInImage.assetNetwork(
            fit: BoxFit.fill, placeholder:'assets/images/loading.gif', image: imgUrl));
  }
}