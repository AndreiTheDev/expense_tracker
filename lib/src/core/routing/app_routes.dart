enum AppRoutes {
  splash(name: 'splash', path: '/'),
  home(name: 'home', path: '/home'),
  signin(name: 'signin', path: '/signin'),
  signup(name: 'signup', path: '/signup'),
  signupDetails(name: 'details', path: 'details'),
  recoverPassword(name: 'recoverpassword', path: '/recoverpassword'),
  signOut(name: 'signout', path: 'signout'),
  addTransactions(name: 'addtransactions', path: 'addtransactions'),
  viewall(name: 'viewall', path: 'viewall'),
  allAccounts(name: 'allAccounts', path: 'allAccounts');

  const AppRoutes({
    required this.name,
    required this.path,
  });

  final String name;
  final String path;
}
