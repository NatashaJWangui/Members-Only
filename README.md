# Members Only!

This is part of the Authentication Project in The Odin Project's Ruby on Rails Curriculum. Find it at https://www.theodinproject.com

An exclusive clubhouse where members can write anonymous posts. Inside the clubhouse, members can see who the author of a post is, but outside, they can only see the story and wonder who wrote it.

## Features

- **User Authentication**: Complete registration, login, and logout system using Devise
- **Anonymous Posts**: Anyone can read posts, but authors remain mysterious to non-members
- **Member Privileges**: Only signed-in users can see who wrote each post
- **Post Creation**: Members can create and share secret posts
- **Responsive Design**: Clean, user-friendly interface
- **Data Security**: Protected routes and secure user sessions

## Technologies Used

- **Ruby**: 3.4.4
- **Rails**: 8.0.2
- **Devise**: Authentication system
- **Database**: SQLite3 (development)
- **Frontend**: HTML, ERB templates, CSS
- **Security**: CSRF protection, secure sessions

## Live Demo

Visit the application and try these features:
1. Browse posts as a guest (authors hidden as "Secret Member")
2. Join the club to create an account
3. Sign in to reveal post authors
4. Create your own secret posts
5. Sign out to see the mysterious view again

## Installation

### Prerequisites
- Ruby 3.0 or higher
- Rails 7.0 or higher
- SQLite3
- Git

### Setup
1. **Clone the repository**
   ```bash
   git clone https://github.com/NatashaJWangui/Members-Only.git
   cd members-only
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Set up the database**
   ```bash
   rails db:migrate
   rails db:seed  # Optional: loads sample data
   ```

4. **Start the server**
   ```bash
   rails server
   ```

5. **Visit the application**
   Open your browser and navigate to `http://localhost:3000`

## Data Models

### User Model (via Devise)
```ruby
# Attributes
- email: string (unique, required)
- password: string (encrypted, required)
- name: string (required)
- created_at: datetime
- updated_at: datetime

# Associations
- has_many :posts, dependent: :destroy

# Validations
- Email: presence, uniqueness, valid format (via Devise)
- Password: minimum 6 characters (via Devise)
- Name: presence
```

### Post Model
```ruby
# Attributes
- title: string (required)
- body: text (required)
- user_id: integer (foreign key, required)
- created_at: datetime
- updated_at: datetime

# Associations
- belongs_to :user

# Validations
- Title: presence
- Body: presence
- User: must exist (foreign key constraint)
```

## Routes

| HTTP Method | Path | Controller#Action | Purpose | Authentication |
|-------------|------|------------------|---------|----------------|
| GET | / | posts#index | View all posts | Public |
| GET | /posts | posts#index | View all posts | Public |
| GET | /posts/new | posts#new | New post form | Required |
| POST | /posts | posts#create | Create post | Required |
| GET | /users/sign_up | devise/registrations#new | Registration | Public |
| POST | /users | devise/registrations#create | Create account | Public |
| GET | /users/sign_in | devise/sessions#new | Login form | Public |
| POST | /users/sign_in | devise/sessions#create | Login | Public |
| DELETE | /users/sign_out | devise/sessions#destroy | Logout | Required |

## Authentication System

### Devise Integration
```ruby
# Gemfile
gem 'devise'

# User model automatically includes:
- :database_authenticatable  # Email/password login
- :registerable             # User registration
- :recoverable             # Password reset
- :rememberable            # Remember me functionality
- :validatable             # Email/password validation
```

### Authorization Logic
```ruby
# PostsController
class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  # Only signed-in users can create posts
  # Everyone can view posts
end
```

### Conditional Content Display
```erb
<!-- Show author only to signed-in users -->
<% if user_signed_in? %>
  <strong><%= post.user.name %></strong>
<% else %>
  <strong>Secret Member</strong>
<% end %>
```

## Key Features

### 1. Public Post Reading
- Anyone can visit the site and read posts
- Post content is fully visible to all visitors
- Authors remain hidden as "Secret Member" to non-members

### 2. Member Authentication
- **Registration**: New users create accounts with name, email, password
- **Login/Logout**: Secure session management via Devise
- **Protected Routes**: Post creation requires authentication

### 3. Member Privileges
- **Author Visibility**: Signed-in users see real author names
- **Post Creation**: Only members can share new secrets
- **Personal Posts**: Users see their own posts in the list

### 4. Security Features
- **Password Encryption**: Secure password storage via bcrypt
- **CSRF Protection**: Forms protected against cross-site attacks
- **Session Security**: Secure cookie-based sessions
- **Input Validation**: Server-side validation for all user input

## User Experience Flow

### Guest User Journey
1. **Arrives at site** → Sees mysterious posts with hidden authors
2. **Reads content** → Can enjoy posts but wonders who wrote them
3. **Joins club** → Creates account to unlock member features
4. **Signs in** → Authors revealed, can create posts

### Member User Journey
1. **Signs in** → Welcomed back with personalized greeting
2. **Views posts** → Sees full author information for all posts
3. **Creates posts** → Shares secrets with the community
4. **Signs out** → Returns to mysterious view for guests

