def sign_in_as(user)
  post user_session_path, params: { session: { name: user.name,
                                        email: user.email,
                                        password: user.password } }
end
