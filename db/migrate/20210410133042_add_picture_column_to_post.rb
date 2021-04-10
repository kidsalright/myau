class AddPictureColumnToPost < ActiveRecord::Migration[6.1]
  def up
    add_attachment :posts, :picture
  end

  def down
    remove_attachment :posts, :picture
  end
end
