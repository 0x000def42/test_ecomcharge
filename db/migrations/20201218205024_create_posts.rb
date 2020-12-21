Hanami::Model.migration do
  change do
    create_table :posts do
      primary_key :id

      column :title, String, size: 128, null: false
      column :content, String, text: true, null: false

      column :rate_avg, Float, index: true, null: false, default: 0
      column :rate_count, Integer, null: false, default: 0
      column :rate_sum, Integer, null: false, default: 0
      column :ip, String, index: true, null: false, size: 39

      foreign_key :user_id, :users, index: true, type: Integer, on_delete: :cascade, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
