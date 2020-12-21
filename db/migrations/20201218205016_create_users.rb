Hanami::Model.migration do
  change do
    create_table :users do
      primary_key :id

      column :login, String, index: true, null: false, unique: true, size: 32

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
