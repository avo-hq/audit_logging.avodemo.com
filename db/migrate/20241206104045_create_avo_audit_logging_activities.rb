class CreateAvoAuditLoggingActivities < ActiveRecord::Migration[7.2]
  def change
    create_table :avo_audit_logging_activities do |t|
      t.string :activity_class
      t.string :action
      t.bigint :author_id
      t.string :author_type
      t.text :payload

      t.timestamps
    end

    create_table :avo_audit_logging_activity_pivots do |t|
      t.references :activity, null: false
      t.references :record, polymorphic: true, null: false
      t.references :activity_pivot, polymorphic: true, null: true

      t.timestamps
    end
  end
end
