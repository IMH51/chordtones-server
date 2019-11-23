class ChordSerializer < ActiveModel::Serializer
  attributes :id, :chord_name, :string_1, :string_2, :string_3, :string_4, :string_5, :string_6, :finger_1, :finger_2, :finger_3, :finger_4, :finger_5, :finger_6, :tones, :user_id
end
