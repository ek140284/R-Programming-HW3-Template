# =====================================================
# HW3 自動採点プログラム
# =====================================================
# assignment を読み込む
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
rm(list = ls())
source("HW3.R")

# 採点用ユーティリティ関数
check <- function(cond, msg_ok, msg_ng) {
  # tryCatch でエラーを握りつぶし、不正解扱いにする
  cond_eval <- tryCatch(isTRUE(cond), error = function(e) FALSE)
  if (cond_eval) {
    cat(msg_ok, "\n")
    return(1)
  } else {
    cat(msg_ng, "\n")
    return(0)
  }
}
score <- 0

# ------------------------------
# Q1 df1 の構造と内容
# ------------------------------
required_vars1 <- c("year", "prefecture", "pop", "university",
                    "highschool", "juniorhigh", "elementary")

score <- score + check(
  exists("df1") &&
    is.data.frame(df1) &&
    nrow(df1) == 564 &&
    all(required_vars1 %in% names(df1)),
  "Q1 正解：df1の構造（行数・列名）は正しいです",
  "Q1 不正解：df1の構造（行数・列名）に問題があります"
)

# 内容のチェック（HW3.R コメントの期待値に基づく）
score <- score + check(
  exists("df1") &&
    abs(mean(df1$pop,        na.rm = TRUE) - 2690688) < 1 &&
    abs(mean(df1$university, na.rm = TRUE) - 16.78)   < 0.01 &&
    abs(mean(df1$highschool, na.rm = TRUE) - 104.37)  < 0.01 &&
    abs(mean(df1$juniorhigh, na.rm = TRUE) - 219.4)   < 0.1  &&
    abs(mean(df1$elementary, na.rm = TRUE) - 427.5)   < 0.1,
  "Q1（内容）正解：df1の数値は正しいです",
  "Q1（内容）不正解：df1の数値が誤っています"
)

# ------------------------------
# Q2 df2（2018年以降）
# ------------------------------
score <- score + check(
  exists("df2") &&
    is.data.frame(df2) &&
    nrow(df2) == 282 &&
    all(df2$year >= 2018),
  "Q2 正解：df2は2018年以降のデータです",
  "Q2 不正解：df2が誤っています（行数または年度フィルタ）"
)

score <- score + check(
  exists("df2") &&
    abs(mean(df2$pop,        na.rm = TRUE) - 2674639) < 1 &&
    abs(mean(df2$university, na.rm = TRUE) - 16.96)   < 0.01 &&
    abs(mean(df2$highschool, na.rm = TRUE) - 103.3)   < 0.1 &&
    abs(mean(df2$juniorhigh, na.rm = TRUE) - 215.1)   < 0.1 &&
    abs(mean(df2$elementary, na.rm = TRUE) - 413.6)   < 0.1,
  "Q2（内容）正解：df2の数値は正しいです",
  "Q2（内容）不正解：df2の数値が誤っています"
)

# ------------------------------
# Q3 df3（東北6県）
# ------------------------------
tohoku <- c("青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県")

score <- score + check(
  exists("df3") &&
    is.data.frame(df3) &&
    nrow(df3) == 36 &&
    all(df3$prefecture %in% tohoku) &&
    length(unique(df3$prefecture)) == 6,
  "Q3 正解：df3は東北6県のデータです",
  "Q3 不正解：df3が誤っています（東北6県のフィルタを確認）"
)

score <- score + check(
  exists("df3") &&
    abs(mean(df3$pop,        na.rm = TRUE) - 1426200) < 1 &&
    abs(mean(df3$university, na.rm = TRUE) - 8.528)   < 0.01 &&
    abs(mean(df3$highschool, na.rm = TRUE) - 77.94)   < 0.01 &&
    abs(mean(df3$juniorhigh, na.rm = TRUE) - 158.1)   < 0.1 &&
    abs(mean(df3$elementary, na.rm = TRUE) - 297.6)   < 0.1,
  "Q3（内容）正解：df3の数値は正しいです",
  "Q3（内容）不正解：df3の数値が誤っています"
)

