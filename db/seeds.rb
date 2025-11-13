User.create!(
  email: "admin@example.com",
  password: "admin1",
  password_confirmation: "admin1",
  role: :admin
)

User.create!(
  email: "john@example.com",
  password: "123456",
  password_confirmation: "123456",
  role: :trainee
)

User.create!(
  email: "maria@example.com",
  password: "password",
  password_confirmation: "password",
  role: :trainee
)