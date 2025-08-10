# SOW: `erb_lint-tailwindcss` – Tailwind CSS クラス整形リンター

## 1) 背景と目的

Rails などで使われる `.html.erb` テンプレート内の `class` 属性には、Tailwind CSS のユーティリティクラスが多く記述される。
現状では、クラス順序や重複、不正クラスの検出・整形を **`.html.erb` 向けに自動化する仕組みが不足**しており、コードの可読性・一貫性の低下、無駄な差分発生、デバッグ性低下を招いている。

本プロジェクトの目的は、**`erb_lint` のカスタムリンターとして Tailwind CSS クラスリストのチェックと自動整形（autocorrect）を提供する Gem を開発・配布すること**である。

---

## 2) 提供物

* **Gemパッケージ**：`erb_lint-tailwindcss`
* **カスタムリンター**（3種）

  1. `Tailwind/ClassOrder` – クラス順序の検出と並び替え（autocorrect 対応）
  2. `Tailwind/Duplicate` – 重複クラスの検出と削除（autocorrect 対応）
  3. `Tailwind/Unknown` – 未定義クラスの検出（検出のみ、autocorrect非対応）
* **辞書・順序テーブル**

  * Tailwind v4 の公式順序（`prettier-plugin-tailwindcss` を基準に生成）
  * プラグインや safelist の拡張対応
* **設定ファイル**

  * `config/tailwind.yml` – 推奨設定
  * `.erb-lint.yml.example` – サンプル設定
* **導入用スクリプト**

  * `.erb-linters/erb_lint-tailwindcss.rb`（`require` エントリ）
* **テスト**

  * RSpecによるユニットテストと統合テスト
* **README**

  * 導入方法、設定例、autocorrectの動作説明、制限事項

---

## 3) スコープ

### In Scope

* 対象：`**/*.html.erb`
* 対象属性：静的な `class="..."`（ERB式を含まない）
* チェック内容：

  1. **Order**：クラスが Tailwind 順序通りか
  2. **Duplicate**：同一クラスが重複していないか
  3. **Unknown**：存在しないクラスが含まれていないか
* 並び順・重複は安全な範囲で `--autocorrect` による自動整形に対応

### Out of Scope（MVP）

* 動的 ERB を含む `class`（例：`<%=` を含む場合は検出のみ）
* `clsx`/`class_names` 等の構造的クラス生成解析
* `data-` 属性や他フレームワークのクラス束ね構文

---

## 4) 実装仕様

### 共通仕様

* `ERBLint::Linter` を継承し `include LinterRegistry` で登録
* `run(processed_source)`：ASTから `class` 属性を抽出、静的値のみ解析
* `autocorrect(processed_source, offense)`：`RuboCop::Cop::Corrector` を使って属性値のみ置換
* autocorrectの安全策：

  * 動的式（`<%=`）を含む場合は修正せず警告のみ
  * 置換は `"..."` 内部のみ
  * 複数置換時は後方から適用してレンジ破綻防止
  * 空白や改行の正規化は最小限（diffを抑える）

---

## 5) クラス順序照合（A案）

### 基準

* **公式 `prettier-plugin-tailwindcss` のクラス順序 / variant順序 / 任意値ルールを“正”とする**
* プラグインのロジックに追随し、クラス順のズレを正確に検出・修正する

### 順序テーブル生成フロー

1. `npm install prettier-plugin-tailwindcss@<固定バージョン>`
2. Nodeスクリプトで `classOrder`, `variantOrder`, `arbitraryPropertyOrder` を抽出
3. 抽出結果を YAML/JSON に変換し `lib/erb_lint-tailwindcss/support/order_table.json` に格納
4. Gemに同梱してランタイムで読み込み
5. 更新時は `rake update_order_table` タスクで再生成し、テストで正規性確認

### 並び替えアルゴリズム

* **トークナイズ**：各クラスを `{variants: [...], base: 'bg-red-500', important: false}` に分解
* **variant の重み付け**：`variantOrder` に従ってチェーン順を決定
* **base utility の重み付け**：`classOrder` の正規表現マッチ順で決定
* **その他キー**：importantフラグ、任意値パターン、アルファベット順（unknownクラス）などで安定化
* **照合**：元の並びと比較し、差異があればoffense登録
* **autocorrect**：期待順に並べ替えたクラスリストを属性値に置換

---

## 6) ディレクトリ構成（例）

```
erb_lint-tailwindcss/
├─ erb_lint-tailwindcss.gemspec
├─ Gemfile
├─ lib/
│  ├─ erb_lint-tailwindcss.rb                  # エントリポイント
│  ├─ erb_lint-tailwindcss/linters.rb          # まとめrequire
│  ├─ erb_lint-tailwindcss/linters/
│  │   └─ tailwind/
│  │       ├─ class_order.rb
│  │       ├─ duplicate.rb
│  │       └─ unknown.rb
│  ├─ erb_lint-tailwindcss/support/
│  │   ├─ tokenizer.rb
│  │   ├─ sorter.rb
│  │   ├─ order_table.json
│  │   └─ dictionary.rb
├─ config/
│  └─ tailwind.yml
├─ spec/
│  └─ ...
├─ .erb-lint.yml.example
└─ README.md
```

---

## 7) 設定例

```yaml
inherit_gem:
  erb_lint-tailwindcss: config/tailwind.yml

linters:
  Tailwind/ClassOrder:
    enabled: true
    order_preset: "tailwind-v4"
    grouping: "flat"
  Tailwind/Duplicate:
    enabled: true
    dedupe_across_variants: false
  Tailwind/Unknown:
    enabled: true
    allow_arbitrary_values: true
    safelist: ["container", "prose"]
    plugins: ["@tailwindcss/typography"]
```

---

## 8) スケジュール（MVP）

| 週   | 作業                                  |
| --- | ----------------------------------- |
| 1週目 | Gem雛形作成、Nodeスクリプトで順序テーブル生成          |
| 2週目 | Tokenizer & Sorter 実装、ClassOrder 完成 |
| 3週目 | Duplicate, Unknown 実装、テスト整備         |
| 4週目 | 実プロジェクト検証、README作成、リリース             |

---

## 9) 受け入れ基準

* 静的 `class` の順序・重複・未知クラスを正しく検出
* 並び順・重複は `--autocorrect` で修正可能
* 動的式を含む `class` は検出のみ
* 実プロジェクトの `.html.erb` 200+ ファイルで破壊的変更ゼロ

---

## 10) 将来拡張

* 動的式の部分的解析（安全に分離可能な場合のみ）
* `variants-grouped` モードなど可読性重視の並び方
* 外部CI連携用レポート出力（JSON）
* haml, slim サポート
