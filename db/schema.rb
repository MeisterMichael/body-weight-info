# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170119230827) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "uuid-ossp"

  create_table "assets", force: :cascade do |t|
    t.integer  "parent_obj_id"
    t.string   "parent_obj_type"
    t.integer  "user_id"
    t.string   "title"
    t.string   "description"
    t.text     "content"
    t.string   "type"
    t.string   "sub_type"
    t.string   "use"
    t.string   "asset_type",        default: "image"
    t.string   "origin_name"
    t.string   "origin_identifier"
    t.text     "origin_url"
    t.text     "upload"
    t.integer  "height"
    t.integer  "width"
    t.integer  "duration"
    t.integer  "status",            default: 1
    t.integer  "availability",      default: 1
    t.string   "tags",              default: [],      array: true
    t.hstore   "properties",        default: {}
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assets", ["parent_obj_id", "parent_obj_type", "asset_type", "use"], name: "swell_media_asset_use_index", using: :btree
  add_index "assets", ["parent_obj_type", "parent_obj_id"], name: "index_assets_on_parent_obj_type_and_parent_obj_id", using: :btree
  add_index "assets", ["tags"], name: "index_assets_on_tags", using: :gin

  create_table "cart_items", force: :cascade do |t|
    t.integer  "item_id"
    t.string   "item_type"
    t.integer  "quantity",   default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cart_items", ["item_id", "item_type"], name: "index_cart_items_on_item_id_and_item_type", using: :btree

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "status",     default: 1
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "parent_id"
    t.string   "name"
    t.string   "type"
    t.integer  "lft"
    t.integer  "rgt"
    t.text     "description"
    t.string   "avatar"
    t.string   "cover_image"
    t.integer  "status",       default: 1
    t.integer  "availability", default: 1
    t.integer  "seq"
    t.string   "slug"
    t.hstore   "properties",   default: {}
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["lft"], name: "index_categories_on_lft", using: :btree
  add_index "categories", ["parent_id"], name: "index_categories_on_parent_id", using: :btree
  add_index "categories", ["rgt"], name: "index_categories_on_rgt", using: :btree
  add_index "categories", ["slug"], name: "index_categories_on_slug", unique: true, using: :btree
  add_index "categories", ["type"], name: "index_categories_on_type", using: :btree
  add_index "categories", ["user_id"], name: "index_categories_on_user_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.string   "subject"
    t.text     "message"
    t.string   "type"
    t.string   "ip"
    t.string   "sub_type"
    t.string   "http_referrer"
    t.integer  "status",        default: 1
    t.hstore   "properties",    default: {}
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["email", "type"], name: "index_contacts_on_email_and_type", using: :btree

  create_table "coupon_redemptions", force: :cascade do |t|
    t.integer  "coupon_id"
    t.integer  "order_id"
    t.integer  "user_id"
    t.string   "email"
    t.integer  "applied_discount"
    t.integer  "status",           default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coupon_redemptions", ["coupon_id"], name: "index_coupon_redemptions_on_coupon_id", using: :btree
  add_index "coupon_redemptions", ["email"], name: "index_coupon_redemptions_on_email", using: :btree
  add_index "coupon_redemptions", ["order_id"], name: "index_coupon_redemptions_on_order_id", using: :btree
  add_index "coupon_redemptions", ["user_id"], name: "index_coupon_redemptions_on_user_id", using: :btree

  create_table "coupons", force: :cascade do |t|
    t.integer  "valid_for_item_id"
    t.string   "valid_for_email"
    t.string   "title"
    t.string   "code"
    t.text     "description"
    t.string   "discount_type"
    t.integer  "discount",          default: 0
    t.string   "discount_base",     default: "item"
    t.integer  "max_redemptions",   default: 1
    t.string   "duration_type",     default: "once"
    t.string   "duration_days",     default: "0"
    t.datetime "publish_at"
    t.datetime "expires_at"
    t.integer  "status",            default: 1
    t.hstore   "properties",        default: {}
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coupons", ["code"], name: "index_coupons_on_code", using: :btree
  add_index "coupons", ["valid_for_email"], name: "index_coupons_on_valid_for_email", using: :btree

  create_table "exercises", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "avatar"
    t.integer  "status"
    t.string   "description"
    t.text     "content"
    t.text     "instruction"
    t.string   "equiptment",  default: [], array: true
    t.string   "muscles",     default: [], array: true
    t.string   "tags",        default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exercises", ["equiptment"], name: "index_exercises_on_equiptment", using: :gin
  add_index "exercises", ["muscles"], name: "index_exercises_on_muscles", using: :gin
  add_index "exercises", ["name", "id"], name: "index_exercises_on_name_and_id", using: :btree
  add_index "exercises", ["slug", "id"], name: "index_exercises_on_slug_and_id", using: :btree
  add_index "exercises", ["tags"], name: "index_exercises_on_tags", using: :gin

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "geo_addresses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "geo_state_id"
    t.integer  "geo_country_id"
    t.integer  "status"
    t.string   "address_type"
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "street"
    t.string   "street2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.boolean  "preferred",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "geo_addresses", ["geo_country_id", "geo_state_id"], name: "index_geo_addresses_on_geo_country_id_and_geo_state_id", using: :btree
  add_index "geo_addresses", ["user_id"], name: "index_geo_addresses_on_user_id", using: :btree

  create_table "geo_countries", force: :cascade do |t|
    t.string   "name"
    t.string   "abbrev"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "geo_states", force: :cascade do |t|
    t.integer  "geo_country_id"
    t.string   "name"
    t.string   "abbrev"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "geo_states", ["geo_country_id"], name: "index_geo_states_on_geo_country_id", using: :btree

  create_table "media", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "managed_by_id"
    t.string   "public_id"
    t.integer  "category_id"
    t.integer  "avatar_asset_id"
    t.integer  "working_media_version_id"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "type"
    t.string   "sub_type"
    t.string   "title"
    t.string   "subtitle"
    t.text     "avatar"
    t.string   "cover_path"
    t.string   "avatar_caption"
    t.string   "layout"
    t.string   "template"
    t.text     "description"
    t.text     "content"
    t.string   "slug"
    t.string   "redirect_url"
    t.boolean  "is_commentable",           default: true
    t.boolean  "is_sticky",                default: false
    t.boolean  "show_title",               default: true
    t.datetime "modified_at"
    t.text     "keywords",                 default: [],    array: true
    t.string   "duration"
    t.integer  "cached_char_count",        default: 0
    t.integer  "cached_word_count",        default: 0
    t.integer  "status",                   default: 1
    t.integer  "availability",             default: 1
    t.datetime "publish_at"
    t.hstore   "properties",               default: {}
    t.string   "tags",                     default: [],    array: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "score",                    default: 1.0
    t.integer  "featured",                 default: 0
  end

  add_index "media", ["category_id"], name: "index_media_on_category_id", using: :btree
  add_index "media", ["featured", "category_id", "status", "publish_at", "score"], name: "index_media_on_featured_and_category_and_status_and_publish", using: :btree
  add_index "media", ["featured", "status", "publish_at", "score"], name: "index_media_on_featured_and_status_and_publish", using: :btree
  add_index "media", ["managed_by_id"], name: "index_media_on_managed_by_id", using: :btree
  add_index "media", ["public_id"], name: "index_media_on_public_id", using: :btree
  add_index "media", ["score", "category_id", "status", "publish_at"], name: "index_media_on_score_and_category_id_and_status_and_publish_at", using: :btree
  add_index "media", ["score", "status", "publish_at"], name: "index_media_on_score_and_status_and_publish_at", using: :btree
  add_index "media", ["slug", "type"], name: "index_media_on_slug_and_type", using: :btree
  add_index "media", ["slug"], name: "index_media_on_slug", unique: true, using: :btree
  add_index "media", ["status", "availability"], name: "index_media_on_status_and_availability", using: :btree
  add_index "media", ["tags"], name: "index_media_on_tags", using: :gin
  add_index "media", ["user_id"], name: "index_media_on_user_id", using: :btree

  create_table "media_versions", force: :cascade do |t|
    t.integer  "media_id"
    t.integer  "user_id"
    t.integer  "status",               default: 1
    t.json     "versioned_attributes", default: {}
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "media_versions", ["media_id", "id"], name: "index_media_versions_on_media_id_and_id", using: :btree
  add_index "media_versions", ["media_id", "status", "id"], name: "index_media_versions_on_media_id_and_status_and_id", using: :btree

  create_table "oauth_credentials", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "refresh_token"
    t.string   "secret"
    t.datetime "expires_at"
    t.integer  "status",        default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_credentials", ["provider"], name: "index_oauth_credentials_on_provider", using: :btree
  add_index "oauth_credentials", ["secret"], name: "index_oauth_credentials_on_secret", using: :btree
  add_index "oauth_credentials", ["token"], name: "index_oauth_credentials_on_token", using: :btree
  add_index "oauth_credentials", ["uid"], name: "index_oauth_credentials_on_uid", using: :btree
  add_index "oauth_credentials", ["user_id"], name: "index_oauth_credentials_on_user_id", using: :btree

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "item_id"
    t.string   "item_type"
    t.integer  "order_item_type", default: 1
    t.integer  "quantity",        default: 1
    t.integer  "amount",          default: 0
    t.string   "tax_code"
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_items", ["item_id", "item_type", "order_id"], name: "index_order_items_on_item_id_and_item_type_and_order_id", using: :btree
  add_index "order_items", ["order_item_type", "order_id"], name: "index_order_items_on_order_item_type_and_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "cart_id"
    t.integer  "billing_address_id"
    t.integer  "shipping_address_id"
    t.string   "code"
    t.string   "email"
    t.integer  "status",              default: 0
    t.integer  "total"
    t.string   "currency",            default: "USD"
    t.text     "customer_comment"
    t.datetime "fulfilled_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["code"], name: "index_orders_on_code", unique: true, using: :btree
  add_index "orders", ["email", "billing_address_id", "shipping_address_id"], name: "email_addr_indx", using: :btree
  add_index "orders", ["email", "status"], name: "index_orders_on_email_and_status", using: :btree
  add_index "orders", ["user_id", "billing_address_id", "shipping_address_id"], name: "user_id_addr_indx", using: :btree

  create_table "plans", force: :cascade do |t|
    t.integer "product_id"
    t.string  "code"
    t.integer "price",                default: 0
    t.integer "renewal_price",        default: 0
    t.string  "currency",             default: "USD"
    t.string  "tax_code"
    t.hstore  "properties",           default: {}
    t.string  "name"
    t.string  "caption"
    t.text    "description"
    t.string  "statement_descriptor"
    t.string  "interval",             default: "month"
    t.integer "interval_count",       default: 1
    t.integer "trial_period_days",    default: 0
    t.integer "status",               default: 1
  end

  add_index "plans", ["code"], name: "index_plans_on_code", unique: true, using: :btree

  create_table "products", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "title"
    t.string   "caption"
    t.string   "slug"
    t.string   "avatar"
    t.string   "fulfillment_type", default: "self"
    t.integer  "status",           default: 0
    t.text     "description"
    t.text     "content"
    t.datetime "publish_at"
    t.datetime "preorder_at"
    t.datetime "release_at"
    t.integer  "suggested_price",  default: 0
    t.integer  "price",            default: 0
    t.string   "currency",         default: "USD"
    t.integer  "inventory",        default: -1
    t.string   "tags",             default: [],     array: true
    t.string   "tax_code"
    t.hstore   "properties",       default: {}
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
  add_index "products", ["slug"], name: "index_products_on_slug", unique: true, using: :btree
  add_index "products", ["status"], name: "index_products_on_status", using: :btree
  add_index "products", ["tags"], name: "index_products_on_tags", using: :gin

  create_table "shipment_items", force: :cascade do |t|
    t.integer  "shipment_id"
    t.integer  "order_item_id"
    t.integer  "quantity",      default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shipment_items", ["shipment_id", "order_item_id"], name: "index_shipment_items_on_shipment_id_and_order_item_id", using: :btree

  create_table "shipments", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "provider"
    t.string   "reference"
    t.integer  "amount",     default: 0
    t.integer  "status",     default: 0
    t.hstore   "properties", default: {}
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shipments", ["order_id"], name: "index_shipments_on_order_id", using: :btree

  create_table "skus", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "name"
    t.string   "code"
    t.string   "tax_code"
    t.integer  "price",      default: 0
    t.integer  "inventory",  default: -1
    t.string   "currency",   default: "USD"
    t.hstore   "properties", default: {}
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skus", ["code"], name: "index_skus_on_code", unique: true, using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "status",               default: 1
    t.hstore   "properties",           default: {}
    t.integer  "plan_id"
    t.integer  "quantity",             default: 1
    t.boolean  "cancel_at_period_end"
    t.datetime "canceled_at"
    t.datetime "current_period_end"
    t.datetime "current_period_start"
    t.datetime "ended_at"
    t.datetime "start_at"
    t.datetime "trial_end_at"
    t.datetime "trail_start_at"
    t.integer  "amount",               default: 0
    t.string   "currency",             default: "USD"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "tax_rates", force: :cascade do |t|
    t.integer  "geo_state_id"
    t.float    "rate",         default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tax_rates", ["geo_state_id"], name: "index_tax_rates_on_geo_state_id", using: :btree

  create_table "transactions", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "parent_type"
    t.integer  "transaction_type"
    t.string   "provider"
    t.string   "reference"
    t.string   "message"
    t.integer  "amount",           default: 0
    t.string   "currency",         default: "USD"
    t.integer  "status",           default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["parent_id", "parent_type"], name: "index_transactions_on_parent_id_and_parent_type", using: :btree
  add_index "transactions", ["reference"], name: "index_transactions_on_reference", using: :btree
  add_index "transactions", ["status", "reference"], name: "index_transactions_on_status_and_reference", using: :btree
  add_index "transactions", ["transaction_type"], name: "index_transactions_on_transaction_type", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                  default: "",                           null: false
    t.string   "encrypted_password",     default: "",                           null: false
    t.string   "slug"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "avatar"
    t.string   "cover_image"
    t.datetime "dob"
    t.string   "gender"
    t.string   "location"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.integer  "status",                 default: 1
    t.integer  "role",                   default: 1
    t.integer  "level",                  default: 1
    t.string   "website_url"
    t.text     "bio"
    t.string   "short_bio"
    t.text     "sig"
    t.string   "ip"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "timezone",               default: "Pacific Time (US & Canada)"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "password_hint"
    t.string   "password_hint_response"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.hstore   "properties",             default: {}
    t.hstore   "settings"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "workout_segment_exercises", force: :cascade do |t|
    t.integer  "workout_segment_id"
    t.integer  "exercise_id"
    t.integer  "position",           default: 1
    t.integer  "quantity",           default: 1
    t.integer  "unit",               default: 1
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workout_segment_exercises", ["exercise_id", "position"], name: "index_workout_segment_exercises_on_exercise_and_position", using: :btree
  add_index "workout_segment_exercises", ["workout_segment_id", "position"], name: "index_workout_segment_exercises_on_segment_and_position", using: :btree

  create_table "workout_segments", force: :cascade do |t|
    t.integer  "workout_id"
    t.string   "name"
    t.integer  "segment_type"
    t.integer  "position",     default: 1
    t.integer  "rounds"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workout_segments", ["name", "id"], name: "index_workout_segments_on_name_and_id", using: :btree
  add_index "workout_segments", ["workout_id", "position"], name: "index_workout_segments_on_workout_id_and_position", using: :btree

  create_table "workouts", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "avatar"
    t.string   "description"
    t.text     "content"
    t.text     "instruction"
    t.string   "tags",        default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workouts", ["name", "id"], name: "index_workouts_on_name_and_id", using: :btree
  add_index "workouts", ["slug", "id"], name: "index_workouts_on_slug_and_id", using: :btree
  add_index "workouts", ["tags"], name: "index_workouts_on_tags", using: :gin

end
