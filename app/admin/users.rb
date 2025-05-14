ActiveAdmin.register User do
    permit_params :role, :business_verified
  
    index do
      selectable_column
      id_column
      column :email
      column :role
      column :business_verified
      actions
    end
  
    form do |f|
      f.inputs do
        f.input :email
        f.input :role, as: :select, collection: ["viewer", "business"]
        f.input :business_verified
      end
      f.actions
    end
  end
  