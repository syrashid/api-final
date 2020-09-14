User.create(email: 'sy@gmail.com', password: 'password')
User.create(email: 'nico@gmail.com', password: 'password')
User.create(email: 'sheila@gmail.com', password: 'password')

Restaurant.create(name: "I Love Dumplings", address: '298 Bridge Rd, Richmond VIC 3121, Australia', user: User.first)
Restaurant.create(name: "Pick A Pokit", address: '106 Swan St, Cremorne VIC 3121, Australia', user: User.first)
Restaurant.create(name: "Feast of Merit", address: '2117 Swan St, Richmond VIC 3121, Australia', user: User.first)
