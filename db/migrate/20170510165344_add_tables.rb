class AddTables < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredients do |t|
      t.column :name, :string
      t.column :quantity_available, :float
      t.column :quantity_units, :string
    end
    create_table :combos do |t|
      t.column :ingredient_id, :integer
      t.column :recipe_id, :integer
      t.column :quantity_required, :float
      t.column :quantity_units, :string
    end
    create_table :recipes do |t|
      t.column :name, :string
      t.column :instructions, :text
      t.column :rating, :integer
    end
    create_table :recipes_tags do |t|
      t.column :recipe_id, :integer
      t.column :tag_id, :integer
    end
    create_table :tags do |t|
      t.column :name, :string
    end
  end
end
