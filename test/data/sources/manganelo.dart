import 'package:shenku/data/sources/manganelo.dart';

void main() async {
  final Manganelo manganelo = Manganelo();
  print(await manganelo.getHomePage());
}
