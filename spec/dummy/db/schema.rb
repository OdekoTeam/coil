# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_01_02_041225) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "btree_gist"
  enable_extension "pg_catalog.plpgsql"

  create_table "coil_inbox_completions", force: :cascade do |t|
    t.string "processor_name", null: false
    t.string "message_type", null: false
    t.jsonb "message_key", null: false
    t.bigint "last_completed_message_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["last_completed_message_id"], name: "index_coil_inbox_completions_on_last_completed_message_id"
    t.index ["processor_name", "message_type", "message_key", "last_completed_message_id"], name: "index_coil_inbox_completions_on_processor_message_completed"
    t.index ["processor_name", "message_type", "message_key"], name: "index_coil_inbox_completions_processor_message_type_key_uniq", unique: true
  end

  create_table "coil_inbox_messages", force: :cascade do |t|
    t.string "type", null: false
    t.jsonb "key", null: false
    t.jsonb "value", null: false
    t.jsonb "metadata", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_coil_inbox_messages_on_created_at"
    t.index ["type", "key"], name: "index_coil_inbox_messages_on_type_and_key"
  end

  create_table "coil_outbox_completions", force: :cascade do |t|
    t.string "processor_name", null: false
    t.string "message_type", null: false
    t.jsonb "message_key", null: false
    t.bigint "last_completed_message_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["last_completed_message_id"], name: "index_coil_outbox_completions_on_last_completed_message_id"
    t.index ["processor_name", "message_type", "message_key", "last_completed_message_id"], name: "index_coil_outbox_completions_on_processor_message_completed"
    t.index ["processor_name", "message_type", "message_key"], name: "index_coil_outbox_completions_processor_message_type_key_uniq", unique: true
  end

  create_table "coil_outbox_messages", force: :cascade do |t|
    t.string "type", null: false
    t.jsonb "key", null: false
    t.jsonb "value", null: false
    t.jsonb "metadata", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_coil_outbox_messages_on_created_at"
    t.index ["type", "key"], name: "index_coil_outbox_messages_on_type_and_key"
  end

  add_foreign_key "coil_inbox_completions", "coil_inbox_messages", column: "last_completed_message_id", name: "fk_rails_9825cbb40c_on_delete_cascade", on_delete: :cascade
  add_foreign_key "coil_outbox_completions", "coil_outbox_messages", column: "last_completed_message_id", name: "fk_rails_6651510980_on_delete_cascade", on_delete: :cascade
end
