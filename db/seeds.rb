# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "seedの実行を開始"
# 管理者ログイン用
Admin.create!(
   email: 'admin@admin',
   password: ENV['SECRET_KEY']
)

Tag.create([
    { canned_tag_id: 1  , name: 'やきとり・とり' },
    { canned_tag_id: 2  , name: '牛・豚' },
    { canned_tag_id: 3  , name: 'その他肉類' },
    { canned_tag_id: 4  , name: 'イワシ' },
    { canned_tag_id: 5  , name: 'サバ' },
    { canned_tag_id: 5  , name: 'サンマ' },
    { canned_tag_id: 7  , name: 'ツナ/マグロ' },
    { canned_tag_id: 8  , name: '貝類' },
    { canned_tag_id: 9  , name: 'その他魚介類' },
    { canned_tag_id: 10 , name: 'カレー' },
    { canned_tag_id: 11 , name: '米類' },
    { canned_tag_id: 12 , name: 'おそうざい系' },
    { canned_tag_id: 13 , name: '野菜・漬物' },
    { canned_tag_id: 14 , name: 'フルーツ' },
    { canned_tag_id: 15 , name: 'スープ・ソース' },
    { canned_tag_id: 16 , name: 'お菓子・スナック類' },
    { canned_tag_id: 17 , name: 'その他' }
    ])
    

