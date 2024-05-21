# README

This project is developed and maintained by Louise-Giraud and LuisaStaiger.

LOV+R is a web-based booking platform designed to transform festivals into unforgettable, love-filled experiences. Our innovative platform allows festival organizers to set up Love Pods, unique spaces that can be added to any festival.

# FEATURES
- Festival and Love Pod Setup: Festival organizers can easily set up festivals and add Love Pods to them. Each Love Pod is a unique space within the festival, offering a different experience.
- Viewing and Booking: Users can browse through the various festivals, view the Love Pods available in each festival, and check the available slots. They can then book a slot in a Love Pod of their choice.
- Integrated Payment System: Our platform integrates with Stripe, allowing users to make seamless reservations for their chosen Love Pod slots.

Through LOV+R, we aim to enhance the festival experience, making it more enjoyable and memorable for everyone involved.

# GETTING STARTED 
Ensure you have the following installed on your local development machine:
- Ruby 3.1.2
- Rails 7.1.3.2
- PostgreSQL

# INSTALLATION 
1. Clone the repository
  `git clone https://github.com/yourgithubusername/lovr_booking_app.git`
  `git clone https://github.com/yourgithubusername/lovr_booking_app.git`
  `cd lovr_booking_app`

2. Check your Ruby version
  `ruby -v`

  The ouput should start with ruby 3.1.2
  If not, install the right ruby version using rbenv (it could take a while):
  `rbenv install 3.1.2`

3. Check your Rails version
  `rails -v`

  The output should start with Rails 7.1.3.2
  If not, install the right Rails version:
  `gem install rails -v 7.1.3.2`

4. Install dependencies
  Using Bundler and Yarn:
  `bundle && yarn`

5. Initialize the database
  `rails db:create db:migrate`

6. Run the server
  `rails s`

You should now be able to access the app at http://localhost:3000


Run the server

rails s
You should now be able to access the app at http://localhost:3000
