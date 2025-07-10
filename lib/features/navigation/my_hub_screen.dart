import 'package:dragable_app/app.dart';
import 'package:dragable_app/constants/sizes.dart';
import 'package:dragable_app/widgets/txtfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/custom_iphone_provider.dart';
import '../preview/preview_screen.dart';

class MyHubScreen extends StatelessWidget {
  const MyHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: displaysize.height * .04),
            Center(
              child: Txt('Published iPhones', font: Font.medium, size: sizes.titleLarge(context)),
            ),
            SizedBox(height: displaysize.height * .03),
            Expanded(
              child: Consumer<CustomIphoneProvider>(
                builder: (context, provider, _) {
                  final iphones = provider.iphones;
                  if (iphones.isEmpty) {
                    return Center(
                      child: Txt(
                        'Your saved and published custom iPhones\nwill appear here',
                        max: 2,
                        align: TextAlign.center,
                        size: sizes.bodyMedium(context),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: displaysize.height * .02),
                    itemCount: iphones.length,
                    itemBuilder: (context, index) {
                      final iphone = iphones[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder: (_) => PreviewScreen(customIphone: iphone, index: index + 1),
                            ),
                          );
                        },
                        child: Container(
                          height: displaysize.height * .08,
                          width: displaysize.width,
                          margin: EdgeInsets.only(bottom: displaysize.height * .01),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).colorScheme.primary.withValues(alpha: .5),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(backgroundColor: iphone.color),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Txt(
                                          'Custom Design #${index + 1}',
                                          size: sizes.titleMedium(context),
                                          font: Font.medium,
                                        ),
                                        SizedBox(height: 4),
                                        Txt(
                                          'RAM:${iphone.ram}GB, ROM: ${iphone.storage}GB, Screen: ${iphone.screenSize}"',
                                          size: sizes.bodySmall(context),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete_outlined),
                                    tooltip: 'Delete',
                                    onPressed: () async {
                                      await provider.deleteIphoneAt(index);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
