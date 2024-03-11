enum AppRoutes {
  splash(name: 'splash', path: '/'),
  home(name: 'home', path: '/home'),
  signin(name: 'signin', path: '/signin'),
  signup(name: 'signup', path: '/signup'),
  signupDetails(name: 'details', path: 'details'),
  recoverPassword(name: 'recoverpassword', path: '/recoverpassword');

  const AppRoutes({
    required this.name,
    required this.path,
  });

  final String name;
  final String path;
}
