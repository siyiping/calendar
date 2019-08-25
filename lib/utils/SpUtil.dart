
import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
    static SpUtil _instance;
    static SharedPreferences _spf;

    SpUtil._();

    static Future<SpUtil> get instance async{
        return await getInstance();
    }

    static Future<SpUtil> getInstance() async{
        if (_instance == null) {
            _instance = new SpUtil._();
            _instance.init();
        }
        return _instance;
    }

    Future init() async{
         _spf = await SharedPreferences.getInstance();
    }
}