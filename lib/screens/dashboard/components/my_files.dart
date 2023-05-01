import 'package:flutter/material.dart';

import '../../../configs/themes/ui_parameters.dart';
import '../../../responsive.dart';
import './file_info_card_view.dart';

class MyFiles extends StatelessWidget {
  const MyFiles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Files',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical: (Responsive.isMobile(context))
                      ? defaultPadding / 2
                      : defaultPadding / 1,
                ),
              ),
              icon: const Icon(Icons.add),
              label: const Text('Add New'),
              onPressed: () {},
            )
          ],
        ),
        const SizedBox(height: defaultPadding),
        Responsive(
            mobile: FileInfoCardView(
              crossAxisCount: (size.width > 650) ? 4 : 2,
              childAspectRatio: (size.width > 700) ? 1.3 : 1,
            ),
            tablet: FileInfoCardView(
              crossAxisCount: (size.width > 950) ? 4 : 2,
              childAspectRatio: (size.width > 950) ? 1 : 0.9,
            ),
            desktop: FileInfoCardView(
              crossAxisCount: 4,
              childAspectRatio: (size.width > 1400) ? 1.3 : 1,
            ))
      ],
    );
  }
}
