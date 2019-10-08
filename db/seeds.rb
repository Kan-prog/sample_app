# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Genre.create(id:1, name:'イス・ソファー')
Genre.create(id:2, name:'机・テーブル')
Genre.create(id:3, name:'冷蔵庫')
Genre.create(id:4, name:'教科書')
Genre.create(id:5, name:'本')
Genre.create(id:6, name:'文房具')
Genre.create(id:7, name:'その他家具')
Genre.create(id:8, name:'衣類')
Genre.create(id:9, name:'実験器具')
Genre.create(id:10, name:'テレビ')
Genre.create(id:11, name:'電子レンジ')
Genre.create(id:12, name:'トースター')
Genre.create(id:13, name:'キッチン用品')
Genre.create(id:14, name:'ベッド')
Genre.create(id:15, name:'棚')
Genre.create(id:16, name:'カーペット')
Genre.create(id:17, name:'その他家電製品')
Genre.create(id:18, name:'その他雑貨')
Genre.create(id:19, name:'スキル')
Genre.create(id:20, name:'勉強')


College.create(id:1, name:'名古屋工業大学', last_email:'nitech.ac.jp')
College.create(id:2, name:'名古屋大学', last_email:'nagoya-u.jp')
College.create(id:3, name:'名古屋市立大学', last_email:'nagoya-cu.ac.jp')
College.create(id:4, name:'名古屋外国語大学', last_email:'nufs.ac.jp')
College.create(id:5, name:'中京大学', last_email:'chukyo-u.ac.jp')
College.create(id:6, name:'名古屋学院大学', last_email:'ngu.ac.jp')
College.create(id:7, name:'愛知学院大学', last_email:'agu.ac.jp')
College.create(id:8, name:'金城学院大学', last_email:'kinjo-u.ac.jp')
College.create(id:9, name:'名城大学', last_email:'meijo-u.ac.jp')
College.create(id:10, name:'南山大学', last_email:'nanzan-u.ac.jp')
College.create(id:11, name:'愛知大学', last_email:'aichi-u.ac.jp')
College.create(id:12, name:'愛知淑徳大学', last_email:'aasa.ac.jp')
College.create(id:13, name:'椙山女学園大学', last_email:'sugiyama-u.ac.jp')
College.create(id:14, name:'名古屋経済大学', last_email:'nagoya-ku.ac.jp')
College.create(id:15, name:'大同大学', last_email:'daido-it.ac.jp')
College.create(id:16, name:'名古屋女子大学', last_email:'nagoya-wu.ac.jp')
College.create(id:17, name:'同朋大学', last_email:'doho.ac.jp')
College.create(id:18, name:'愛知東邦大学', last_email:'aichi-toho.ac.jp')
College.create(id:19, name:'豊田工業大学', last_email:'toyota-ti.ac.jp')
College.create(id:20, name:'東海学園大学', last_email:'tokaigakuen-u.ac.jp')
College.create(id:21, name:'愛知工業大学', last_email:'aitech.ac.jp')
College.create(id:22, name:'愛知県立大学', last_email:'aichi-fam-u.ac.jp')
College.create(id:23, name:'名古屋音楽大学', last_email:'meion.ac.jp')


AdminUser.create!(email: 'forwkan@gmail.com', password: 'tradmin#f$u%s', password_confirmation: 'tradmin#f$u%s') if Rails.env.development? || Rails.env.production?




