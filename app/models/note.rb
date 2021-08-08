# == Schema Information
#
# Table name: notes
#
#  id          :bigint           not null, primary key
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  track_id    :integer          not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_notes_on_track_id  (track_id)
#  index_notes_on_user_id   (user_id)
#
class Note < ApplicationRecord
    validates :description,presence: true

    belongs_to :track  

    belongs_to :user 
end
