Hanami::Model.migration do
  change do
    create_table :rates do
      primary_key :id

      foreign_key :post_id, :posts, type: Integer, on_delete: :cascade, null: false

      column :value, Integer, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
