require_relative 'cng/constants'
require_relative 'cng/functions'
require_relative 'cng/structs'
require_relative 'cng/helper'

module Windows
  class CNG
    include Windows::CNGConstants
    include Windows::CNGFunctions
    include Windows::CNGStructs
    include Windows::CNGHelper

    def initialize(algorithm = BCRYPT_SHA256_ALGORITHM, implementation = nil, flags = 0)
      @algorithm = algorithm
      @implementation = implementation
      @flags = flags

      @handle = FFI::MemoryPointer.new(:void)

      if BCryptOpenAlgorithmProvider(@handle, @algorithm, @implementation, @flags) < 0
        raise SystemCallError.new('BCryptOpenAlgorithmProvider', FFI.errno)
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
  cng.close
end
