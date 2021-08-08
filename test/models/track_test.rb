# == Schema Information
#
# Table name: tracks
#
#  id         :bigint           not null, primary key
#  bonus      :boolean          default(FALSE), not null
#  lyrics     :text
#  ord        :integer          not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  album_id   :integer          not null
#
# Indexes
#
#  index_tracks_on_album_id  (album_id)
#
require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
