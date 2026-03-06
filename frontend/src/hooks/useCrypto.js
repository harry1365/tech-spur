import { useState, useEffect } from 'react';
import { setupCrypto, encryptText, decryptText } from '../utils/crypto';

// Custom hook to manage client-side cryptography
export function useCrypto() {
    const [isReady, setIsReady] = useState(false);
    const [encryptionKey, setEncryptionKey] = useState(null);

    useEffect(() => {
        async function init() {
            const { key } = await setupCrypto();
            setEncryptionKey(key);
            setIsReady(true);
        }
        init();
    }, []);

    const encrypt = (text) => {
        if (!isReady) throw new Error("Crypto not ready");
        return encryptText(text, encryptionKey);
    };

    const decrypt = (ciphertext) => {
        if (!isReady) throw new Error("Crypto not ready");
        return decryptText(ciphertext, encryptionKey);
    };

    return { encrypt, decrypt, isReady };
}
