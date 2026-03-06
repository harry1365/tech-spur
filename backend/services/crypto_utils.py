import nacl.secret
import nacl.utils

# Example of symmetric encryption using PyNaCl (Libsodium wrapper)
# In production, keys would be managed via AWS KMS or provided directly from the client.

def generate_key() -> bytes:
    """Generates a secure symmetric key."""
    return nacl.utils.random(nacl.secret.SecretBox.KEY_SIZE)

def encrypt_note(message: str, key: bytes) -> bytes:
    """Encrypts a string note."""
    box = nacl.secret.SecretBox(key)
    # The encrypt function automatically generates a random nonce
    return box.encrypt(message.encode('utf-8'))

def decrypt_note(encrypted: bytes, key: bytes) -> str:
    """Decrypts a note ciphertext."""
    box = nacl.secret.SecretBox(key)
    plaintext = box.decrypt(encrypted)
    return plaintext.decode('utf-8')
