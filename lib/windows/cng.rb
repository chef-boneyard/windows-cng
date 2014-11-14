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

    def initialize(algorithm = BCRYPT_SHA256_ALGORITHM, implementation = nil, flags = 0)
      @algorithm = algorithm.wincode
      @implementation = implementation ? implementation.wincode : implementation
      @flags = flags

      @handle = FFI::MemoryPointer.new(:uintptr_t)

      if BCryptOpenAlgorithmProvider(@handle, @algorithm, @implementation, @flags) < 0
        raise SystemCallError.new('BCryptOpenAlgorithmProvider', FFI.errno)
      end
    end

    def hash(data)
      hash = FFI::MemoryPointer.new(:ulong)
      result = FFI::MemoryPointer.new(:ulong)

      status = BCryptGetProperty(
        @handle,
        BCRYPT_OBJECT_LENGTH.wincode,
        hash,
        hash.size,
        result,
        0
      )

      if status < 0
        raise SystemCallError.new('BCryptGetProperty', status)
      end

      pbhash_object = HeapAlloc(GetProcessHeap(), 0, hash.read_ulong)

      if pbhash_object.null?
        raise SystemCallError.new('HeapAlloc', FFI.errno)
      end

      if pbhash_object && !pbhash_object.null?
        HeapFree(GetProcessHeap(), 0, pbhash_object)
      end
    end

    def close
      if BCryptCloseAlgorithmProvider(@handle, 0) < 0
        raise SystemCallError.new('BCryptCloseAlgorithmProvider', FFI.errno)
      end
    end
  end
end

if $0 == __FILE__
  include Windows
  cng = CNG.new
  cng.hash("stuff")
  cng.close
end
