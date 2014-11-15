module Windows
  module CNGConstants
    # NTSTATUS values
    STATUS_SUCCESS                = 0x00000000
    STATUS_SEVERITY_SUCCESS       = 0x00000000
    STATUS_SEVERITY_INFORMATIONAL = 0x00000001
    STATUS_SEVERITY_WARNING       = 0x00000002
    STATUS_SEVERITY_ERROR         = 0x00000003

    # CNG Algorithm Identifiers
    BCRYPT_3DES_ALGORITHM               = "3DES"
    BCRYPT_3DES_112_ALGORITHM           = "3DES_112"
    BCRYPT_AES_ALGORITHM                = "AES"
    BCRYPT_AES_CMAC_ALGORITHM           = "AES-CMAC"
    BCRYPT_AES_GMAC_ALGORITHM           = "AES-GMAC"
    BCRYPT_CAPI_KDF_ALGORITHM           = "CAPI_KDF"
    BCRYPT_DES_ALGORITHM                = "DES"
    BCRYPT_DESX_ALGORITHM               = "DESX"
    BCRYPT_DH_ALGORITHM                 = "DH"
    BCRYPT_DSA_ALGORITHM                = "DSA"
    BCRYPT_ECDH_P256_ALGORITHM          = "ECDH_P256"
    BCRYPT_ECDH_P384_ALGORITHM          = "ECDH_P384"
    BCRYPT_ECDH_P521_ALGORITHM          = "ECDH_P521"
    BCRYPT_ECDSA_P256_ALGORITHM         = "ECDSA_P256"
    BCRYPT_ECDSA_P384_ALGORITHM         = "ECDSA_P384"
    BCRYPT_ECDSA_P521_ALGORITHM         = "ECDSA_P521"
    BCRYPT_MD2_ALGORITHM                = "MD2"
    BCRYPT_MD4_ALGORITHM                = "MD4"
    BCRYPT_MD5_ALGORITHM                = "MD5"
    BCRYPT_RC2_ALGORITHM                = "RC2"
    BCRYPT_RC4_ALGORITHM                = "RC4"
    BCRYPT_RNG_ALGORITHM                = "RNG"
    BCRYPT_RNG_DUAL_EC_ALGORITHM        = "DUALECRNG"
    BCRYPT_RNG_FIPS186_DSA_ALGORITHM    = "FIPS186DSARNG"
    BCRYPT_RSA_ALGORITHM                = "RSA"
    BCRYPT_RSA_SIGN_ALGORITHM           = "RSA_SIGN"
    BCRYPT_SHA1_ALGORITHM               = "SHA1"
    BCRYPT_SHA256_ALGORITHM             = "SHA256"
    BCRYPT_SHA384_ALGORITHM             = "SHA384"
    BCRYPT_SHA512_ALGORITHM             = "SHA512"
    BCRYPT_SP800108_CTR_HMAC_ALGORITHM  = "SP800_108_CTR_HMAC"
    BCRYPT_SP80056A_CONCAT_ALGORITHM    = "SP800_56A_CONCAT"
    BCRYPT_PBKDF2_ALGORITHM             = "PBKDF2"

    # Primitive Property Identifiers. Encode as necessary.
    BCRYPT_ALGORITHM_NAME     = "AlgorithmName"
    BCRYPT_AUTH_TAG_LENGTH    = "AuthTagLength"
    BCRYPT_BLOCK_LENGTH       = "BlockLength"
    BCRYPT_OBJECT_LENGTH      = "ObjectLength"
    BCRYPT_BLOCK_SIZE_LIST    = "BlockSizeList"
    BCRYPT_CHAINING_MODE      = "ChainingMode"
    BCRYPT_HASH_BLOCK_LENGTH  = "HashBlockLength"
    BCRYPT_HASH_LENGTH        = "HashDigestLength"
  end
end
