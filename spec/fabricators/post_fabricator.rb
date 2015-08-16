Fabricator(:post) do
  title { Faker::Lorem.sentence }
  body { Faker::Lorem.paragraph(5)}
end
