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
  end
end
