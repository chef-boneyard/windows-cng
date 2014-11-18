require 'ffi'

module Windows
  module MiscFunctions
    extend FFI::Library
    ffi_lib :kernel32

    typedef :uintptr_t, :handle
    typedef :ulong, :dword

    attach_function :HeapAlloc, [:handle, :dword, :size_t], :pointer
    attach_function :HeapFree, [:handle, :dword, :pointer], :bool
    attach_function :GetProcessHeap, [], :handle
  end

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

    typedef :long, :ntstatus

    ## CNG Cryptographic Primitive Functions

    attach_function :BCryptCloseAlgorithmProvider,
      [:pointer, :ulong],
      :ntstatus

    attach_function :BCryptCreateHash,
      [:pointer, :pointer, :pointer, :ulong, :pointer, :ulong, :ulong],
      :ntstatus

    attach_function :BCryptDecrypt,
      [:pointer, :pointer, :ulong, :pointer, :pointer, :ulong, :pointer, :ulong, :ulong, :ulong],
      :ntstatus

    attach_function :BCryptDeriveKey,
      [:pointer, :string, :pointer, :pointer, :ulong, :ulong, :ulong],
      :ntstatus

    attach_function :BCryptDestroyHash, [:pointer], :ntstatus
    attach_function :BCryptDestroyKey, [:pointer], :ntstatus
    attach_function :BCryptDestroySecret, [:pointer], :ntstatus

    attach_function :BCryptDuplicateHash,
      [:pointer, :pointer, :pointer, :ulong, :ulong],
      :ntstatus

    attach_function :BCryptDuplicateKey,
      [:pointer, :pointer, :pointer, :ulong, :ulong],
      :ntstatus

    attach_function :BCryptEncrypt,
      [:pointer, :pointer, :ulong, :pointer, :pointer, :ulong, :pointer, :ulong, :ulong, :ulong],
      :ntstatus

    attach_function :BCryptExportKey,
      [:pointer, :pointer, :string, :pointer, :ulong, :ulong, :ulong],
      :ntstatus

    attach_function :BCryptFinalizeKeyPair, [:pointer, :ulong], :ntstatus
    attach_function :BCryptFinishHash, [:pointer, :pointer, :ulong, :ulong], :ntstatus
    attach_function :BCryptFreeBuffer, [:pointer], :void
    attach_function :BCryptGenerateKeyPair, [:pointer, :pointer, :ulong, :ulong], :ntstatus

    attach_function :BCryptGenerateSymmetricKey,
      [:pointer, :pointer, :pointer, :ulong, :pointer, :ulong, :ulong],
      :ntstatus

    attach_function :BCryptGenRandom, [:pointer, :pointer, :ulong, :ulong], :ntstatus

    attach_function :BCryptGetProperty,
      [:pointer, :buffer_in, :pointer, :ulong, :pointer, :ulong],
      :ntstatus

    attach_function :BCryptHashData, [:pointer, :pointer, :ulong, :ulong], :ntstatus

    attach_function :BCryptImportKey,
      [:pointer, :pointer, :string, :pointer, :pointer, :ulong, :pointer, :ulong, :ulong],
      :ntstatus

    attach_function :BCryptImportKeyPair,
      [:pointer, :pointer, :string, :pointer, :pointer, :ulong, :ulong],
      :ntstatus

    attach_function :BCryptOpenAlgorithmProvider,
      [:pointer, :buffer_in, :buffer_in, :ulong],
      :ntstatus

    attach_function :BCryptSecretAgreement,
      [:pointer, :pointer, :pointer, :ulong],
      :ntstatus

    attach_function :BCryptSetProperty,
      [:pointer, :string, :pointer, :ulong, :ulong],
      :ntstatus

    attach_function :BCryptSignHash,
      [:pointer, :pointer, :pointer, :ulong, :pointer, :ulong, :pointer, :ulong],
      :ntstatus

    attach_function :BCryptVerifySignature,
      [:pointer, :pointer, :pointer, :ulong, :pointer, :ulong, :ulong],
      :ntstatus

    begin
      attach_function :BCryptKeyDerivation,
        [:pointer, :pointer, :pointer, :ulong, :pointer, :ulong],
        :ntstatus
    rescue FFI::NotFoundError
      # Windows 8 or later
    end
  end
end
