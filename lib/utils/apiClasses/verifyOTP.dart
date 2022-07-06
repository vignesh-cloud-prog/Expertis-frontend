class ChangePasswordArguments {
  final String hash;
  final String id;
  String? otp;

  ChangePasswordArguments(this.hash, this.id);
}
