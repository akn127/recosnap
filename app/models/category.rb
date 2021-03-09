class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: 'レジャー／アウトドア' },
    { id: 3, name: '旅行' },
    { id: 4, name: '音楽／ライブ／演芸' },
    { id: 5, name: '芸術／アート' },
    { id: 6, name: 'グルメ' },
    { id: 7, name: 'スポーツ' },
    { id: 8, name: 'イベント' },
    { id: 9, name: 'ショッピング' },
    { id: 10, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :records

end
