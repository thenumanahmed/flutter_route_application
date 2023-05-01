import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../configs/themes/app_color.dart';
import '../../../configs/themes/ui_parameters.dart';

class SearchFeild extends StatelessWidget {
  const SearchFeild({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: 'Search',
          fillColor: secondaryColorLight,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          suffixIcon: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(defaultPadding * 0.75),
              margin:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              decoration: BoxDecoration(
                color: primaryColorLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset("assets/icons/Search.svg"),
            ),
          )),
    );
  }
}
