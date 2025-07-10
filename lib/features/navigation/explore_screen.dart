import 'package:dragable_app/app.dart';
import 'package:dragable_app/constants/icons.dart';
import 'package:dragable_app/constants/sizes.dart';
import 'package:dragable_app/features/preview/product_detail_screen.dart';
import 'package:dragable_app/widgets/txtfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int selectedCategory = 0;
  List<List<Map<String, dynamic>>> productLists = [
    iphoneList,
    ipadList,
    macbookList,
    imacList,
    earbudList,
    appleWatchList,
    otherappleproducts,
  ];

  List<String> categoryTitles = ['iPhone', 'iPad', 'MacBook', 'iMac', 'iPod', 'iwatch', 'Other'];

  List<String> categoryIcons = [
    icons.iphone,
    icons.ipad,
    icons.macbook,
    icons.imac,
    icons.ipod,
    icons.iwatch,
    '', 
  ];

  @override
  Widget build(BuildContext context) {
    final currentList = productLists[selectedCategory];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: displaysize.height * .04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: displaysize.height * .02),
              child: Center(
                child: Txt('Explore Products', font: Font.medium, size: sizes.titleLarge(context)),
              ),
            ),
            SizedBox(height: displaysize.height * .04),
            SizedBox(
              height: displaysize.height * .12,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: displaysize.height * .02),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  final bool isSelected = selectedCategory == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = index;
                      });
                    },
                    child: Center(
                      child: index == 6
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 220),
                                      curve: Curves.easeOut,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isSelected
                                            ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                                            : Theme.of(
                                                context,
                                              ).colorScheme.secondary.withValues(alpha: .1),
                                      ),
                                      child: AnimatedScale(
                                        scale: isSelected ? 1.13 : 1.0,
                                        duration: Duration(milliseconds: 220),
                                        child: CircleAvatar(
                                          radius: displaysize.height * .04,
                                          backgroundColor: Colors.transparent,
                                          child: Icon(
                                            Icons.more_horiz_rounded,
                                            color: Theme.of(context).colorScheme.secondary,
                                            size: displaysize.height * .03,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Txt(
                                    'More',
                                    size: sizes.bodyMedium(context),
                                    font: Font.medium,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 220),
                                      curve: Curves.easeOut,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isSelected
                                            ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                                            : Theme.of(
                                                context,
                                              ).colorScheme.secondary.withValues(alpha: .1),
                                        boxShadow: isSelected
                                            ? [
                                                BoxShadow(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.primary.withOpacity(0.18),
                                                  blurRadius: 12,
                                                  offset: Offset(0, 2),
                                                ),
                                              ]
                                            : [],
                                      ),
                                      child: AnimatedScale(
                                        scale: isSelected ? 1.13 : 1.0,
                                        duration: Duration(milliseconds: 220),
                                        child: CircleAvatar(
                                          radius: displaysize.height * .04,
                                          backgroundColor: Colors.transparent,
                                          child: Image.asset(
                                            categoryIcons[index],
                                            height: displaysize.height * .04,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Center(
                                      child: Txt(
                                        categoryTitles[index],
                                        align: TextAlign.center,
                                        font: Font.medium,
                                        size: sizes.bodyMedium(context),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: displaysize.height * .02),
                              ],
                            ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: displaysize.height * .04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: displaysize.height * .02),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: currentList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 18,
                    childAspectRatio: 0.82,
                  ),
                  itemBuilder: (context, index) {
                    final product = currentList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                          CupertinoPageRoute(
                            builder: (_) => ProductDetailScreen(
                              product: product,
                              tag: product['title'] ?? 'product',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary.withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.secondary.withOpacity(0),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (product['icon'] != null)
                              Hero(
                                tag: product['title'] ?? 'product',
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image.asset(
                                    product['icon'],
                                    fit: BoxFit.contain,
                                    height: displaysize.height * .1,
                                  ),
                                ),
                              ),
                            if (product['title'] != null)
                              Text(
                                product['title'],
                                style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: -0.2),
                                textAlign: TextAlign.center,
                              ),
                            if (product['description'] != null)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2),
                                child: Text(
                                  product['description'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: displaysize.height * .01),
          ],
        ),
      ),
    );
  }
}
