import 'package:flutter/material.dart';

import 'package:postman_app/base/data/helper/constants.dart';

class SliderWithIndicators extends StatefulWidget {
  final List<String>? images;
  const SliderWithIndicators({
    Key? key,
    this.images,
  }) : super(key: key);

  @override
  _SliderWithIndicatorsState createState() => _SliderWithIndicatorsState();
}

class _SliderWithIndicatorsState extends State<SliderWithIndicators> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: getHeight(context, 45),
          width: MediaQuery.of(context).size.width,
          child: PageView.builder(
            itemCount: widget.images!.length,
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(
                widget.images![index],
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        Visibility(
          visible: widget.images!.length > 1,
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < widget.images!.length; i++) {
      indicators.add(_buildIndicator(i == _currentPage));
    }
    return indicators;
  }

  Widget _buildIndicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
          color: isActive ? greenColor : Colors.grey, shape: BoxShape.circle),
    );
  }
}
