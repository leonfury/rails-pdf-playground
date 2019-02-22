class CreateResumes < ActiveRecord::Migration[5.2]
    def change
        create_table :resumes do |t|
            t.string :name, null: false
            t.string :phone, null: false
            t.text :address, null: false
            t.text :description, null: false
            t.text :objective, null: false
            t.text :experience, null: false
            t.text :photo, null: false
            t.timestamps
        end
    end
end
