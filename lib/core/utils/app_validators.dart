class AppValidators {
 static String? Function(String?)? emailValidator=(value) {
  if (value == null || value.isEmpty) {
   return 'Please enter your email';
  }
  final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value);

  return emailValid ? null : 'Please enter a valid email address';
 };
 static String? Function(String?)? passValidator=(value) {
  if (value == null || value.isEmpty) {
   return 'Password cannot be empty';
  }
  if (value.length < 8) {
   return 'Password must be at least 8 characters long';
  }
  return null ;
 };
 static String? Function(String?)? generalValidator=(value,) {
  if (value == null || value.isEmpty) {
   return 'field is required be empty';
  }

  return null ;
 };

}