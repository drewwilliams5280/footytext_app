# README

This is a Rails app using the Telnyx platform to receive text messages and autorespond using the `telnyx` gem.

### How It Works

The core functionality of the app is built with a `messages_controller`, models for `contacts`, `contact_messages`, and `telnyx_messages`, and Active Record callbacks to perform model methods automatically.

When a text message is sent to the phone number associated with your Telnyx account, a webhook designated to hit a `/messages` endpoint in your app will initiate the process.

```ruby
Rails.application.routes.draw do
  resources :messages, only: :create
end
```

The controller will parse through the request and make sure the message is an "inbound" message to perform the tasks. "Outbound" messages will render `204 No Content`. A `contact` will then either be created or found in the database if it already exists, and a `contact_message` will be created.

```ruby
class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    json = JSON.parse(request.body.read)
    if json['direction'] == "inbound"
      contact = Contact.find_or_create_by(phone_number: json['from'])
      ContactMessage.create(
        contact: contact, 
        text: json['body']
      )
    end
  end
end
```

`Contacts` consist of a `phone_number` attribute and relationships with `contact_messages` and `telnyx_messages`

```ruby
class Contact < ApplicationRecord
  validates_presence_of :phone_number, require: true
  has_many :contact_messages
  has_many :telnyx_messages
end
```

When the controller creates the `contact_message`, a `respond` model method is initiated using the `after_create` Active Record callback. This model method creates a related `telnyx_message` based on the contents of `self.text`. 

```ruby
class ContactMessage < ApplicationRecord
  validates_presence_of :text, require: true
  belongs_to :contact

  after_create :respond
  def respond
    if text.downcase.include?("pizza") && text.downcase.include?("ice cream")
      TelnyxMessage.create!(contact: contact, text: "Chicago pizza is the best and I prefer gelato")
    elsif text.downcase.include?("pizza")
      TelnyxMessage.create!(contact: contact, text: "Chicago pizza is the best")
    elsif text.downcase.include?("ice cream")
      TelnyxMessage.create!(contact: contact, text: "I prefer gelato")
    else
      TelnyxMessage.create!(contact: contact, text: "Please send either the word ‘pizza’ or ‘ice cream’ for a different response")
    end
  end
end
```

When the `telnyx_message` is created, it is then immediately sent to the `contact` using a `send_message` model method, the functionality provided to us by the `telnyx` gem, and another Active Record `after_create` callback. Our ENV variables are provided to us by using [Figaro](https://github.com/laserlemon/figaro) and an `application.yml` file. 

```ruby
class TelnyxMessage < ApplicationRecord
  validates_presence_of :text, require: true
  belongs_to :contact

  after_create :send_message
  def send_message
    Telnyx.api_key = ENV['TELNYX_API_KEY']
    Telnyx::Message.create(
      from: ENV['TELNYX_PHONE_NUMBER'],
      to: contact.phone_number,
      text: text
    )
  end
end
```

### How To Run Locally

To run locally, you will need:

* A Telnyx account
* A Telnyx phone number
* A Telnyx API key
* A tunneling tool, such as [ngrok](https://developers.telnyx.com/docs/v2/development/ngrok), to connect your localhost to the internet
* Your Telnyx messaging account's webhook set to your tunnel URL/messages. (Example: `https://example-url.ngrok.io/messages`)

After the above steps are completed, clone (or fork and clone) down this repo. Run `bundle install` to install dependencies (See [gemfile](https://github.com/drewwilliams5280/telnyx_app/blob/main/Gemfile)). Run the command `bundle exec figaro install` to create your `application.yml` file. Edit your `application.yml` file to include your Telnyx phone number and API key. This gives you access to your ENV variables used above. Example:

```ruby
TELNYX_API_KEY: "Insert your API key here"
TELNYX_PHONE_NUMBER: "Insert your Telnyx phone number here"
```

Finally, run `rails db:create` and `rails db:migrate` to setup your Postgres database, and `rails s` to boot up your localhost:3000 server.

*Tip: If using ngrok, make sure to run the command `ngrok http 3000` instead of the recommended/default command in ngrok docs of `ngrok http 80` since our localhost is using port 3000*

### Testing

This app uses the `rspec` testing suite, as well as other tools such as `capybara`, `shoulda-matchers`, and `simplecov` for coverage reports. To run the tests, use the command `bundle exec rspec`. Tests that are making active API calls to Telnyx are currently skipped and can be recognized by looking for the `xit` beginning block rather that a traditional `it` block. Simply remove the `x` to run those tests.

### Helpful Links

* [Receiving SMS](https://developers.telnyx.com/docs/v2/messaging/quickstarts/receiving-sms-and-mms)
* [Receiving Webhooks](https://developers.telnyx.com/docs/v2/messaging/receiving-webhooks)
* [Sending Messages](https://developers.telnyx.com/docs/v2/messaging/quickstarts/sending-sms-and-mms)
* [Environment Setup](https://developers.telnyx.com/docs/v2/development/dev-env-setup)
* [Telnyx gem docs](https://github.com/team-telnyx)
* [developers.telnyx.com](https://developers.telnyx.com/)
