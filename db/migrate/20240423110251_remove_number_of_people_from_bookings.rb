class RemoveNumberOfPeopleFromBookings < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :number_of_people, :integer
  end
end
