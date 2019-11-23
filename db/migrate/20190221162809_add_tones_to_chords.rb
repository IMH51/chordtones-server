class AddTonesToChords < ActiveRecord::Migration[5.2]
  def change
    add_column :chords, :tones, :string
  end
end
