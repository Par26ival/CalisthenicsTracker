User.create!(
  username: "Admin",
  email: "admin@example.com",
  password: "admin1",
  password_confirmation: "admin1",
  role: :admin
)

User.create!(
  username: "Pederakis Manafakis",
  email: "pederakis@manafakis.com",
  password: "SPYRALex67",
  password_confirmation: "SPYRALex67",
  role: :trainee
)

User.create!(
  username: "Maria",
  email: "maria@example.com",
  password: "password",
  password_confirmation: "password",
  role: :trainee
)