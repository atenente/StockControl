Company.create!(
  name: 'empresa_admin',
  cnpj: '00000'
)

token_company = Company.find_by(cnpj: '00000').token.to_s
User.create!(
  company_id: token_company,
  email: 'admin@example.com',
  password: '123456',
  password_confirmation: '123456',
  role: 'admin'
)
