import 'package:fluro/fluro.dart';

import 'routes.dart';
import 'ui/blog/blog.dart';
import 'ui/who_am_i/who_am_i.dart';
import 'ui/splash/splash.dart';
import 'ui/blog/blog_home.dart';
import 'ui/home/home.dart';
import 'ui/editor/editor.dart';
import 'ui/userProfile/user_profile.dart';
import 'ui/login/login.dart';

class FluroRouter {
  static Router router = Router();

  static Handler _blogHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) =>
        BlogScreen(params[Routes.blogId][0]),
  );

  static Handler _splashHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => SplashScreen(),
  );

  static Handler _blogHomeHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => BlogHomeScreen(),
  );

  static Handler _homeHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => HomeScreen(),
  );
  static Handler _editorHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => EditorScreen(),
  );
  static Handler _whoAmIHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => WhoAmI(),
  );
  static Handler _loginHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => LoginScreen(),
  );
  static Handler _userProfileHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => UserProfile(),
  );

  static void setupRouter() {
    router.define(Routes.singleBlog, handler: _blogHandler);
    router.define(Routes.splash, handler: _splashHandler);
    router.define(Routes.blogs, handler: _blogHomeHandler);
    router.define(Routes.home, handler: _homeHandler);
    router.define(Routes.editor, handler: _editorHandler);
    router.define(Routes.whoAmI, handler: _whoAmIHandler);
    router.define(Routes.login, handler: _loginHandler);
    router.define(Routes.userProfile, handler: _userProfileHandler);
  }
}
