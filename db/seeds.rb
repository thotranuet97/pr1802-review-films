User.create!(name:  "123",
  email: "123@123.com",
  password: "123123",
  password_confirmation: "123123",
  admin: true)

30.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@domain.com"
  password = "password"
  User.create!(name:  name,
    email: email,
    password: password,
    password_confirmation: password)
end

10.times do |n|
  name = "catcat#{n+1}"
  Category.create!(name: name)
end

users = User.order(:created_at).take(6)
10.times do
  users.each do |user|
    film = user.films.create!(name: Faker::Lorem.sentence(1),
      introduction: Faker::Lorem.sentence(2),
      trailer: "https://www.youtube.com/watch?v=EXeTwQWrcwY",
      directors: Faker::Lorem.word,
      actors: Faker::Lorem.word,
      country: Faker::Address.country_code,
      release_date: Faker::Date.between(5.years.ago, 1.month.from_now),
      duration: Faker::Number.between(30, 240))
    FilmCategory.create!(category: Category.offset(rand(Category.count)).first,
      film: film)
    FilmCategory.create!(category: Category.offset(rand(Category.count)).first,
      film: film)
  end
end

users = User.order(:created_at).take(6)
films = Film.all.take(6)
users.zip(films).each do |user, film|
  film.create_review!(title: Faker::Lorem.sentence(1),
    content: Faker::Lorem.paragraph(5),
    user_id: user.id)
end
