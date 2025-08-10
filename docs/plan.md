# `erb_lint-tailwindcss` Gem 開発計画（順序テーブル作成強化版）

## 1週目: 基盤整備とNode.js順序抽出システム
### Gem 雛形作成
- **gemspec 更新**: `erb_lint` 依存関係追加、Node.js 実行環境設定
- **ディレクトリ構成**: SOW準拠の `lib/erb_lint-tailwindcss/` 構造作成

### Node.js 順序テーブル生成システム（重点強化）
- **Node.js 環境構築**:
  - `package.json` 作成（ESM対応、Node.js 18+）
  - `prettier-plugin-tailwindcss@^0.6.14` インストール
  
- **順序抽出スクリプト作成** (`scripts/extract_order.mjs`):
  - プラグインの内部ソートロジックを直接実行
  - 大量のサンプルクラスを投入して順序パターンを抽出
  - バリアント順序、ベースユーティリティ順序、重要度順序を解析
  
- **Rubyコード生成**:
  - 抽出した順序データを `lib/erb_lint-tailwindcss/order_table.rb` として生成
  - 正規表現パターンとウェイト値のハッシュ形式で出力
  - `TAILWIND_CLASS_ORDER` 定数として定義

- **自動化タスク**:
  - `rake update_order_table` タスク作成
  - CI/CDでの順序テーブル更新検証

### 順序抽出の技術的アプローチ
1. **サンプリング手法**: 全Tailwind CSS クラス（~500種）を網羅的にテスト
2. **パターン認識**: 色、サイズ、レイアウト等のカテゴリ別順序ルール抽出  
3. **バリアント処理**: `hover:`, `sm:`, `dark:` 等の優先度ルール解析
4. **Ruby最適化**: 高速検索用のデータ構造（配列インデックス、ハッシュテーブル）

## 2週目: コア機能実装
### Tokenizer & Sorter 実装
- **Tokenizer**: 生成された順序テーブルを使用したクラス分解
- **Sorter**: Rubyネイティブな高速ソートアルゴリズム
- **ClassOrder リンター**: autocorrect 対応の完全実装

## 3週目: 追加リンター実装
### Duplicate & Unknown リンター + テスト整備
- **Duplicate/Unknown リンター**: 順序テーブル連携実装
- **包括的テスト**: 順序テーブルの正確性検証含む

## 4週目: 仕上げとリリース
### 検証・ドキュメント・リリース準備
- **順序一致検証**: prettier-plugin-tailwindcss との100%一致確認
- **パフォーマンステスト**: 大規模プロジェクトでの性能検証
- **完全なドキュメント**: 順序テーブル更新手順含む

## 技術的優位点
- **完全互換**: prettier-plugin-tailwindcss と同一の順序保証
- **Ruby最適化**: Node.js実行不要の高速処理
- **自動更新**: Tailwind CSS バージョンアップ追従の自動化