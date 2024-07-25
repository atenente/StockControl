Company.create!(
  name: 'empresa_admin',
  cnpj: '00000'
)

token_company = Company.first.token.to_s
User.create!(
  company_token: token_company,
  email: 'admin@example.com',
  password: '123456',
  password_confirmation: '123456',
  role: 'admin'
)
