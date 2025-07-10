import 'package:dragable_app/constants/icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/onboard/welcome_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/navigation/explore_screen.dart';
import 'features/navigation/my_hub_screen.dart';
import 'features/navigation/create_iphone_screen.dart';
import 'features/navigation/settings_screen.dart';
import 'features/navigation/inspiration_screen.dart';
import 'features/navigation/main_tab_scaffold.dart';
import 'providers/custom_iphone_provider.dart';

late Size displaysize;

class AstoreApp extends StatelessWidget {
  const AstoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    displaysize = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => CustomIphoneProvider(),
      child: MaterialApp(
        title: 'Astore',

        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color.fromARGB(255, 87, 145, 101),
          fontFamily: 'general_sans',
          colorScheme: ColorScheme.light(
            surface: Colors.white,
            onSurface: Colors.black,
            primary: const Color.fromARGB(255, 92, 167, 111),
            onPrimary: Colors.white,
            secondary: Colors.grey,
            error: Colors.red,
            onError: Colors.white,
          ),
        ),
        darkTheme: ThemeData(
          fontFamily: 'general_sans',
          brightness: Brightness.dark,
          primaryColor: Colors.green.shade200,
          colorScheme: ColorScheme.dark(
            primary: Colors.green.shade200,
            onPrimary: Colors.white,
            secondary: Colors.white.withValues(alpha: .2),
            onSurface: Colors.white,
            error: Colors.red,
            onError: Colors.white,
          ),
        ),
        themeMode: ThemeMode.system,
        initialRoute: '/',
        routes: {
          '/': (_) => const WelcomeScreen(),
          '/login': (_) => const LoginScreen(),
          '/main': (_) => const MainTabScaffold(),
          '/explore': (_) => const ExploreScreen(),
          '/myhub': (_) => const MyHubScreen(),
          '/create': (_) => const CreateIphoneScreen(),
          '/settings': (_) => const SettingsScreen(),
          '/inspiration': (_) => const InspirationScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

final List<Map<String, dynamic>> iphoneList = [
  {
    'title': 'iPhone 15 Pro Max',
    'icon': icons.apple8,
    'description':
        'Apple\'s flagship with A17 Pro chip, triple camera, and titanium frame. Experience ProMotion, Always-On display, and the best battery life ever in an iPhone. The camera system enables ProRAW and ProRes video, making it a content creator’s dream.',
    'heroid': 'iphone15promax',
    'ram': '8GB',
    'rom': '256GB/512GB/1TB',
    'screensize': '6.7"',
    'color': ['Natural Titanium', 'Blue Titanium', 'White Titanium', 'Black Titanium'],
  },
  {
    'title': 'iPhone 15',
    'icon': icons.apple8,
    'description':
        'Latest standard iPhone with A16 Bionic chip and dual camera. Enjoy vibrant colors, Cinematic mode for video, and a durable Ceramic Shield front. Perfect for everyday use with 5G speed and MagSafe accessories.',
    'heroid': 'iphone15',
    'ram': '6GB',
    'rom': '128GB/256GB/512GB',
    'screensize': '6.1"',
    'color': ['Pink', 'Yellow', 'Green', 'Blue', 'Black'],
  },
  {
    'title': 'iPhone 14 Pro',
    'icon': icons.apple8,
    'description':
        'ProMotion display, A16 Bionic, and Dynamic Island. Features advanced camera capabilities, brighter display, and all-day battery. The Dynamic Island brings notifications and activities to life in a whole new way.',
    'heroid': 'iphone14pro',
    'ram': '6GB',
    'rom': '128GB/256GB/512GB/1TB',
    'screensize': '6.1"',
    'color': ['Deep Purple', 'Gold', 'Silver', 'Space Black'],
  },
  {
    'title': 'iPhone 14',
    'icon': icons.apple8,
    'description':
        'A15 Bionic, dual camera, and improved battery life. Enjoy a Super Retina XDR display, 5G connectivity, and a sleek, durable design. Night mode and Deep Fusion enhance your photos in any light.',
    'heroid': 'iphone14',
    'ram': '6GB',
    'rom': '128GB/256GB/512GB',
    'screensize': '6.1"',
    'color': ['Blue', 'Purple', 'Midnight', 'Starlight', 'Red'],
  },
  {
    'title': 'iPhone 13',
    'icon': icons.apple8,
    'description':
        'A15 Bionic, dual camera, and vibrant colors. Features Cinematic mode, Photographic Styles, and up to 19 hours of video playback. The iPhone 13 is both powerful and energy efficient.',
    'heroid': 'iphone13',
    'ram': '4GB',
    'rom': '128GB/256GB/512GB',
    'screensize': '6.1"',
    'color': ['Pink', 'Blue', 'Midnight', 'Starlight', 'Red', 'Green'],
  },
  {
    'title': 'iPhone SE (3rd Gen)',
    'icon': icons.apple8,
    'description':
        'Compact design with A15 Bionic and Touch ID. Delivers fast performance in a classic design, with 5G support and long battery life. Ideal for those who prefer a smaller phone with modern power.',
    'heroid': 'iphonese3',
    'ram': '4GB',
    'rom': '64GB/128GB/256GB',
    'screensize': '4.7"',
    'color': ['Red', 'Starlight', 'Midnight'],
  },
  {
    'title': 'iPhone 12',
    'icon': icons.apple8,
    'description':
        'A14 Bionic, OLED display, and 5G support. Features Ceramic Shield, MagSafe, and a dual-camera system for stunning photos and videos. The iPhone 12 is thin, light, and fast.',
    'heroid': 'iphone12',
    'ram': '4GB',
    'rom': '64GB/128GB/256GB',
    'screensize': '6.1"',
    'color': ['Black', 'White', 'Red', 'Green', 'Blue', 'Purple'],
  },
];

final List<Map<String, dynamic>> ipadList = [
  {
    'title': 'iPad Pro 12.9-inch (6th Gen)',
    'icon': icons.apple10,
    'description':
        'M2 chip, Liquid Retina XDR display, ProMotion, Thunderbolt, Face ID. The iPad Pro 12.9-inch is the ultimate iPad for professionals, with support for Apple Pencil and Magic Keyboard, and advanced camera and LiDAR scanner.',
    'heroid': 'ipadpro129_6th',
    'ram': '8GB/16GB',
    'rom': '128GB/256GB/512GB/1TB/2TB',
    'screensize': '12.9"',
    'color': ['Silver', 'Space Gray'],
  },
  {
    'title': 'iPad Pro 11-inch (4th Gen)',
    'icon': icons.apple10,
    'description':
        'M2 chip, Liquid Retina display, ProMotion, Thunderbolt, Face ID. The iPad Pro 11-inch is powerful and portable, perfect for creative work, gaming, and productivity on the go.',
    'heroid': 'ipadpro11_4th',
    'ram': '8GB/16GB',
    'rom': '128GB/256GB/512GB/1TB/2TB',
    'screensize': '11"',
    'color': ['Silver', 'Space Gray'],
  },
  {
    'title': 'iPad Air (5th Gen)',
    'icon': icons.apple10,
    'description':
        'M1 chip, 10.9-inch Liquid Retina display, Touch ID, USB-C. The iPad Air is thin, light, and powerful, supporting Apple Pencil and Magic Keyboard for creative and productive tasks.',
    'heroid': 'ipadair5',
    'ram': '8GB',
    'rom': '64GB/256GB',
    'screensize': '10.9"',
    'color': ['Space Gray', 'Starlight', 'Pink', 'Purple', 'Blue'],
  },
  {
    'title': 'iPad (10th Gen)',
    'icon': icons.apple10,
    'description': 'A14 Bionic, 10.9-inch display, USB-C, Touch ID on top button.',
    'heroid': 'ipad10',
    'ram': '4GB',
    'rom': '64GB/256GB',
    'screensize': '10.9"',
    'color': ['Silver', 'Blue', 'Pink', 'Yellow'],
  },
  {
    'title': 'iPad mini (6th Gen)',
    'icon': icons.apple10,
    'description': 'A15 Bionic, 8.3-inch Liquid Retina, Touch ID, USB-C.',
    'heroid': 'ipadmini6',
    'ram': '4GB',
    'rom': '64GB/256GB',
    'screensize': '8.3"',
    'color': ['Space Gray', 'Starlight', 'Pink', 'Purple'],
  },
  {
    'title': 'iPad (9th Gen)',
    'icon': icons.apple10,
    'description': 'A13 Bionic, 10.2-inch Retina display, Touch ID, Lightning.',
    'heroid': 'ipad9',
    'ram': '3GB',
    'rom': '64GB/256GB',
    'screensize': '10.2"',
    'color': ['Silver', 'Space Gray'],
  },
];

final List<Map<String, dynamic>> macbookList = [
  {
    'title': 'MacBook Pro 16-inch (M3 Max, 2023)',
    'icon': icons.apple3,
    'description': 'Apple M3 Max chip, Liquid Retina XDR display, up to 128GB RAM, up to 8TB SSD.',
    'heroid': 'mbp16_m3max',
    'ram': '36GB/48GB/64GB/96GB/128GB',
    'rom': '1TB/2TB/4TB/8TB',
    'screensize': '16.2"',
    'color': ['Space Black', 'Silver'],
  },
  {
    'title': 'MacBook Pro 14-inch (M3 Pro, 2023)',
    'icon': icons.apple3,
    'description': 'Apple M3 Pro chip, Liquid Retina XDR display, up to 36GB RAM, up to 4TB SSD.',
    'heroid': 'mbp14_m3pro',
    'ram': '18GB/36GB',
    'rom': '512GB/1TB/2TB/4TB',
    'screensize': '14.2"',
    'color': ['Space Black', 'Silver'],
  },
  {
    'title': 'MacBook Air 15-inch (M2, 2023)',
    'icon': icons.apple3,
    'description': 'Apple M2 chip, 15.3-inch Liquid Retina display, up to 24GB RAM, up to 2TB SSD.',
    'heroid': 'mba15_m2',
    'ram': '8GB/16GB/24GB',
    'rom': '256GB/512GB/1TB/2TB',
    'screensize': '15.3"',
    'color': ['Midnight', 'Starlight', 'Space Gray', 'Silver'],
  },
  {
    'title': 'MacBook Air 13-inch (M2, 2022)',
    'icon': icons.apple3,
    'description': 'Apple M2 chip, 13.6-inch Liquid Retina display, up to 24GB RAM, up to 2TB SSD.',
    'heroid': 'mba13_m2',
    'ram': '8GB/16GB/24GB',
    'rom': '256GB/512GB/1TB/2TB',
    'screensize': '13.6"',
    'color': ['Midnight', 'Starlight', 'Space Gray', 'Silver'],
  },
  {
    'title': 'MacBook Air 13-inch (M1, 2020)',
    'icon': icons.apple3,
    'description': 'Apple M1 chip, 13.3-inch Retina display, up to 16GB RAM, up to 2TB SSD.',
    'heroid': 'mba13_m1',
    'ram': '8GB/16GB',
    'rom': '256GB/512GB/1TB/2TB',
    'screensize': '13.3"',
    'color': ['Space Gray', 'Gold', 'Silver'],
  },
  {
    'title': 'MacBook Pro 13-inch (M2, 2022)',
    'icon': icons.apple3,
    'description': 'Apple M2 chip, 13.3-inch Retina display, up to 24GB RAM, up to 2TB SSD.',
    'heroid': 'mbp13_m2',
    'ram': '8GB/16GB/24GB',
    'rom': '256GB/512GB/1TB/2TB',
    'screensize': '13.3"',
    'color': ['Space Gray', 'Silver'],
  },
];
final List<Map<String, dynamic>> imacList = [
  {
    'title': 'iMac 24-inch (M3, 2023)',
    'icon': icons.apple4,
    'description': 'Apple M3 chip, 4.5K Retina display, up to 24GB unified memory.',
    'heroid': 'imac24_m3',
    'ram': '8GB/16GB/24GB',
    'rom': '256GB/512GB/1TB/2TB',
    'screensize': '24"',
    'color': ['Blue', 'Green', 'Pink', 'Silver', 'Yellow', 'Orange', 'Purple'],
  },
  {
    'title': 'iMac 24-inch (M1, 2021)',
    'icon': icons.apple4,
    'description': 'Apple M1 chip, 4.5K Retina display, up to 16GB unified memory.',
    'heroid': 'imac24_m1',
    'ram': '8GB/16GB',
    'rom': '256GB/512GB/1TB/2TB',
    'screensize': '24"',
    'color': ['Blue', 'Green', 'Pink', 'Silver', 'Yellow', 'Orange', 'Purple'],
  },
  {
    'title': 'iMac 27-inch (Intel, 2020)',
    'icon': icons.apple4,
    'description': '10th-gen Intel Core, 5K Retina display, up to 128GB RAM.',
    'heroid': 'imac27_2020',
    'ram': '8GB/16GB/32GB/64GB/128GB',
    'rom': '256GB/512GB/1TB/2TB/4TB/8TB',
    'screensize': '27"',
    'color': ['Silver'],
  },
  {
    'title': 'iMac 21.5-inch (Intel, 2019)',
    'icon': icons.apple4,
    'description': '8th-gen Intel Core, Full HD/4K Retina display, up to 32GB RAM.',
    'heroid': 'imac215_2019',
    'ram': '8GB/16GB/32GB',
    'rom': '256GB/512GB/1TB/2TB',
    'screensize': '21.5"',
    'color': ['Silver'],
  },
];

final List<Map<String, dynamic>> earbudList = [
  {
    'title': 'AirPods Pro (2nd Gen)',
    'icon': icons.apple6,
    'description':
        'Active Noise Cancellation, Adaptive Transparency, MagSafe Charging Case (USB‑C).',
    'heroid': 'airpodspro2',
    'battery': 'Up to 6 hours (earbuds), 30 hours (case)',
    'features': ['ANC', 'Transparency', 'Spatial Audio', 'MagSafe'],
    'color': ['White'],
  },
  {
    'title': 'AirPods (3rd Gen)',
    'icon': icons.apple6,
    'description': 'Spatial Audio, Adaptive EQ, MagSafe Charging Case.',
    'heroid': 'airpods3',
    'battery': 'Up to 6 hours (earbuds), 30 hours (case)',
    'features': ['Spatial Audio', 'Adaptive EQ', 'MagSafe'],
    'color': ['White'],
  },
  {
    'title': 'AirPods (2nd Gen)',
    'icon': icons.apple6,
    'description': 'Universal fit, voice-activated Siri, standard charging case.',
    'heroid': 'airpods2',
    'battery': 'Up to 5 hours (earbuds), 24 hours (case)',
    'features': ['Siri', 'Standard Charging'],
    'color': ['White'],
  },
  {
    'title': 'AirPods Max',
    'icon': icons.apple6,
    'description': 'Over-ear headphones, Active Noise Cancellation, Spatial Audio.',
    'heroid': 'airpodsmax',
    'battery': 'Up to 20 hours',
    'features': ['ANC', 'Transparency', 'Spatial Audio'],
    'color': ['Space Gray', 'Silver', 'Green', 'Sky Blue', 'Pink'],
  },
  {
    'title': 'Beats Fit Pro',
    'icon': icons.apple6,
    'description': 'Secure-fit wingtips, Active Noise Cancelling, Spatial Audio.',
    'heroid': 'beatsfitpro',
    'battery': 'Up to 6 hours (earbuds), 24 hours (case)',
    'features': ['ANC', 'Transparency', 'Spatial Audio'],
    'color': ['Black', 'White', 'Stone Purple', 'Sage Gray'],
  },
  {
    'title': 'Beats Studio Buds+',
    'icon': icons.apple6,
    'description': 'Active Noise Cancelling, Transparency, IPX4 sweat resistance.',
    'heroid': 'beatsstudiobudsplus',
    'battery': 'Up to 9 hours (earbuds), 36 hours (case)',
    'features': ['ANC', 'Transparency', 'IPX4'],
    'color': ['Black', 'Ivory', 'Transparent'],
  },
];

final List<Map<String, dynamic>> appleWatchList = [
  {
    'title': 'Apple Watch Series 9',
    'icon': icons.iwatch,
    'description': 'S9 SiP, Always-On Retina display, Double Tap gesture, up to 18 hours battery.',
    'heroid': 'watchseries9',
    'caseSize': '41mm/45mm',
    'features': ['Always-On Display', 'Double Tap', 'Blood Oxygen', 'ECG'],
    'color': ['Midnight', 'Starlight', 'Silver', 'Pink', 'Product(RED)'],
  },
  {
    'title': 'Apple Watch Ultra 2',
    'icon': icons.iwatch,
    'description': '49mm titanium case, S9 SiP, brightest display, up to 36 hours battery.',
    'heroid': 'watchultra2',
    'caseSize': '49mm',
    'features': ['Action Button', 'Depth Gauge', 'Dual-Frequency GPS', 'Night Mode'],
    'color': ['Titanium'],
  },
  {
    'title': 'Apple Watch SE (2nd Gen)',
    'icon': icons.iwatch,
    'description': 'S8 SiP, Retina display, Crash Detection, up to 18 hours battery.',
    'heroid': 'watchse2',
    'caseSize': '40mm/44mm',
    'features': ['Crash Detection', 'Swimproof', 'Cycle Tracking'],
    'color': ['Midnight', 'Starlight', 'Silver'],
  },
  {
    'title': 'Apple Watch Series 8',
    'icon': icons.iwatch,
    'description': 'S8 SiP, temperature sensing, Crash Detection, up to 18 hours battery.',
    'heroid': 'watchseries8',
    'caseSize': '41mm/45mm',
    'features': ['Temperature Sensing', 'Blood Oxygen', 'ECG', 'Crash Detection'],
    'color': ['Midnight', 'Starlight', 'Silver', 'Product(RED)'],
  },
  {
    'title': 'Apple Watch Ultra',
    'icon': icons.iwatch,
    'description': '49mm titanium case, S8 SiP, up to 36 hours battery, rugged design.',
    'heroid': 'watchultra',
    'caseSize': '49mm',
    'features': ['Action Button', 'Depth Gauge', 'Dual-Frequency GPS'],
    'color': ['Titanium'],
  },
];

final List<Map<String, dynamic>> otherappleproducts = [
  // Adapters
  {
    'title': 'Apple 5W USB Power Adapter',
    'icon': icons.apple2,
    'description': 'Compact USB power adapter for iPhone and iPod.',
    'power': '5W',
    'port': 'USB-A',
    'compatibility': ['iPhone', 'iPod', 'Apple Watch'],
    'type': 'adapter',
  },
  {
    'title': 'Apple 20W USB-C Power Adapter',
    'icon': icons.apple2,
    'description': 'Fast charging USB-C power adapter for iPhone, iPad, and AirPods.',
    'power': '20W',
    'port': 'USB-C',
    'compatibility': ['iPhone', 'iPad', 'AirPods'],
    'type': 'adapter',
  },
  // Apple Pencil
  {
    'title': 'Apple Pencil (1st Generation)',
    'icon': icons.apple1,
    'description': 'Pressure-sensitive stylus for iPad, charges via Lightning.',
    'compatibility': [
      'iPad (6th-9th Gen)',
      'iPad Air (3rd Gen)',
      'iPad mini (5th Gen)',
      'iPad Pro 12.9-inch (1st/2nd Gen)',
      'iPad Pro 10.5-inch',
      'iPad Pro 9.7-inch',
    ],
    'charging': 'Lightning',
    'type': 'pencil',
  },
  {
    'title': 'Apple Pencil (2nd Generation)',
    'icon': icons.apple1,
    'description': 'Magnetic wireless charging, double-tap for tool switching.',
    'compatibility': [
      'iPad Pro 12.9-inch (3rd Gen and later)',
      'iPad Pro 11-inch (all)',
      'iPad Air (4th Gen and later)',
      'iPad mini (6th Gen)',
    ],
    'charging': 'Magnetic',
    'type': 'pencil',
  },
  {
    'title': 'Apple Pencil (USB-C)',
    'icon': icons.apple1,
    'description': 'Affordable stylus with USB-C charging, no pressure sensitivity.',
    'compatibility': [
      'iPad (10th Gen)',
      'iPad Pro 11-inch (1st-4th Gen)',
      'iPad Pro 12.9-inch (3rd-6th Gen)',
      'iPad Air (4th/5th Gen)',
      'iPad mini (6th Gen)',
    ],
    'charging': 'USB-C',
    'type': 'pencil',
  },
  // Mouse
  {
    'title': 'Magic Mouse (1st Generation)',
    'icon': icons.iwatch,
    'description': 'Multi-Touch surface, Bluetooth, AA batteries.',
    'connection': 'Bluetooth',
    'charging': 'AA batteries',
    'compatibility': ['Mac'],
    'type': 'mouse',
  },
  {
    'title': 'Magic Mouse 2',
    'icon': icons.iwatch,
    'description': 'Rechargeable, Multi-Touch surface, Lightning charging.',
    'connection': 'Bluetooth',
    'charging': 'Lightning',
    'compatibility': ['Mac'],
    'type': 'mouse',
  },
  // iPod
  {
    'title': 'iPod Classic (6th Gen)',
    'icon': icons.apple9,
    'description': 'Hard drive-based music player, click wheel, up to 160GB.',
    'storage': '80GB/120GB/160GB',
    'color': ['Silver', 'Black'],
    'type': 'ipod',
  },
  {
    'title': 'iPod nano (7th Gen)',
    'icon': icons.apple9,
    'description': 'Multi-touch display, ultra-portable, up to 16GB.',
    'storage': '16GB',
    'color': ['Silver', 'Space Gray', 'Pink', 'Blue', 'Gold', 'Purple', 'Red'],
    'type': 'ipod',
  },
  {
    'title': 'iPod shuffle (4th Gen)',
    'icon': icons.apple9,
    'description': 'Clip-on design, physical controls, up to 2GB.',
    'storage': '2GB',
    'color': ['Silver', 'Space Gray', 'Pink', 'Blue', 'Gold', 'Purple', 'Red'],
    'type': 'ipod',
  },
  {
    'title': 'iPod touch (7th Gen)',
    'icon': icons.apple9,
    'description': 'iOS device, A10 Fusion chip, up to 256GB.',
    'storage': '32GB/128GB/256GB',
    'color': ['Space Gray', 'Silver', 'Pink', 'Blue', 'Gold', 'Red'],
    'type': 'ipod',
  },
  // Headset Max
  {
    'title': 'AirPods Max',
    'icon': icons.apple7,
    'description': 'Over-ear headphones, Active Noise Cancellation, Spatial Audio.',
    'heroid': 'airpodsmax',
    'battery': 'Up to 20 hours',
    'features': ['ANC', 'Transparency', 'Spatial Audio'],
    'color': ['Space Gray', 'Silver', 'Green', 'Sky Blue', 'Pink'],
    'type': 'headset',
  },
  // Apple Vision
  {
    'title': 'Apple Vision Pro',
    'icon': icons.apple11, // Make sure you have this icon in your icons.dart
    'description':
        'Spatial computer with visionOS, dual 4K micro-OLED displays, eye and hand tracking.',
    'heroid': 'applevisionpro',
    'chip': 'Apple M2 + R1',
    'storage': '256GB/512GB/1TB',
    'features': [
      'Spatial Computing',
      'Eye Tracking',
      'Hand Tracking',
      'Dual 4K Displays',
      'visionOS',
    ],
    'color': ['Silver'],
    'type': 'vision',
  },
];
