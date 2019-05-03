class ChangeCulumnStripeAccountId < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :bongloy_account_id, :bongloy_account_id
  end
end
