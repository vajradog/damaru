Fabricator(:general_setting) do
  title  { Faker::Lorem.word }
  header { Faker::Lorem.word }
  subheader { Faker::Lorem.sentence }
end