# 以下デプロイ、テスト用
# ゲスト会員用メールアドレス
GUEST_MEMBER_EMAIL = 'guest@example.com'
# 会員
Member.create!(
  [
    { id: 1  ,email: GUEST_MEMBER_EMAIL,  nickname: "ゲスト"            , phone_number: "XXXXXXXXXXX",  password: SecureRandom.urlsafe_base64, image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/no_image.jpg") , filename: "no_image.jpg" )},
    { id: 2  ,email: "test1@example.com", nickname: "イナバー"          , phone_number: "1111111111",   password: "111111", image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/test_member_01.png")  , filename: "test_member_01.png" )},
    { id: 3  ,email: "test2@example.com", nickname: "マルハニッチ"      , phone_number: "2222222222",   password: "111111", image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/test_member_02.png")  , filename: "test_member_02.png" )},
    { id: 4  ,email: "test3@example.com", nickname: "日東ベター"        , phone_number: "3333333333",   password: "111111", image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/test_member_03.png")  , filename: "test_member_03.png" )},
    { id: 5  ,email: "test4@example.com", nickname: "nisuiii"           , phone_number: "4444444444",   password: "111111", image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/test_member_04.png")  , filename: "test_member_04.png" )},
    { id: 6  ,email: "test5@example.com", nickname: "モリヤマ"          , phone_number: "55555555555",  password: "111111", image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/test_member_05.png")  , filename: "test_member_05.png" )},
    { id: 7  ,email: "test6@example.com", nickname: "トレジャーラック"  , phone_number: "66666666666",  password: "111111", image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/test_member_06.png")  , filename: "test_member_06.png" )},
    { id: 8  ,email: "test7@example.com", nickname: "はごもろfoods"     , phone_number: "77777777777",  password: "111111", image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/test_member_07.png")  , filename: "test_member_07.png" )},
    { id: 9  ,email: "test8@example.com", nickname: "ホテイ"            , phone_number: "88888888888",  password: "111111", image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/test_member_08.png")  , filename: "test_member_08.png" )},
    { id: 10 ,email: "test9@example.com", nickname: "kikko"             , phone_number: "99999999999",  password: "111111", image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/test_member_09.png")  , filename: "test_member_09.png" )}
  ]
)

# 投稿内容
DISCRIPTION = 
'缶詰情報
・内容量
・原材料
・栄養成分
・保存期間
・保存方法
・アレルギー情報
・製造者'
# 缶詰
CannedFood.create!(
  [
    { id: 1   , canned_name: "やきとり"   , description: DISCRIPTION, image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/canned_yakitori.png")     , filename: "canned_yakitori.png" )     , tag_ids: [1] },
    { id: 2   , canned_name: "コンビーフ" , description: DISCRIPTION, image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/canned_corned_beef.png")  , filename: "canned_corned_beef.png" )  , tag_ids: [2] },
    { id: 3   , canned_name: "にく"       , description: DISCRIPTION, image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/canned_meet.png")         , filename: "canned_meet.png" )         , tag_ids: [3] },
    { id: 4   , canned_name: "イワシ"     , description: DISCRIPTION, image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/canned_sardine.png")      , filename: "canned_sardine.png" )      , tag_ids: [4] },
    { id: 5   , canned_name: "サバ"       , description: DISCRIPTION, image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/canned_saba.png")         , filename: "canned_saba.png" )         , tag_ids: [5] },
    { id: 6   , canned_name: "サンマ"     , description: DISCRIPTION, image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/canned_sannma.png")       , filename: "canned_sannma.png" )       , tag_ids: [6] },
    { id: 7   , canned_name: "ツナ"       , description: DISCRIPTION, image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/canned_tuna.png")         , filename: "canned_tuna.png" )         , tag_ids: [7] },
    { id: 8   , canned_name: "あさり"     , description: DISCRIPTION, image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/canned_asari.png")        , filename: "canned_asari.png" )        , tag_ids: [8] },
    { id: 9   , canned_name: "カニみそ"   , description: DISCRIPTION, image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/canned_kanimiso.png")     , filename: "canned_kanimiso.png" )     , tag_ids: [9] },
    { id: 10  , canned_name: "カレー"     , description: DISCRIPTION, image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/canned_curry.png")        , filename: "canned_curry.png" )        , tag_ids: [10] },
    { id: 11  , canned_name: "米類"       , description: DISCRIPTION, image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/canned_rice.png")         , filename: "canned_rice.png" )         , tag_ids: [11] },
    { id: 12  , canned_name: "おでん"     , description: DISCRIPTION, image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/canned_oden.png")         , filename: "canned_oden.png" )         , tag_ids: [12] },
    { id: 13  , canned_name: "トマト"     , description: DISCRIPTION, image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/canned_tomato.png")       , filename: "canned_tomato.png" )       , tag_ids: [13] },
    { id: 14  , canned_name: "みかん"     , description: DISCRIPTION, image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/canned_orange.png")       , filename: "canned_orange.png" )       , tag_ids: [14] },
    { id: 15  , canned_name: "スープ"     , description: DISCRIPTION, image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/canned_soup.png")         , filename: "canned_soup.png" )         , tag_ids: [15] },
    { id: 16  , canned_name: "クラッカー" , description: DISCRIPTION, image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/canned_crackear.png")     , filename: "canned_crackear.png" )     , tag_ids: [16] },
    { id: 17  , canned_name: "パン"       , description: DISCRIPTION, image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/canned_bread.png")        , filename: "canned_bread.png" )        , tag_ids: [17] }
  ]
)

# レビュー
Review.create!(
  [
    { id: 1   , member_id: 2  , canned_food_id: 1, expiry_date_rating: 5, taste_rating: 5, snack_rating: 5, outdoor_rating: 5 },
    { id: 2   , member_id: 3  , canned_food_id: 1, expiry_date_rating: 5, taste_rating: 5, snack_rating: 1, outdoor_rating: 4 },
    { id: 3   , member_id: 4  , canned_food_id: 1, expiry_date_rating: 5, taste_rating: 4, snack_rating: 2, outdoor_rating: 3 },
    { id: 4   , member_id: 5  , canned_food_id: 1, expiry_date_rating: 5, taste_rating: 4, snack_rating: 3, outdoor_rating: 2 },
    { id: 5   , member_id: 6  , canned_food_id: 1, expiry_date_rating: 5, taste_rating: 3, snack_rating: 4, outdoor_rating: 1 },
    { id: 6   , member_id: 7  , canned_food_id: 1, expiry_date_rating: 5, taste_rating: 3, snack_rating: 4, outdoor_rating: 1 },
    { id: 7   , member_id: 8  , canned_food_id: 1, expiry_date_rating: 5, taste_rating: 2, snack_rating: 3, outdoor_rating: 1 },
    { id: 8   , member_id: 9  , canned_food_id: 1, expiry_date_rating: 5, taste_rating: 2, snack_rating: 2, outdoor_rating: 1 },
    { id: 9   , member_id: 10 , canned_food_id: 1, expiry_date_rating: 4, taste_rating: 1, snack_rating: 1, outdoor_rating: 1 },
    { id: 10  , member_id: 2  , canned_food_id: 2, expiry_date_rating: 5, taste_rating: 5, snack_rating: 5, outdoor_rating: 5 },
    { id: 11  , member_id: 2  , canned_food_id: 3, expiry_date_rating: 5, taste_rating: 5, snack_rating: 4, outdoor_rating: 4 },
    { id: 12  , member_id: 2  , canned_food_id: 4, expiry_date_rating: 5, taste_rating: 5, snack_rating: 1, outdoor_rating: 1 },
    { id: 13  , member_id: 3  , canned_food_id: 2, expiry_date_rating: 1, taste_rating: 2, snack_rating: 3, outdoor_rating: 4 },
    { id: 14  , member_id: 4  , canned_food_id: 3, expiry_date_rating: 1, taste_rating: 1, snack_rating: 1, outdoor_rating: 1 }
  ]
)

# コメント
Comment.create!(
  [
    { id: 1   , member_id: 2  , review_id: 1, content: "賞味期限が近く、食べ方を工夫したです。どんな料理にあいますか？" },
    { id: 2   , member_id: 3  , review_id: 1, content: "カレーにあいます。", image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/cook_curryrice.png")    , filename: "cook_curryrice.png" ) },
    { id: 3   , member_id: 4  , review_id: 1, content: "アウトドアにも使えますね。" },
    { id: 4   , member_id: 5  , review_id: 1, content: "いいですね。" },
    { id: 5   , member_id: 6  , review_id: 1, content: "親子丼もおいしいです。", image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/cook_oyakodon.png")     , filename: "cook_oyakodon.png" ) },
    { id: 6   , member_id: 7  , review_id: 1, content: "そのままでもお酒のつまみになります。" },
    { id: 7   , member_id: 8  , review_id: 1, content: "ピザトースト作ってみました。", image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/cook_pizza_toast.png")  , filename: "cook_pizza_toast.png" ) },
    { id: 8   , member_id: 9  , review_id: 1, content: "そのままご飯の上に乗っけました。", image: ActiveStorage::Blob.create_and_upload!( io: File.open("#{Rails.root}/db/fixtures/cook_yakitoridon.png")  , filename: "cook_yakitoridon.png" ) },
    { id: 9   , member_id: 10 , review_id: 1, content: "色々できますね。" },
    { id: 10  , member_id: 2  , review_id: 1, content: "情報ありがとうございます。" },
    { id: 11  , member_id: 2  , review_id: 2, content: "評価について意見をください。" },
    { id: 12  , member_id: 2  , review_id: 2, content: "おつまみにはいけますか？" },
    { id: 13  , member_id: 3  , review_id: 2, content: "〇〇のお酒と合います。" },
    { id: 14  , member_id: 2  , review_id: 2, content: "今度試してみます。" }
  ]
)

puts "seedの実行が完了しました"