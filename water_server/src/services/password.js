import bcrypt from 'bcrypt';

class Password {
  /// This function hashes a password using bcrypt
  static async toHash(password) {
    const salt = await bcrypt.genSalt(10);
    return bcrypt.hash(password, salt);
  }

  /// This function compares a stored password with a supplied password
  static async compare(storedPassword, suppliedPassword) {
    return bcrypt.compare(storedPassword, suppliedPassword);
  }
}

export default Password;
