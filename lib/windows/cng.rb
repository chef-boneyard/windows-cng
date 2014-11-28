require_relative 'cng/constants'
require_relative 'cng/functions'
require_relative 'cng/structs'
require_relative 'cng/helper'

module Windows
  class CNG
    include Windows::CNGConstants
    include Windows::CNGFunctions
    include Windows::MiscFunctions
    include Windows::CNGStructs
    include Windows::CNGHelper

    # Creates and returns a new Windows::CNG object.
    #
    # The +algorithm+ argument specifies the type of algorithm to use for the
    # various crypto methods. The default is SHA256.
    #
    # The +implementation+ identifies the specific provider to load. This is
    # the registered alias of the cryptographic primitive provider. By default
    # this is nil.
    #
    # The flags argument can be one or more of the following values:
    #
    # * BCRYPT_ALG_HANDLE_HMAC_FLAG
    # * BCRYPT_PROV_DISPATCH
    # * BCRYPT_HASH_REUSABLE_FLAG
    #
    # See the MSDN documentation for details of what each flag does.
    #
    def initialize(algorithm = BCRYPT_SHA256_ALGORITHM, implementation = nil, flags = 0)
      @algorithm = algorithm.wincode
      @implementation = implementation ? implementation.wincode : implementation
      @flags = flags

      ptr = FFI::MemoryPointer.new(:pointer)

      status = BCryptOpenAlgorithmProvider(
        ptr,
        @algorithm,
        @implementation,
        @flags
      )

      if status != 0
        raise SystemCallError.new('BCryptOpenAlgorithmProvider', status)
      end

      @handle = ptr.read_pointer

      ObjectSpace.define_finalizer(self, self.class.finalize(@handle))
    end

    def hash(data)
      cbhash_object = FFI::MemoryPointer.new(:ulong)
      cbdata = FFI::MemoryPointer.new(:ulong)

      status = BCryptGetProperty(
        @handle,
        BCRYPT_OBJECT_LENGTH.wincode,
        cbhash_object,
        cbhash_object.size,
        cbdata,
        0
      )

      if status != 0
        raise SystemCallError.new('BCryptGetProperty', status)
      end

      begin
        pbhash_object = HeapAlloc(GetProcessHeap(), 0, cbhash_object.read_ulong)

        if pbhash_object.null?
          raise SystemCallError.new('HeapAlloc', FFI.errno)
        end

        cbhash = FFI::MemoryPointer.new(:ulong)
        cbdata.clear

        status = BCryptGetProperty(
          @handle,
          BCRYPT_HASH_LENGTH.wincode,
          cbhash,
          cbhash.size,
          cbdata,
          0
        )

        if status != 0
          raise SystemCallError.new('BCryptGetProperty', status)
        end

        pbhash = HeapAlloc(GetProcessHeap(), 0, cbhash.read_ulong)

        if pbhash.null?
          raise SystemCallError.new('HeapAlloc', FFI.errno)
        end

        hhash = FFI::MemoryPointer.new(:uintptr_t)

        status = BCryptCreateHash(
          @handle,
          hhash,
          pbhash_object,
          cbhash_object.read_ulong,
          nil,
          0,
          0
        )

        if status != 0
          raise SystemCallError.new('BCryptCreateHash', status)
        end

        status = BCryptHashData(hhash, data, data.size, 0)

        if status != 0
          raise SystemCallError.new('BCryptHashData', status)
        end

        status = BCryptFinishHash(hhash, pbhash, pbhash.size, 0)

        if status != 0
          raise SystemCallError.new('BCryptFinishHash', status)
        end
      ensure
        HeapFree(GetProcessHeap(), 0, pbhash_object)
        HeapFree(GetProcessHeap(), 0, pbhash)
      end

      p hhash
    end

    def close
      status = BCryptCloseAlgorithmProvider(@handle, 0)

      if status != 0
        raise SystemCallError.new('BCryptCloseAlgorithmProvider', status)
      end
    end

    private

    # Automatically close crypto object when it goes out of scope.
    #
    def self.finalize(handle)
      proc{ BCryptCloseAlgorithmProvider(handle, 0) }
    end
  end
end

if $0 == __FILE__
  include Windows
  cng = CNG.new
  cng.hash("stuff")
  cng.close
end
