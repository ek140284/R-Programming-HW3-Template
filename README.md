[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/52wHQ_hS)
# R-Programming-HW3-Template

フォルダー内、HW3.RとSSDSE.rdsファイルがあります。
SSDSE.rdsは課題用のデータ、必ずこのフォルダー内のデータを使用してください。
課題はすべて、HW3.Rに記載してください。
今回の課題に関係ないものが記載されても、採点されません。


課題

SSDSE.rds ファイルを R に読み込み、`raw` オブジェクトとして保存した上で、以下のデータ処理に取り組むこと。使用する変数は以下の通りである。可能な限り、パイプ演算子を使用すること。

| 日本語ラベル | 元変数名 | 変更後変数名 |
|:---|:---|:---|
| 年度 | SSDSE.B.2026 | year |
| 地域コード | Code | code |
| 都道府県 | Prefecture | prefecture |
| 総人口 | A1101 | pop |
| 大学数 | E6102 | university |
| 高等学校数 | E4101 | highschool |
| 中学校数 | E3101 | juniorhigh |
| 小学校数 | E2101 | elementary |

1. 上記変数のみを抽出して、変数名を`変更後変数名`に変えて、`df1`として保存せよ。

2. `df1`から2018年以降のデータのみを抽出し、`df2`として保存せよ。

3. `df2`から東北地方（青森・岩手・宮城・秋田・山形・福島）のデータを抽出して、`df3`として保存せよ。ただし、抽出するときは、都道府県名の変数ではなく、`地域コード`を用いて抽出してください。日本語文字列を使うと、サーバー上で文字コードの問題により正常に動作しなくなります。

4. `df3`を用いて、人口10万人あたりの小学校数、中学校数、高等学校数と大学数の変数を新たに作成し、それぞれ`elementary_rate`,`juniorhigh_rate`,`highschool_rate`,`university_rate`の変数名をつけて、`df4`として保存せよ。

5. `df4`を用いて、都道府県ごとに人口10万人あたりの小学校数、中学校数、高等学校数と大学数の長期平均を計算し、それぞれ`elementary_mean`,`juniorhigh_mean`,`highschool_mean`,`university_mean`の変数名をつけて、集計したデータを`df5`として保存せよ。

6. `df4`を用いて、都道府県ごとに小学校数合計、中学校数合計、高等学校数合計と大学数合計を計算し、それぞれ`elementary_total`,`juniorhigh_total`,`highschool_total`,`university_total`の変数名をつけて、集計したデータを`df6`として保存せよ。

7. `df5`を用いて、人口10万人当たり大学数の高い順に並び替え、`rank_df` として保存せよ。