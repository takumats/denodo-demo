-- 既存テーブルのクリーンアップ
DROP TABLE IF EXISTS t_contract_history;
DROP TABLE IF EXISTS m_products;
DROP TABLE IF EXISTS m_customers;

-- 1. 顧客マスタ
CREATE TABLE m_customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    industry VARCHAR(50),
    region VARCHAR(50)
);

-- 2. 製品マスタ
CREATE TABLE m_products (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50)
);

-- 3. 契約実績テーブル
CREATE TABLE t_contract_history (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES m_customers(id),
    product_id INTEGER REFERENCES m_products(id),
    amount DECIMAL(12, 2) NOT NULL,
    contract_date DATE NOT NULL
);

-- 「それっぽい」仮想企業名 30社の投入
INSERT INTO m_customers (name, industry, region) VALUES
('未来創生ソリューションズ', 'IT', '東京'), ('極東マテリアル', '製造', '大阪'), ('サステナ・リテール', '小売', '福岡'),
('光通信システム', '通信', '東京'), ('東和精密機器', '製造', '名古屋'), ('日本橋ファイナンシャル', '金融', '東京'),
('デジタル・エッジ', 'IT', '札幌'), ('フロンティア・バイオ', '医療', '大阪'), ('三都商事', '商社', '名古屋'),
('ネクスト・ロジスティクス', '運輸', '福岡'), ('大和クラウド', 'IT', '東京'), ('帝国重工', '製造', '名古屋'),
('銀座コンサルティング', 'サービス', '東京'), ('瀬戸内シーフーズ', '小売', '広島'), ('北国エネルギー', 'インフラ', '札幌'),
('エコロジー・テクノ', '環境', '大阪'), ('グローバル・キャリア', '人材', '東京'), ('スマート・ライフ・デザイン', '小売', '福岡'),
('アドバンスド・ロボティクス', '製造', '名古屋'), ('和食フードサービス', '外食', '大阪'), ('サイバー・シールド', 'IT', '東京'),
('トータル・不動産', '不動産', '東京'), ('サンシャイン・ソーラー', 'インフラ', '広島'), ('メディカル・コア', '医療', '札幌'),
('オーシャン・トラベル', '観光', '福岡'), ('プロフェッショナル・タックス', 'サービス', '大阪'), ('クリエイティブ・ラボ', 'IT', '東京'),
('ミライ・モビリティ', '製造', '名古屋'), ('都市型アグリカルチャー', '農業', '札幌'), ('ハピネス・エンタープライズ', 'サービス', '福岡');

-- 製品データ
INSERT INTO m_products (product_name, category) VALUES
('Denodo Platform 9', 'License'), ('Denodo Standard', 'License'),
('Expert Support 24/7', 'Service'), ('Professional Services', 'Service'),
('Self-Paced Training', 'Education');

-- 1,000件の契約実績をランダム生成
-- 2025年1月1日〜12月31日の期間で分散
INSERT INTO t_contract_history (customer_id, product_id, amount, contract_date)
SELECT
    floor(random() * 30 + 1)::int,
    floor(random() * 5 + 1)::int,
    floor(random() * 2000000 + 300000)::decimal, -- 30万〜230万
    CAST('2025-01-01' AS DATE) + (random() * 364)::int
FROM generate_series(1, 1000);
