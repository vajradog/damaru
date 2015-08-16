User.create(
  email: "admin@damaru.com",
  display_name: "Default Admin",
  password: "admin",
  role: "admin"
  )

Post.create(
  title: "Welcome to Damaru",
  body: "Step 1. Head-over to your-domain.com/sign_in | Step 2. Use email: admin@damaru and password: admin to login. Step 3: Change the default email and password. Enjoy!",
  status: "published",
  user_id: user1.id)


