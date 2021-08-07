# == Schema Information
#
# Table name: bands
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_bands_on_name  (name)
#
require 'test_helper'

class BandTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
