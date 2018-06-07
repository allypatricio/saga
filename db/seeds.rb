test_user = User.new({
  email: "test@test.com",
  password: "123456",
  password_confirmation: "123456",
  first_name: "Firstnametest",
  last_name: "Lastnametest",
})
test_user.save!

4.times do
  user = User.new({
    email: Faker::Internet.unique.email,
    password: "123456",
    password_confirmation: "123456",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    })
  user.save!
end

p "Created 5 users: test@test.com and 4 random e-mail addresses. All users have password 123456"

ADDRESSES = ["Cais do Sodre, Lisbon, Portugal", "Saldanha, Lisbon, Portugal", "Anjos, Lisbon, Portugal", "Martim Moniz, Lisbon, Portugal", "Baixa, Lisbon, Portugal", "Alfama, Lisbon,Portugal", "Graça, Lisbon, Portugal", "Belem, Lisbon, Portugal", "Avenida Liberdade, Lisbon, Portugal", "Marques Pombal, Lisbon, Portugal"]
PHOTO_URLS = [
  "https://images.unsplash.com/photo-1519789110007-0e751882be76?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=ffcb4d8d9dff9ef47b3330b7fa63b162&auto=format&fit=crop&w=1458&q=80",
  "https://images.unsplash.com/photo-1516710089018-96725b621d01?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=ca99f5235ffb5ba1ea95cc3b635d44cf&auto=format&fit=crop&w=1050&q=80",
  "https://images.unsplash.com/photo-1429962714451-bb934ecdc4ec?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=b5ecaef0464fc50a866e74a6176c3fdc&auto=format&fit=crop&w=1050&q=80",
  "https://images.unsplash.com/photo-1493807742375-fbc46d996e8f?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6f0038573a81b1169576b6674a3ce202&auto=format&fit=crop&w=1552&q=80"]

10.times do |i|
  tour = Tour.new({
    user_id: rand(1..4),
    title: Faker::Book.title,
    price: rand(5..30),
    duration: rand(1..5),
    status: 1,
    description: Faker::Lorem.words(rand(10..30)).join(" "),
    category: Tour::CATEGORIES.sample
    })
  tour.remote_photo_url = PHOTO_URLS.sample
  tour.save

  location = Location.new({
    tour_id: tour.id,
    address: ADDRESSES[i],
    story: "Location 1 story but then longer so it meets the validation",
    question: "Location 1 question",
    hint: "Location 1 hint",
    answer: "Location 1 answer",
    })
  location.save
end

p "Created 10 tours each with one location"


