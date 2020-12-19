Hanami::Model.migration do
  change do
    create_table :posts do
      primary_key :id

      column :title, String, size: 128, null: false
      column :content, String, text: true, null: false

      column :rate_avg, Numeric, null: false, default: 0
      column :rage_count, Integer, null: false, default: 0
      column :ip, String, null: false, size: 39

      foreign_key :user_id, :users

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
