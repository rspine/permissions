# Spine::Permissions

[![Gem Version](https://badge.fury.io/rb/spine-permissions.svg)](http://badge.fury.io/rb/spine-permissions)
[![Dependency Status](https://gemnasium.com/rspine/permissions.svg)](https://gemnasium.com/rspine/permissions)
[![Test Coverage](https://codeclimate.com/github/rspine/permissions/badges/coverage.svg)](https://codeclimate.com/github/rspine/permissions/coverage)
[![Code Climate](https://codeclimate.com/github/rspine/permissions/badges/gpa.svg)](https://codeclimate.com/github/rspine/permissions)


## Installation

To install it, add the gem to your Gemfile:

```ruby
gem 'spine-permissions'
```

Then run `bundle`. If you're not using Bundler, just `gem install spine-permissions`.

## Usage

Global permissions

```ruby
permissions = Spine::Permissions::Collection.new
permissions.grant(:all, :all)
  .deny(:all, :projects)
  .deny(:write, :tasks)

permissions.granted?(:read, :projects)
# => false
permissions.denied?(:write, :tasks)
# => true
```

Role based permissions

```ruby
roles = Spine::Permissions::Roles.new
roles.define(:user)
  .grant(:all, :all)
  .deny(:all, :projects)
  .deny(:write, :tasks)

roles.define(:admin)
  .grant(:all, :all)

roles.granted?(:user, :read, :tasks)
# => true
roles.denied?(:admin, :write, :tasks)
# => false
```
