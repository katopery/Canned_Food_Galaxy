# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 管理者ログイン用
Admin.create!(
   email: 'admin@admin',
   password: 'testtest'
)

Tag.create([
    { canned_tag_id: 1, name: 'フルーツ' },
    { canned_tag_id: 2, name: 'やきとり・とり' },
    { canned_tag_id: 3, name: '肉類' },
    { canned_tag_id: 4, name: 'ジビエ・馬肉' },
    { canned_tag_id: 5, name: 'オイルサーディン' },
    { canned_tag_id: 6, name: 'サバ' },
    { canned_tag_id: 7, name: 'サンマ' },
    { canned_tag_id: 8, name: 'ツナ/マグロ' },
    { canned_tag_id: 9, name: '貝類' },
    { canned_tag_id: 10, name: 'その他魚介類' },
    { canned_tag_id: 11, name: 'カレー' },
    { canned_tag_id: 12, name: '米類' },
    { canned_tag_id: 13, name: 'おそうざい系' },
    { canned_tag_id: 14, name: '漬物・サラダ' },
    { canned_tag_id: 15, name: 'スープ・ソース' },
    { canned_tag_id: 16, name: 'お菓子・スナック類' },
    { canned_tag_id: 17, name: 'その他' }
    ])