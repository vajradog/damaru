Fabricator(:user) do
  display_name { Faker::Name.name }
  email { Faker::Internet.email }
  password { Faker::Internet.password }
end
