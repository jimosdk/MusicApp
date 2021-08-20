ActiveRecord::Base.transaction do
Band.destroy_all
User.destroy_all



Band.create!([
  {name: "Pink Floyd"},
  {name: "Aerosmith"},
  {name: "Iron Maiden"}
])

Album.create!([
  {title: "The Number of the Beast", year: "1982", live: true, band_id: 3},
  {title: "The Wall", year: "1979", live: false, band_id: 1},
  {title: "Fear of the Dark", year: "1992", live: false, band_id: 3}
])

User.create!([
  {name: "john", email: "john@mail", password:'123456',activated: true, admin: false},
  {name: "emma", email: "emma@mail", password:'123456',activated: true, admin: false},
  {name: "emily", email: "emily@mail", password:'123456', activated: true, admin: false},
  {name: "admin", email: "admin@mail", password:'123456', activated: true, admin: true}
])

Track.create!([
  {album_id: 1, title: "Children Of The Damned", ord: 2, lyrics: "He's walking like a small child\r\nBut watch his eyes burn you away\r\nBlack holes in his golden stare\r\nGod knows he wants to go home…", bonus: false},
  {album_id: 1, title: "The Prisoner", ord: 3, lyrics: "We want information, information, information\r\nWho are you?\r\nThe new number two\r\nWho is number one?…", bonus: false},
  {album_id: 1, title: "Invaders", ord: 1, lyrics: "Longboats have been sighted and the evidence of war\r\nHas begun, many Nordic fighting men, their swords and shields gleam\r\nIn the sun, call to arms, defend yourselves, get ready to stand and fight\r\nFor your lives, judgement day has come around, so be prepared, don't run...", bonus: false},
  {album_id: 1, title: "22 Acacia Avenue", ord: 4, lyrics: "If you're feelin' down depressed and lonely\r\nI know a place where we can go\r\n22 Acacia Avenue\r\nMeet a lady that I know…", bonus: false},
  {album_id: 1, title: "Run To The Hills", ord: 6, lyrics: "White man came across the sea\r\nHe brought us pain and misery\r\nHe killed our tribes, he killed our creed\r\nHe took our game for his own need…", bonus: false}
])

Note.create!([
  {user_id: 4, track_id: 2, description: "Great song!"},
  {user_id: 1, track_id: 2, description: "This is the worst track of this album..."}
])



end