import bcrypt from 'bcrypt';


class Password {
    static async toHash(password: string) {
        const salt = await bcrypt.genSalt(10);
        return bcrypt.hash(password, salt);
    }

    static async compare(storedPassword: string, suppliedPassword: string) {
        return bcrypt.compare(storedPassword, suppliedPassword);
    }

}


export default Password;