/* eslint-disable no-undef */
import bcrypt from 'bcrypt';

describe('password hashing', () => {
  it('should compare two passwords and return a boolean value', async () => {
    const storedPassword = 'mysecretpassword';
    const suppliedPassword = 'mysecretpassword';

    // Hash the password to simulate a stored password
    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(storedPassword, saltRounds);

    // Call the compare function and verify that it returns true
    const result = await bcrypt.compare(suppliedPassword, hashedPassword);
    expect(result).toBe(true);
  });

  it('should return false when comparing different passwords', async () => {
    const storedPassword = 'mysecretpassword';
    const suppliedPassword = 'differentpassword';

    // Hash the password to simulate a stored password
    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(storedPassword, saltRounds);

    // Call the compare function and verify that it returns false
    const result = await bcrypt.compare(hashedPassword, suppliedPassword);
    expect(result).toBe(false);
  });

  it("should return false when comparing a password that doesn't exist", async () => {
    // Call the compare function and verify that it returns false
    const result = await bcrypt.compare('nonexistentpassword', 'nonexistentpassword');
    expect(result).toBe(false);
  });
});
