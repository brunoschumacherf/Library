class CreateLibraries < ActiveRecord::Migration[6.1]
  def change
    create_table :libraries do |t|
      t.string :title
      t.string :author
      t.string :gender
      t.boolean :read
      t.string :note
      t.text :review
      t.string :user

      t.timestamps
    end
  end
end
