import bcrypt from 'bcrypt';

class Password {
  static async toHash(password) {
    const salt = await bcrypt.genSalt(10);
    return bcrypt.hash(password, salt);
  }

  static async compare(storedPassword, suppliedPassword) {
    return bcrypt.compare(suppliedPassword, storedPassword);
  }
}

export default Password;
