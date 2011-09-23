require 'factory_girl'

#Factory.class_eval do
  #def attach(name, path, content_type = nil)
    #if content_type
      #add_attribute name, ActionController::TestUploadedFile.new("#{RAILS_ROOT}/#{path}", content_type)
    #else
      #add_attribute name, ActionController::TestUploadedFile.new("#{RAILS_ROOT}/#{path}")
    #end
  #end
#end

Factory.sequence :email do |n|
  "email#{n}@factory.com"
end

Factory.define :user do |f|
  f.email{Factory.next(:email)}
  f.password "test123"
end

Factory.define :project do |f|
  f.title "example project"
end

Factory.define :mock_list do |f|
  f.title "example mock list"
  f.project
end

Factory.define :mock do |f|
  f.title "example mock"
  f.description "this is an example"
  f.image_file_name "abe_lincoln.png"
  f.path "/some/path/to/Rome"
  f.author {|a| a.association(:user)}
  f.association :mock_list, :factory=> :mock_list
end

Factory.define :mock_view do |f|
  f.mock
end

Factory.define :comment do |f|
  f.text "nice pic of the bird man"
  f.association :author, :factory=>:user
  f.association :mock, :factory=> :mock
end
