# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
danone = Company.create!(name: 'Danone', email: 'teste@danone.com.br')

augusto = User.create!(email: 'augusto@danone.com.br', password: '12345678')
leticia = User.create!(email: 'leticia@danone.com.br', password: '12345678')
pedro = User.create!(email: 'pedro@danone.com.br', password: '12345678')
gustavo = User.create!(email: 'gustavo@danone.com.br', password: '12345678')
marcio = User.create!(email: 'marcio@danone.com.br', password: '12345678')

  augusto_profile = Profile.create!(name: 'Augusto Souza', nick_name: 'Augusto', date_of_birth: '12/10/1984', department:'RH',
                                    role: 'Gerente de RH', company:danone, user:augusto, cpf: '755.755.510-40')
  leticia_profile = Profile.create!(name: 'Leticia Rodrigues', nick_name: 'Leticia', date_of_birth: '12/10/1998', department:'Financeiro',
                                    role: 'Analista', company:danone, user:leticia, cpf: '445.080.870-35')
  pedro_profile = Profile.create!(name: 'Pedro Alcantara', nick_name: 'Pedro', date_of_birth: '12/10/1994', department:'Marketing',
                          role: 'Gerente de Marketing', company:danone, user:pedro, cpf: '084.687.030-44')
  marcio_profile = Profile.create!(name: 'Marcio Pereira', nick_name: 'Marcio', date_of_birth: '12/10/1994', department:'TI',
                          role: 'Coordenador', company:danone, user:marcio, cpf: '234.049.140-15')

  product_augusto_note = Product.create!(name: 'Notebook', description: 'Notebook DELL de 15", Intel Core, HD 1TB, memoria  8GB',
                                    price: 2000, category: 'Eletronicos', profile: augusto_profile, company: danone, status: :enable)
  product_augusto_cadeira = Product.create!(name: 'Cadeira', description: 'Cadeira de escritório Trevalla CDE-26-1 preta con estofado do malha',
                                    price: 2000, category: 'Móveis', profile: augusto_profile, company: danone, status: :enable)
  product_augusto_pesca = Product.create!(name: 'Vara de pesca', description: 'Vara P/ Molinete Telescópica C.w 1,70m 20lb ',
                                    price: 2000, category: 'Móveis', profile: augusto_profile, company: danone, status: :enable)

  product_leticia_maquina = Product.create!(name: 'Maquina fotografica', description: 'Câmera Canon SL3 DSLR com 24.1MP, 3, Gravação em Full',
                                    price: 1500, category: 'Eletronicos', profile: leticia_profile, company: danone, status: :enable)
  product_leticia_cafe = Product.create!(name: 'Cafeteira', description: 'Cafeteira elétrica Britânia Inox cor prata 127V 1L', 
                                  price: 89, category: 'Eletrodomesticos', profile: leticia_profile, company: danone, status: :enable)
  product_leticia_bebe = Product.create!(name: 'Carrihho de bebê', description: 'Carrinho de bebê, porta treco, estofamento acolchoado, cinto com 5 pontos', 
                                    price: 500, category: 'Brinquedos e Bebês', profile: leticia_profile, company: danone, status: :enable)
  product_leticia_maquiagem = Product.create!(name: 'Kit de maquiagem', description: 'Maquiagem Kit Acessórios Makeup Beleza Moda Pincel Faixa', 
                                    price: 500, category: 'Moda e Beleza', profile: leticia_profile, company: danone, status: :enable)
                                
  product_pedro_celular = Product.create!(name: 'Smartphone', description: 'Samsung Galaxy A31 Dual SIM 128 GB, Gravação em Full',
                                  price: 1450, category: 'Eletronicos', profile: pedro_profile, company: danone, status: :enable)
  product_pedro_cama = Product.create!(name: 'Cama elastica', description: 'Cama Elástica Mini Jump Profissional 150 Kg 32 Molas Black',
                                  price: 200, category: 'Esporte e Lazer', profile: pedro_profile, company: danone, status: :enable)
  product_pedro_bola = Product.create!(name: 'Bola de basquete', description: 'Bola De Basquete Spalding Nba Fastbreak - Laranja',
                                  price: 79, category: 'Esporte e Lazer', profile: pedro_profile, company: danone, status: :enable)


  product_marcio_torradeira = Product.create!(name: 'Torradeira', description: 'Torradeira De Pães 800 Watts Smart Toast Mondial 110v',
                                  price: 105, category: 'Eletrodomesticos', profile: marcio_profile, company: danone, status: :enable)
  product_marcio_aspirador = Product.create!(name: 'Aspirador de pó', description: 'Aspirador Britânia Fama FAS1600 1L cinza e vermelho 110V', 
                                  price: 400, category: 'Eletrodomesticos', profile: marcio_profile, company: danone, status: :enable)
  product_marcio_mesa_brinq = Product.create!(name: 'Mesa de pebolin', description: 'Mesa de pebolim Braskit cor preto com bolas incluídas', 
                                  price: 170, category: 'Brinquedos e Bebês', profile: marcio_profile, company: danone, status: :enable)

  Comment.create!(body: 'Vem acompanhado com a capinha?', profile:leticia_profile, product:product_pedro_celular)
  Comment.create!(body: 'Consegue dar um desconto a vista?', profile:marcio_profile, product:product_pedro_bola)
  Comment.create!(body: 'Qual a marca?', profile:augusto_profile, product:product_leticia_maquiagem)
  Comment.create!(body: 'Quantos anos de uso?', profile:leticia_profile, product:product_augusto_cadeira)
  Comment.create!(body: 'Qual a cor da cadeira?', profile:leticia_profile, product:product_augusto_cadeira)
  Comment.create!(body: 'Poderia dar mais informações do produto?', profile:marcio_profile, product:product_augusto_cadeira)
  Comment.create!(body: 'Quantas lentes acompanham?', profile:augusto_profile, product:product_leticia_maquina)