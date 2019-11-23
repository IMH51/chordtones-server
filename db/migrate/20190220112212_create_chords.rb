class CreateChords < ActiveRecord::Migration[5.2]
  def change
    create_table :chords do |t|
      t.string :chord_name
      t.string :string_1
      t.string :string_2
      t.string :string_3
      t.string :string_4
      t.string :string_5
      t.string :string_6
      t.string :finger_1
      t.string :finger_2
      t.string :finger_3
      t.string :finger_4
      t.string :finger_5
      t.string :finger_6
      t.integer :user_id

      t.timestamps
    end
  end
end
