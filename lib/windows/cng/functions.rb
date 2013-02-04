require 'ffi'

module Windows
  class CNG
    class Functions
      extend FFI::Library
      ffi_lib :bcrypt

      attach_function :BCryptCloseAlgorithmProvider, [:pointer, :ulong], :ulong

      attach_function :BCryptCreateHash,
        [:pointer, :pointer, :pointer, :ulong, :pointer, :ulong, :ulong],
        :ulong

      attach_function :BCryptDecrypt,
        [:pointer, :pointer, :ulong, :pointer, :pointer, :ulong, :pointer, :ulong, :ulong, :ulong],
        :ulong

      attach_function :BCryptOpenAlgorithmProvider, [:pointer, :string, :string, :ulong], :ulong
    end
  end
end
