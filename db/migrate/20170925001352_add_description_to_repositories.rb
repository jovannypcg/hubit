class AddDescriptionToRepositories < ActiveRecord::Migration[5.1]
  def change
    add_column :repositories, :description, :string
  end
end
