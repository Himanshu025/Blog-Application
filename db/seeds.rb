5.times do
  a1 = Article.create({title: Faker::Book.title, text: Faker::Lorem.sentence})
  10.times do
    Comment.create({article_id: a1.id, commenter: Faker::HarryPotter.character, body: Faker::HarryPotter.quote})	
  end
end