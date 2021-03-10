# README

# テーブル設計

## users テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| name     | string | null: false |
| email    | string | null: false |
| password | string | null: false |

### Association

- has_many :records
- has_many :favorite

## records テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| user        | references | null: false, foreign_key: true |
| title       | string     | null: false                    |
| category_id | integer    | null: false                    |
| date        | date       | null: false                    |
| place       | string     | null: false                    |
| with        | string     |                                |
| text        | text       |                                |
| url         | string     |                                |
| status      | integer    | null: false                    |

### Association

- belongs_to :user
- has_many :favorite


## favorites テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| user        | references | null: false, foreign_key: true |
| record      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :record
