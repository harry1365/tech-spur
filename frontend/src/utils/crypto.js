import nacl from 'tweetnacl';
import naclUtil from 'tweetnacl-util';

export const setupCrypto = async () => {
    // tweetnacl is synchronous, no init needed. 
    // Generate a random 32-byte key for secretbox
    const key = nacl.randomBytes(nacl.secretbox.keyLength);
    return { key };
};

export const encryptText = (text, key) => {
    if (!key) throw new Error("Key not initialized");

    const nonce = nacl.randomBytes(nacl.secretbox.nonceLength);
    const messageUint8 = naclUtil.decodeUTF8(text);
    const box = nacl.secretbox(messageUint8, nonce, key);

    const fullMessage = new Uint8Array(nonce.length + box.length);
    fullMessage.set(nonce);
    fullMessage.set(box, nonce.length);

    return naclUtil.encodeBase64(fullMessage);
};

export const decryptText = (messageWithNonceBase64, key) => {
    if (!key) throw new Error("Key not initialized");

    const messageWithNonceAsUint8Array = naclUtil.decodeBase64(messageWithNonceBase64);
    const nonce = messageWithNonceAsUint8Array.slice(0, nacl.secretbox.nonceLength);
    const message = messageWithNonceAsUint8Array.slice(
        nacl.secretbox.nonceLength,
        messageWithNonceBase64.length
    );

    const decrypted = nacl.secretbox.open(message, nonce, key);

    if (!decrypted) {
        throw new Error("Could not decrypt message");
    }

    return naclUtil.encodeUTF8(decrypted);
};
