Fabricator(:post) do
  text { Faker::Lorem.sentences }

  user(fabricator: :user)
end