# ------------------------------
# Q4 df4（人口10万人あたりのrate変数）
# ------------------------------
required_vars4 <- c("elementary_rate", "juniorhigh_rate",
                    "highschool_rate", "university_rate")

score <- score + check(
  exists("df4") &&
    is.data.frame(df4) &&
    nrow(df4) == 36 &&
    all(required_vars4 %in% names(df4)),
  "Q4 正解：df4のrate変数は揃っています",
  "Q4 不正解：df4のrate変数が不足しています"
)

# 計算式の正確性チェック
score <- score + check(
  exists("df4") &&
    isTRUE(all.equal(df4$elementary_rate, df4$elementary / df4$pop * 100000)) &&
    isTRUE(all.equal(df4$juniorhigh_rate, df4$juniorhigh / df4$pop * 100000)) &&
    isTRUE(all.equal(df4$highschool_rate, df4$highschool / df4$pop * 100000)) &&
    isTRUE(all.equal(df4$university_rate, df4$university / df4$pop * 100000)),
  "Q4（計算）正解：rate変数の計算式は正しいです",
  "Q4（計算）不正解：rate変数の計算式が誤っています"
)

# ------------------------------
# Q5 df5（都道府県ごとの長期平均）
# ------------------------------
required_vars5 <- c("prefecture", "elementary_mean", "juniorhigh_mean",
                    "highschool_mean", "university_mean")

score <- score + check(
  exists("df5") &&
    is.data.frame(df5) &&
    nrow(df5) == 6 &&
    all(required_vars5 %in% names(df5)),
  "Q5 正解：df5の構造は正しいです",
  "Q5 不正解：df5の構造（行数・列名）が誤っています"
)

score <- score + check(
  exists("df5") &&
    abs(mean(df5$elementary_mean) - 21.34)  < 0.01 &&
    abs(mean(df5$juniorhigh_mean) - 11.290) < 0.01 &&
    abs(mean(df5$highschool_mean) - 5.641)  < 0.01 &&
    abs(mean(df5$university_mean) - 0.6138) < 0.001,
  "Q5（内容）正解：df5の集計値は正しいです",
  "Q5（内容）不正解：df5の集計値が誤っています"
)

# ------------------------------
# Q6 df6（都道府県ごとの合計）
# ------------------------------
required_vars6 <- c("prefecture", "elementary_total", "juniorhigh_total",
                    "highschool_total", "university_total")

score <- score + check(
  exists("df6") &&
    is.data.frame(df6) &&
    nrow(df6) == 6 &&
    all(required_vars6 %in% names(df6)),
  "Q6 正解：df6の構造は正しいです",
  "Q6 不正解：df6の構造（行数・列名）が誤っています"
)

score <- score + check(
  exists("df6") &&
    abs(mean(df6$elementary_total) - 1786)  < 1 &&
    abs(mean(df6$juniorhigh_total) - 948.8) < 0.1 &&
    abs(mean(df6$highschool_total) - 467.7) < 0.1 &&
    abs(mean(df6$university_total) - 51.17) < 0.01,
  "Q6（内容）正解：df6の集計値は正しいです",
  "Q6（内容）不正解：df6の集計値が誤っています"
)

# ------------------------------
# Q7 rank_df（大学数の高い順にソート）
# ------------------------------
score <- score + check(
  exists("rank_df") &&
    is.data.frame(rank_df) &&
    nrow(rank_df) == 6 &&
    "university_mean" %in% names(rank_df) &&
    !is.unsorted(-rank_df$university_mean),
  "Q7 正解：rank_dfは大学数の高い順に並んでいます",
  "Q7 不正解：rank_dfのソート順が誤っています"
)

# ------------------------------
# 最終結果
# ------------------------------
cat("\n===== 採点終了 =====\n")
cat("総得点：", score, "/13\n")
