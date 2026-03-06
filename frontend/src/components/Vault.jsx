import React, { useState } from 'react';
import { useCrypto } from '../hooks/useCrypto';

export default function Vault() {
    const { encrypt, decrypt, isReady } = useCrypto();
    const [note, setNote] = useState('');
    const [encryptedNote, setEncryptedNote] = useState('');

    const handleSave = () => {
        if (isReady && note) {
            const encrypted = encrypt(note);
            setEncryptedNote(encrypted);
            setNote(''); // Clear input
        }
    };

    return (
        <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-100">
            <h2 className="text-xl font-bold mb-4 text-gray-800">Zero-Knowledge Notes Vault</h2>
            <div className="space-y-4">
                <textarea
                    className="w-full p-3 border border-gray-200 rounded-lg focus:ring-2 focus:ring-green-500 outline-none"
                    rows="3"
                    placeholder="Store your project ideas securely..."
                    value={note}
                    onChange={(e) => setNote(e.target.value)}
                />
                <button
                    onClick={handleSave}
                    disabled={!isReady}
                    className="px-4 py-2 bg-green-600 text-white font-medium rounded-lg hover:bg-green-700 transition disabled:opacity-50"
                >
                    {isReady ? 'Encrypt & Save' : 'Loading Crypto...'}
                </button>

                {encryptedNote && (
                    <div className="mt-4 p-4 bg-gray-50 border border-gray-200 rounded-lg break-all">
                        <h3 className="text-sm font-semibold text-gray-500 mb-1">Encrypted Ciphertext (Simulated Local Storage)</h3>
                        <p className="font-mono text-xs text-gray-600">{encryptedNote}</p>
                    </div>
                )}
            </div>
        </div>
    );
}
