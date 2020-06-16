import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../../utils/api/api_calls.dart';

class ImageLoad extends StatelessWidget {
  final provider;
  ImageLoad(this.provider);

  @override
  Widget build(BuildContext context) {
    List<MediaInfo> images = provider.items;
    return Center(
      child: Container(
        width: double.infinity,
        height: 400,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            images.length == 0
                ? Container(
                    height: 300.0,
                    width: 400.0,
                    child: Icon(
                      Icons.image,
                      size: 250.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.memory(
                          images[index].data,
                        ),
                      ),
                      itemCount: images.length,
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Error Dectected: NO'),
            ),
            RaisedButton.icon(
                onPressed: () {
                  pickImage(provider);
                },
                icon: Icon(Icons.image),
                label: Text("Pick-Up Images")),
          ],
        ),
      ),
    );
  }
}
