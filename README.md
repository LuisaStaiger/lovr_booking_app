# README

This project is developed and maintained by Louise-Giraud and LuisaStaiger.

LOV+R is a web-based booking platform designed to transform festivals into unforgettable, love-filled experiences. Our innovative platform allows festival organizers to set up Love Pods, unique spaces that can be added to any festival.

See more about LOV+R: https://wearelovr.com

# FEATURES
As a user (festival guest)
- I can book a free love pod at the festival I'm attending.
- I can also see my bookings details and them.

As an admin 
- I can add new festivals and love pods to the app
- I can also update festivals and love pods details or delete them 
- I can see all the bookings and delete them.

The app has an integrated payment system (Stripe).
The images are hosted in Cloudinary.

# GETTING STARTED
Ensure you have the following installed on your local development machine:
- Ruby 3.1.2
- Rails 7.1.3.2
- PostgreSQL
- Node.js and Yarn
- ngrok

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

### Configure a webhook with nrok

1. In a new terminal window, start ngrok to tunnel HTTP traffic on port 3000 
  `ngrok http 3000`

2. Configure the webhook in Stripe `LINK/stripe-webhook` and listen to the 'checkout.session.completed' event
  
3. Add the link in development.rb `config.hosts << LINK`
