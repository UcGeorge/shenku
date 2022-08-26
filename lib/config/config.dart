import 'package:shenku/data/sources/manganelo.dart';
import 'package:shenku/data/sources/source.dart';
import 'package:shenku/data/sources/wuxia_world.dart';

const appVer = '1.0.0';
String appDir(String appDocDir) => '$appDocDir\\PGL';
String dataFileDir(String appDocDir) => '${appDir(appDocDir)}\\app-data.json';
List<BookSource> appBookSources = [Manganelo(), WuxiaWorld()];
