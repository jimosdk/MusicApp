# == Schema Information
#
# Table name: albums
#
#  id         :bigint           not null, primary key
#  live       :boolean          default(FALSE), not null
#  title      :string           not null
#  year       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  band_id    :integer          not null
#
# Indexes
#
#  index_albums_on_band_id  (band_id)
#
require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
