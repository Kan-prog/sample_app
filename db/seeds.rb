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

College.create(id:1, name:'名古屋工業大学', last_email:'stn.nitech.ac.jp')
College.create(id:2, name:'名古屋大学', last_email:'nagoya-u.jp')
College.create(id:3, name:'名古屋市立大学', last_email:'ed.nagoya-cu.ac.jp')
College.create(id:4, name:'名古屋外国語大学', last_email:'nufs.ac.jp')

User.create(id:1, name:'test1', email:'test1@example.com', password:'test11', password_confirmation:'test11', activated:true, grade:'B1', gender:'男', college_id:'1')
User.create(id:2, name:'test2', email:'test2@example.com', password:'test22', password_confirmation:'test22', activated:true, grade:'B2', gender:'男', college_id:'2')
User.create(id:3, name:'test3', email:'test3@example.com', password:'test33', password_confirmation:'test33', activated:true, grade:'B3', gender:'女', college_id:'3')
User.create(id:4, name:'test4', email:'test4@example.com', password:'test44', password_confirmation:'test44', activated:true, grade:'B4', gender:'女', college_id:'4')