## Project Structure

```
members-only/
├── app/
│   ├── controllers/
│   │   ├── application_controller.rb     # Devise parameter configuration
│   │   └── posts_controller.rb           # Post CRUD operations
│   ├── models/
│   │   ├── user.rb                       # Devise user model
│   │   └── post.rb                       # Post model with associations
│   └── views/
│       ├── posts/
│       │   ├── index.html.erb            # Main posts listing
│       │   └── new.html.erb              # Post creation form
│       └── devise/                       # Authentication views
│           ├── registrations/
│           └── sessions/
├── config/
│   └── routes.rb                         # Devise + posts routes
├── db/
│   ├── migrate/                          # User and post migrations
│   └── seeds.rb                          # Sample data
└── README.md
```

## Sample Data

The application includes seed data with:
- 3 sample users with different personalities
- 5 sample posts covering various "secrets"
- Realistic content that demonstrates the app's purpose

Load sample data:
```bash
rails db:seed
```

## UI/UX Design

### Visual Hierarchy
- **Header Section**: Welcome message and authentication links
- **Posts Section**: Clean card-based layout for posts
- **Member Status**: Clear indication of logged-in state
- **Call-to-Action**: Prominent buttons for joining/signing in

### Responsive Elements
- **Container Layout**: Centered content with max-width
- **Card Design**: Each post in styled container with metadata
- **Button Styling**: Consistent button design across the app
- **Form Design**: Clean, accessible form layouts

## Testing

### Manual Testing Checklist

#### Authentication Flow
- [ ] Can register new account with valid information
- [ ] Cannot register with invalid email or short password
- [ ] Can sign in with valid credentials
- [ ] Cannot sign in with invalid credentials
- [ ] Can sign out successfully
- [ ] Redirected appropriately after authentication actions

#### Post Creation
- [ ] Cannot access /posts/new when signed out
- [ ] Can access /posts/new when signed in
- [ ] Cannot create post with empty fields
- [ ] Can create post with valid data
- [ ] Redirected to index after successful creation

#### Content Visibility
- [ ] Posts visible to everyone on index page
- [ ] Authors hidden ("Secret Member") when signed out
- [ ] Authors visible when signed in
- [ ] Can create posts only when signed in

#### Navigation
- [ ] All links work correctly
- [ ] Proper button states for signed in/out users
- [ ] Form submissions work as expected

### Console Testing
```ruby
# Test user creation
user = User.create(name: "Test User", email: "test@example.com", password: "password123")

# Test post creation
post = user.posts.create(title: "Test Secret", body: "This is a test secret post")

# Test associations
user.posts.count  # Should show user's posts
post.user.name    # Should show post author
```

## Security Considerations

### Authentication Security
- **Password Encryption**: Bcrypt hashing via Devise
- **Session Management**: Secure cookie-based sessions
- **CSRF Protection**: Forms protected against cross-site attacks
- **SQL Injection Prevention**: ActiveRecord parameterized queries

### Authorization
- **Route Protection**: `before_action :authenticate_user!`
- **Conditional Content**: Server-side logic for content visibility
- **User Ownership**: Posts automatically associated with current user

### Data Validation
- **Server-side Validation**: All input validated before database storage
- **Email Validation**: Valid email format required
- **Password Strength**: Minimum length requirements
- **Required Fields**: Presence validation for critical data

## Deployment Considerations

### Environment Variables
```ruby
# For production deployment
ENV['SECRET_KEY_BASE']  # Rails secret key
ENV['DATABASE_URL']     # Production database
ENV['MAILER_HOST']      # For Devise email features
```

### Database Migration
```bash
# Production deployment
rails db:migrate RAILS_ENV=production
rails assets:precompile RAILS_ENV=production
```

## Future Enhancements

### Potential Features
- **Post Categories**: Organize secrets by topic
- **User Profiles**: Extended user information and avatars
- **Post Voting**: Like/dislike system for posts
- **Comments**: Allow members to comment on posts
- **Email Notifications**: Notify users of new posts
- **Admin Panel**: Moderation tools for managing content
- **Search Functionality**: Find posts by keyword
- **Mobile App**: Native mobile application

### Technical Improvements
- **API Endpoints**: JSON API for mobile/JS clients
- **Real-time Updates**: WebSocket integration for live posts
- **Image Uploads**: Allow images in posts
- **Rich Text Editor**: Enhanced post creation experience
- **Caching**: Performance optimization for high traffic
- **Background Jobs**: Async processing for heavy operations

## Contributing

1. Fork the project
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Resources

- [Devise Documentation](https://github.com/heartcombo/devise)
- [Rails Guides - Authentication](https://guides.rubyonrails.org/security.html)
- [Rails API Documentation](https://api.rubyonrails.org/)
- [The Odin Project](https://www.theodinproject.com/)

## License

This project is for educational purposes.

## Acknowledgments

- The Odin Project for the excellent authentication curriculum
- Devise team for the powerful authentication solution
- Rails community for comprehensive security guidelines
- All developers contributing to secure web development practices

---

**Project completed as part of The Odin Project - Ruby on Rails Course**
