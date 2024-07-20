# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# rails c -e production　でEC2のコンソールから直接入力することも可能
#
admin = Admin.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |admin|
  admin.password = ENV['ADMIN_PASSWORD']
end

ruby = User.find_or_create_by!(email: ENV['USER_1_EMAIL']) do |user|
  user.name = "Ruby"
  user.password = ENV['USER_1_PASSWORD']
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.png"), filename:"sample-user1.png")
end

sapphire = User.find_or_create_by!(email: ENV['USER_2_EMAIL']) do |user|
  user.name = "Sapphire"
  user.password = ENV['USER_2_PASSWORD']
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.png"), filename:"sample-user2.png")
end

emerald = User.find_or_create_by!(email: ENV['USER_3_EMAIL']) do |user|
  user.name = "Emerald"
  user.password = ENV['USER_3_PASSWORD']
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.png"), filename:"sample-user3.png")
end

topaz = User.find_or_create_by!(email: ENV['USER_4_EMAIL']) do |user|
  user.name = "Topaz"
  user.password = ENV['USER_4_PASSWORD']
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user4.png"), filename:"sample-user4.png")
end

iolite = User.find_or_create_by!(email: ENV['USER_5_EMAIL']) do |user|
  user.name = "Iolite"
  user.password = ENV['USER_5_PASSWORD']
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user5.png"), filename:"sample-user5.png")
end

lapislazuli = User.find_or_create_by!(email: ENV['USER_6_EMAIL']) do |user|
  user.name = "Lapislazuli"
  user.password = ENV['USER_6_PASSWORD']
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user6.png"), filename:"sample-user6.png")
end

DiaryRecord.find_or_create_by!(title: "英単語を５つ覚えた") do |diary_record|
  diary_record.diary_record_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/diary_record1.jpg"), filename:"diary_record1.jpg")
  diary_record.background_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/red_background.jpg"), filename:"red_background.jpg")
  diary_record.body = "beat(倒す、鳴らす、鼓動),enough(十分な、十分に),destruction(破壊),upon(その上),rest assured(安心してください)"
  diary_record.category = "英語　語学学習"
  diary_record.user = ruby
end

DiaryRecord.find_or_create_by!(title: "英単語を４つ覚えた") do |diary_record|
  diary_record.diary_record_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/diary_record2.png"), filename:"diary_record2.png")
  diary_record.background_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/purple_background.jpg"), filename:"purple_background.jpg")
  diary_record.body = "several(いくつかの),compliments(誉め言葉),former(前者),eventuality(最終的に)"
  diary_record.category = "英語　語学学習"
  diary_record.user = ruby
end

DiaryRecord.find_or_create_by!(title: "クロッキーを１５分やった") do |diary_record|
  diary_record.diary_record_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/diary_record3.png"), filename:"diary_record3.png")
  diary_record.background_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/skyblue_background.jpg"), filename:"purple_background.jpg")
  diary_record.body = "３種類のポーズを描いた。一体当たり５分。余った時間で影も入れた。立体を意識して描けるように練習中。"
  diary_record.category = "イラスト　クロッキー　デッサン"
  diary_record.user = sapphire
end

DiaryRecord.find_or_create_by!(title: "ドイツ語を少し覚えた！") do |diary_record|
  diary_record.diary_record_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/diary_record4.jpg"), filename:"diary_record4.jpg")
  diary_record.background_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/green_background.jpg"), filename:"green_background.jpg")
  diary_record.body = "so(だから),also(それで),einer(１つ),bist(～は(duに付く)),du(あなた),jugend(若者、青春),gedenken(記念する)/
  soは原因と結果の関係を表し、alsoは既に述べられた事柄に基づき、新しい情報を導入するときに使う。「雨が降っているから家にいる」という場合はsoを使う。
  「空腹を感じたので食べに行く」という場合はalsoを使う。"
  diary_record.category = "ドイツ語　語学学習"
  diary_record.user = emerald
end

DiaryRecord.find_or_create_by!(title: "筋力トレーニング１時間達成") do |diary_record|
  diary_record.diary_record_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/diary_record5.png"), filename:"diary_record5.png")
  diary_record.background_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/yellow_background.jpg"), filename:"yellow_background.jpg")
  diary_record.body = "ヒートトレーニング５分×６セット＆腹筋５分×３セット＆腕立て伏せ５分＆プランク５分×２セット　気分爽快！明日も頑張る！！"
  diary_record.category = "筋力トレーニング　筋トレ　腹筋　腕立て伏せ　プランク　ヒートトレーニング"
  diary_record.user = topaz
end

DiaryRecord.find_or_create_by!(title: "筋力トレーニング＆プランク") do |diary_record|
  diary_record.diary_record_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/diary_record6.png"), filename:"diary_record6.png")
  diary_record.background_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/skyblue_background.jpg"), filename:"skyblue_background.jpg")
  diary_record.body = "腹筋５分＆腕立て伏せ５分＆プランク５分。"
  diary_record.category = "筋力トレーニング　筋トレ　腹筋　腕立て伏せ　プランク"
  diary_record.user = iolite
end

DiaryRecord.find_or_create_by!(title: "ボイストレーニング１５分") do |diary_record|
  diary_record.diary_record_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/diary_record7.png"), filename:"diary_record7.png")
  diary_record.background_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/skyblue_background.jpg"), filename:"skyblue_background.jpg")
  diary_record.body = "動画サイトのトレーニングを１５分。肺活量をもっと鍛えたほうがいいかも？"
  diary_record.category = "ボイストレーニング　ボイトレ"
  diary_record.user = iolite
end

Group.find_or_create_by!(name: "語学学習組") do |group|
  group.group_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/diary_record2.png"), filename:"diary_record2.png")
  group.introduction = "語学学習中のグループです"
  group.theme = "１日３つ以上単語を覚えよう"
  group.rule = "各自のペースで投稿"
  group.owner = ruby
end