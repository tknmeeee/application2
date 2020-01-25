class RemoveUserProfileImageFromBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :user_profile_image, :integer
  end
end
