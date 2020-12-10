import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:when/main.dart';
import 'package:when/theme/change_theme.dart';
import 'package:when/theme/theme.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  final introKey = GlobalKey<IntroductionScreenState>();
  void _changeTheme(BuildContext buildContext, MyThemeKeys key) {
    CustomTheme.instanceOf(buildContext).changeTheme(key);
  }

  SharedPreferences _prefs;
  String id;

  sharedSetPreference() async {
    _prefs = await SharedPreferences.getInstance();

    _prefs.setString("intro","1");
  }

  void _onIntroEnd(context) {
    sharedSetPreference();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => Splash()),
    );
  }


  Widget _buildImageJpg(String assetName) {
    return Align(
      child: Image.asset('images/$assetName.jpg', width: 350.0, fit: BoxFit.fill,),
      alignment: Alignment.bottomCenter,
    );
  }
  Widget _buildImageJpeg(String assetName) {
    return Align(
      child: Image.asset('images/$assetName.jpeg', width: 350.0,fit: BoxFit.fitHeight,),
      alignment: Alignment.bottomCenter,
    );
  }


  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {

    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(

      key: introKey,
      pages: [
        PageViewModel(
          bodyWidget:  Container(
            margin: EdgeInsets.only(top: 200),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  height: 50,
                  width: 150,
                  child: RaisedButton(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                    ),
                    onPressed: () {
                      _changeTheme(context, MyThemeKeys.LIGHT);
                    },
                    child: Text("Gündüz Modu"),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  width: 150,
                  height: 50,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                    ),
                    onPressed: () {
                      _changeTheme(context, MyThemeKeys.DARK);
                    },
                    child: Text("Gece Modu"),
                  ),
                ),
              ],
            ),
          ),
          footer:  Text("Temanı Belirle",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800),),
          title: "",
         

          decoration: pageDecoration,
        ),
        PageViewModel(

          title: "WHEN NEDIR?",
          body:
          "İş, okul monoton bir hayat ve on binlerce aktivite hepsi yakınında gerçekleşiyor. Peki, ne zaman? Çevrende ki etkinlik ve eğlencelere tek uygulama ile yakın ol."
              "  ",
          image: _buildImageJpg('try33.'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Etkinlikleri Favorilerine Kaydedebilirsin",
          body:
          "Kalp ikonuna dokunduğunuzda favorilerinize ekleyecek ve uzun süre kalp ikonuna bastığınızda ise favorilerden kaldıracaktır ",
          image: _buildImageJpeg('hause'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Detay Sayfası",
          body:
          "Sende Kendine 'Hangi günde hangi mekanda nasıl bir etkinlik var, yarın hangi konser var ya da nerede hangi parti var?' Diye Soruyorsan Discover Sayfası Sana"
              " İleri Tarihli Etkinlikleri Göstericektir ve ayrıca Bu etkinliği favorilerine ekleyen kişileri de gösterecektir.  ",
          image: _buildImageJpeg('discover'),
          decoration: pageDecoration,
        ),
        PageViewModel(

          title: "Ayarlar Sayfası",
          body: "Profilini düzenleyebilir, Modunu seçebilir ve Favorilerini görebilirsin ",
          image: _buildImageJpeg('detail'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title:  "Nerde, ne zaman, nasıl eğlenmek istediğini en iyi sen bilirsin.",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Image.asset('images/ws.png', width: 90.0,fit: BoxFit.fitHeight,),
            ],
          ),
          image: _buildImageJpg('img1'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text(''),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Tamamla', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}

