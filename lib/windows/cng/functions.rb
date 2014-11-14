require 'ffi'

module Windows
  module SSLProviderFunctions
  end

  module KeyStorageFunctions
  end

  module HelperFunctions
  end

  module DPAPIFunctions
    extend FFI::Library
    ffi_lib :ncrypt

    typedef :uintptr_t, :handle
    typedef :ulong, :ntstatus
    typedef :ulong, :dword

    # CNG Data Protection API Functions - Windows 8 or later

    #attach_function :NCryptCreateProtectionDescriptor, [:buffer_in, :dword, :pointer], :ntstatus
    #attach_function :NCryptCloseProtectionDescriptor
    #attach_function :NCryptGetProtectionDescriptorInfo
    #attach_function :NCryptProtectSecret
    #attach_function :NCryptQueryProtectionDescriptorName
    #attach_function :NCryptRegisterProtectionDescriptorName
    #attach_function :NCryptStreamClose
    #attach_function :NCryptStreamOpenToProtect
    #attach_function :NCryptStreamOpenToUnProtect
    #attach_function :NCryptStreamUpdate
    #attach_function :NCryptUnprotectSecret
    #attach_function :PFNCryptStreamOutputCallback
  end

  module CNGFunctions
    extend FFI::Library
    ffi_lib :bcrypt

    ## CNG Cryptographic Primitive Functions

    attach_function :BCryptCloseAlgorithmProvider,
      [:pointer, :ulong],
      :ulong

    attach_function :BCryptCreateHash,
      [:pointer, :pointer, :pointer, :ulong, :pointer, :ulong, :ulong],
      :ulong

    attach_function :BCryptDecrypt,
      [:pointer, :pointer, :ulong, :pointer, :pointer, :ulong, :pointer, :ulong, :ulong, :ulong],
      :ulong

    attach_function :BCryptDeriveKey,
      [:pointer, :string, :pointer, :pointer, :ulong, :ulong, :ulong],
      :ulong

    attach_function :BCryptDestroyHash, [:pointer], :ulong
    attach_function :BCryptDestroyKey, [:pointer], :ulong
    attach_function :BCryptDestroySecret, [:pointer], :ulong

    attach_function :BCryptDuplicateHash,
      [:pointer, :pointer, :pointer, :ulong, :ulong],
      :ulong

    attach_function :BCryptDuplicateKey,
      [:pointer, :pointer, :pointer, :ulong, :ulong],
      :ulong

    attach_function :BCryptEncrypt,
      [:pointer, :pointer, :ulong, :pointer, :pointer, :ulong, :pointer, :ulong, :ulong, :ulong],
      :ulong

    attach_function :BCryptExportKey,
      [:pointer, :pointer, :string, :pointer, :ulong, :ulong, :ulong],
      :ulong

    attach_function :BCryptFinalizeKeyPair, [:pointer, :ulong], :ulong
    attach_function :BCryptFinishHash, [:pointer, :pointer, :ulong, :ulong], :ulong
    attach_function :BCryptFreeBuffer, [:pointer], :void
    attach_function :BCryptGenerateKeyPair, [:pointer, :pointer, :ulong, :ulong], :ulong

    attach_function :BCryptGenerateSymmetricKey,
      [:pointer, :pointer, :pointer, :ulong, :pointer, :ulong, :ulong],
      :ulong

    attach_function :BCryptGenRandom, [:pointer, :pointer, :ulong, :ulong], :ulong

    attach_function :BCryptGetProperty,
      [:pointer, :string, :pointer, :ulong, :pointer, :ulong],
      :ulong

    attach_function :BCryptHashData, [:pointer, :pointer, :ulong, :ulong], :ulong

    attach_function :BCryptImportKey,
      [:pointer, :pointer, :string, :pointer, :pointer, :ulong, :pointer, :ulong, :ulong],
      :ulong

    attach_function :BCryptImportKeyPair,
      [:pointer, :pointer, :string, :pointer, :pointer, :ulong, :ulong],
      :ulong

    attach_function :BCryptOpenAlgorithmProvider,
      [:pointer, :string, :string, :ulong],
      :ulong

    attach_function :BCryptSecretAgreement,
      [:pointer, :pointer, :pointer, :ulong],
      :ulong

    attach_function :BCryptSetProperty,
      [:pointer, :string, :pointer, :ulong, :ulong],
      :ulong

    attach_function :BCryptSignHash,
      [:pointer, :pointer, :pointer, :ulong, :pointer, :ulong, :pointer, :ulong],
      :ulong

    attach_function :BCryptVerifySignature,
      [:pointer, :pointer, :pointer, :ulong, :pointer, :ulong, :ulong],
      :ulong

    begin
      attach_function :BCryptKeyDerivation,
        [:pointer, :pointer, :pointer, :ulong, :pointer, :ulong],
        :ulong
    rescue FFI::NotFoundError
      # Windows 8 or later
    end
  end
end
